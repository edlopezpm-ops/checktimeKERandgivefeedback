import json,sys
from datetime import UTC,date,datetime
from pathlib import Path
sys.path.insert(0,str(Path.cwd()))
from app.domain import DomainError,parse_duration,week_start,money
checks=0
for m in range(1441):
    assert parse_duration(f'{m//60}:{m%60:02d}')==m
    checks+=1
for hundredths in range(0,2401,5):
    value=f'{hundredths//100}.{hundredths%100:02d}'
    assert parse_duration(value)==hundredths*3//5
    checks+=1
invalid=['24:01','1:99','-0:01','0.0001','1e0','NaN','Infinity','12:3']
for value in invalid:
    try: parse_duration(value)
    except DomainError: checks+=1
    else: raise AssertionError(value)
for value in ('NaN','Infinity','3.001','-0.01',1.25):
    try: money(value)
    except DomainError: checks+=1
    else: raise AssertionError(value)
assert week_start(datetime(2026,10,26,1,tzinfo=UTC),'America/Santiago')==date(2026,10,19)
checks+=1
print(json.dumps({'status':'PASS','checks':checks,'H_MM_cases':1441,'decimal_hour_cases':481,'invalid_duration_cases':8,'invalid_money_cases':5,'timezone_cases':1,'oracle':'Every allowed H:MM integer minute through24:00; decimal-hours five-hundredths steps equal3minutes; independently known Santiago Sunday/UTC Monday boundary'}))
