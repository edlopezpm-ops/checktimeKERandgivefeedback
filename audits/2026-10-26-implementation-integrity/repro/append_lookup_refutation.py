import json,hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
REPO=Path(r'<SOURCE_ROOT>')
p=ROOT/'reviews'/'behavior.json'
r=json.loads(p.read_text(encoding='utf-8-sig'))
for name in ['app/web/templates/billing.html','app/web/templates/lookup.html']:
    data=(REPO/name).read_bytes()
    if not any(x['path']==name for x in r['coverage_ledger']):r['coverage_ledger'].append({'path':name,'mode':'static_semantic_full','lines':len(data.splitlines()),'sha256':hashlib.sha256(data).hexdigest()})
for row in r['coverage_ledger']:
    if row['path']=='app/main.py':row['ranges'].append([1511,1571])
r['refutations'].append({'subject':'Evaluator Billing native lookup regression','result':'No legitimate counterevidence. DESIGN_SPEC337 promises shared selector native fallback. billing.html4 GET/billing/work contains lookup buttons named _lookup with formnovalidate; main1539 validates clientUUID/dates before body and ignores _lookup. Blank selection fails400; chosen selection enters unrelated work view200. PH3 selective business workflow does not remove selector fallback. Existing real-form repro with normal-action positive control supports root-cause. No independent second runtime execution performed by this reviewer.','evidence':['evidence/billing-native-lookup.json','app/web/templates/billing.html:4','app/web/templates/lookup.html:17-19','app/main.py:1539','docs/design/DESIGN_SPEC.md:337']})
p.write_text(json.dumps(r,indent=2,ensure_ascii=False),encoding='utf-8')
with (ROOT/'reviews'/'behavior.md').open('a',encoding='utf-8') as f:f.write('''\n\n## Refutación cruzada — búsqueda nativa de Billing\n\nLa revisión independiente de fuentes no encontró una excepción legítima que invalide el hallazgo del revisor de evaluación. DESIGN_SPEC337 conserva el fallback nativo de selectores. billing.html4 envía GET/billing/work; botones _lookup de lookup.html17–19 usan el mismo formulario con formnovalidate. main1539 exige UUID/fechas antes del handler y no despacha _lookup. Selección vacía produce400 y selección presente conduce a Choose billable work, no al buscador. La modificación PH3 de la acción de negocio no elimina este contrato compartido. Se revisaron evidencia/inputs y control positivo del revisor; no se atribuye aquí una segunda ejecución runtime. Los dos templates se agregaron al ledger completo.\n''')
print('Cross-refutation and two template coverage entries appended.')
