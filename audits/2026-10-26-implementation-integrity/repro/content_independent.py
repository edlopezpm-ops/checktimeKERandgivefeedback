"""Contract-derived pure probes, synthetic bytes only; no DB/provider/pytest hooks."""
import csv
from decimal import Decimal
from email.message import EmailMessage
from email import policy
from fractions import Fraction
import hashlib
import io
import json
from pathlib import Path
import random
import sys
import zipfile
from uuid import NAMESPACE_URL, uuid5

ROOT=Path(r'<SOURCE_ROOT>')
AUDIT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from app import client_drafts, flexfields, library, mail_service, quoting, time_import
from app.domain import DomainError
from app.forms import FormError

checks=[]
def check(name, action):
    try:
        action()
        checks.append({'name':name,'status':'PASS'})
    except Exception as error:
        checks.append({'name':name,'status':'FAIL','exception_type':type(error).__name__})

def equal(observed,expected):
    assert observed==expected,(observed,expected)

def rejects(action):
    try: action()
    except (DomainError,FormError): return
    raise AssertionError('Invalid input accepted')

def cents(value):
    integral,remainder=divmod(value.numerator*100,value.denominator)
    return Decimal(integral+int(remainder*2>=value.denominator)).scaleb(-2)

def quote_properties():
    rng=random.Random(99123)
    for sample in range(500):
        lines=[]; low=Fraction(0); high=Fraction(0); minutes_low=minutes_high=priced=0;unpriced=False
        for number in range(rng.randrange(1,9)):
            start=rng.randrange(0,2000);end=start+rng.randrange(0,100)
            row={'label':f'Novel synthetic task{sample}-{number}','min_minutes':start,'max_minutes':end}
            mode=rng.choice(['none','fixed_fee','time_and_materials'])
            minutes_low+=start;minutes_high+=end
            if mode=='none':unpriced=True
            else:
                priced+=1; amount=rng.randrange(0,999999)
                row['pricing_model']=mode
                row['fixed_amount' if mode=='fixed_fee' else 'unit_rate']=str(Decimal(amount).scaleb(-2))
                low+=Fraction(amount,100) if mode=='fixed_fee' else Fraction(start*amount,6000)
                high+=Fraction(amount,100) if mode=='fixed_fee' else Fraction(end*amount,6000)
            lines.append(row)
        result=quoting.totals(lines)
        equal(result,{'min_minutes':minutes_low,'max_minutes':minutes_high,'amount_min':cents(low) if priced else None,
                      'amount_max':cents(high) if priced else None,'priced_lines':priced,'has_unpriced':unpriced})
        equal(quoting.totals(list(reversed(lines))),result)
check('500 seeded quote aggregates against Fraction oracle plus order invariance',quote_properties)

def import_properties():
    rows=[]
    for number in range(200):
        rows.append({'source_record_id':f'new-source-{number}','client_id':str(uuid5(NAMESPACE_URL,'audit-client')),
                     'project_id':str(uuid5(NAMESPACE_URL,f'audit-project-{number}')),'work_date':'2026-09-23',
                     'minutes':number+1,'description':f'Árbol λ synthetic{number}','case_allocations':[]})
    batch={'schema_version':'timeker.daily-time-import.v1','batch_id':'audit-independent-20261026','entries':rows}
    raw=json.dumps(batch,ensure_ascii=False).encode('utf-8')
    equal(time_import.parse_upload(b'\xef\xbb\xbf'+raw,'json'),batch)
    output=io.StringIO(newline='')
    fields=['batch_id','source_record_id','client_id','project_id','work_date','minutes','description','case_allocations_json']
    writer=csv.DictWriter(output,fieldnames=fields);writer.writeheader()
    for row in rows:
        writer.writerow({'batch_id':batch['batch_id'],**{key:value for key,value in row.items() if key!='case_allocations'},'case_allocations_json':'[]'})
    equal(time_import.parse_upload(output.getvalue().encode('utf-8'),'csv'),batch)
check('200 novel time rows JSON-BOM and CSV normalize identically without losing Unicode',import_properties)

def import_invalid():
    base={'source_record_id':'x','client_id':str(uuid5(NAMESPACE_URL,'c')),'project_id':str(uuid5(NAMESPACE_URL,'p')),
          'work_date':'2026-09-23','minutes':1,'description':'synthetic'}
    def raw(rows):return json.dumps({'schema_version':'timeker.daily-time-import.v1','batch_id':'audit','entries':rows}).encode()
    for mutation in [{'minutes':True},{'minutes':0},{'minutes':1441},{'minutes':1.5},{'unknown':1},
                     {'work_date':'2026-02-30'},{'client_id':'fake'},{'description':'x'*2001}]:
        rejects(lambda:time_import.parse_upload(raw([{**base,**mutation}]),'json'))
    rejects(lambda:time_import.parse_upload(raw([base,base]),'json'))
    rejects(lambda:time_import.parse_upload(raw([]),'json'))
    rejects(lambda:time_import.parse_upload(b'{"batch_id":"a","batch_id":"b"}','json'))
    rejects(lambda:time_import.parse_upload(b'x'*(256*1024+1),'json'))
check('12 malformed/boundary import classes reject before persistence',import_invalid)

def document_text():
    equal(library.inspect_upload('source.md',b'\xef\xbb\xbfNovel\r\nUnicode \xce\xbb\n')[2],'Novel\nUnicode λ\n')
    target=io.BytesIO()
    document='<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body><w:p><w:r><w:t>Árbol &amp; λ</w:t></w:r></w:p><w:p><w:r><w:t>Second novel paragraph</w:t></w:r></w:p></w:body></w:document>'
    with zipfile.ZipFile(target,'w') as archive:
        archive.writestr('[Content_Types].xml','<Types/>');archive.writestr('word/document.xml',document)
    equal(library.inspect_upload('source.docx',target.getvalue())[2],'Árbol & λ\nSecond novel paragraph')
    rejects(lambda:library.inspect_upload('source.txt',b'\xff'))
    rejects(lambda:library.inspect_upload('source.txt',b'\x00'))
    rejects(lambda:library.inspect_upload('source.exe',b'MZ'))
check('DOCX and Markdown novel editable text;3 malformed imports reject',document_text)

def mail_roundtrip():
    message=EmailMessage(policy=policy.SMTP)
    message['From']='sender@example.invalid';message['To']='reader@example.invalid';message['Subject']='Novel λ attachment'
    message['Date']='Wed, 23 Sep 2026 07:31:00 -0400'
    message.set_content('Body with Árbol and λ.\n')
    payload=b'\x00\x01\xfeIndependent attachment\n'
    message.add_attachment(payload,maintype='application',subtype='octet-stream',filename='../attachment.bin')
    parsed=mail_service.parse_message(message.as_bytes(),include_attachments=True)
    equal(parsed['subject'],'Novel λ attachment');equal(parsed['body'],'Body with Árbol and λ.')
    equal(parsed['message_at'].isoformat(),'2026-09-23T11:31:00+00:00')
    equal(parsed['attachment_count'],1);item=parsed['attachments'][0]
    equal(item['payload'],payload);equal(item['sha256'],hashlib.sha256(payload).hexdigest());equal(item['size'],len(payload))
    assert '/' not in item['filename'] and '\\' not in item['filename']
    html=EmailMessage();html['From']='a@example.invalid';html['To']='b@example.invalid'
    html.set_content('<html><head><title>Hidden</title></head><body><p>Kept λ</p><script>Never</script></body></html>',subtype='html')
    equal(mail_service.parse_message(html.as_bytes())['body'],'Kept λ')
    rejects(lambda:mail_service.parse_message(b'not a MIME message'))
check('MIME attachment byte/hash roundtrip,UTC date,HTML plain normalization,malformed rejection',mail_roundtrip)

def flex_probes():
    for value in ['0','-0','0.00000','-0.00000','000012.34000','-99999999999999.99999','99999999999999.99999']:
        observed=flexfields.normalize({'flexfield7':value})['flexfield7']
        assert Decimal(observed)==Decimal(value)
    equal(flexfields.normalize({}),{});equal(flexfields.normalize({'flexfield1':''}),{'flexfield1':None})
    equal(flexfields.normalize({'flexfield1':'λ'*250}),{'flexfield1':'λ'*250})
    for values in [{'flexfield7':'1.000001'},{'flexfield7':'100000000000000'}, {'flexfield8':'NaN'},
                   {'flexfield1':'x'*251},{'flexfield1':'SELECT private'},{'flexfield1':'{"secret":1}'}]:
        rejects(lambda:flexfields.normalize(values))
check('Flex exact decimals,omit/clear,Unicode limit and6 rejected classes',flex_probes)

def draft_clients():
    values=client_drafts.validate_draft({'display_name':'Novel λ'})
    equal(values['display_name'],'Novel λ');equal(values['rate'],None);equal(values['legal_name'],None)
    rejects(lambda:client_drafts.validate_draft({'display_name':'Novel','tax_id':'invented'}))
check('Client proposal preserves unknowns and rejects unpublished contract fields',draft_clients)

result={'seed':99123,'checks':checks,'passed':sum(x['status']=='PASS' for x in checks),
        'failed':sum(x['status']=='FAIL' for x in checks),'scope':'Pure services/parsers; no DB/provider/pytest hook; no persistence claim',
        'loaded_sources':{module.__name__:module.__file__ for module in [client_drafts,flexfields,library,mail_service,quoting,time_import]}}
(AUDIT/'evidence/content-independent.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(result,indent=2))
raise SystemExit(bool(result['failed']))
