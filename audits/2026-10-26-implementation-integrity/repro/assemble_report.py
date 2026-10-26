"""Assemble audit artifacts; never imports or changes the evaluated application."""
import collections
import copy
import hashlib
import json
import subprocess
import sys
from datetime import datetime,timezone
from pathlib import Path
from xml.etree import ElementTree as ET

ROOT=Path(__file__).resolve().parents[1]
def read(name): return json.loads((ROOT/name).read_text(encoding='utf-8'))
def write(name,value): (ROOT/name).write_text(json.dumps(value,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
contract=read('reviews/contract.json')
snapshot=read('evidence/snapshot-before.json')

# Weights and original commitments are copied unchanged from the frozen registry.
decisions={
'C01':('UNKNOWN','Instalación con lock y wheel/sdist válidos; migraciones limpias e históricas verificadas. Falta construir/arrancar la imagen Docker en este host sin Docker CLI.', ['build.receipt.json','migration-model-compare.json'], [], ['Docker/container build and runtime artifact parity']),
'C02':('UNKNOWN','Rutas, tokens, linking, CSRF y negativas locales verificadas; falta prueba nueva de los proveedores de identidad reales. No se suplanta prueba personal.', ['backend-complete.xml','backend-setup-recovered.xml','oauth-csrf-refutation.json','behavior-independent.json'], [], ['Fresh real Google/GitHub/managed email proof']),
'C03':('FAIL','La configuración singleton hosted admite rol administrador/propietario y la validación multi-tenant omite REPLICATION. Las denegaciones recíprocas normales sí funcionan.', ['behavior-hosted-singleton-readiness.json','behavior-replication-readiness.json','backend-setup-recovered.xml'], ['B01'], ['Actual hosted roles not inspected']),
'C04':('PASS','Registro y slots preparados conservan identidad, acknowledgment y elección explícita bajo configuraciones locales permitidas; flags públicos remotos no se activan.', ['backend-setup-recovered.xml','behavior-independent.json'], [], []),
'C05':('PASS','Lifecycle, completitud, referencias y reactivación ejecutan servicios y persistencia; campos reales desconocidos se conservan.', ['backend-complete.xml','content-independent.json'], [], []),
'C06':('PASS','Arreglos de proyecto, presupuesto, extras y custodia de acuerdo tienen rutas y efectos locales comprobados; selecciones antiguas de tests se distinguen.', ['backend-complete.xml','browser-complete.xml'], [], []),
'C07':('PASS','Casos, asignaciones exactas, cambios masivos y retención tienen consultas y guards reales con pruebas locales.', ['backend-complete.xml','browser-complete.xml','content-independent.json'], [], []),
'C08':('PASS','Minutos enteros, formatos admitidos, semana contractual, cap y negativos verificados con 1936 checks independientes y flujos persistidos.', ['duration-oracle.log','finance-restored-baseline.log','backend-complete.xml'], [], []),
'C09':('PASS','Batches suplementales, identidad, holds y tarifas Ready congeladas están conectados; roles de prueba recuperados sin cambiar producto.', ['backend-complete.xml','backend-runtime-role-recovered.xml','migration-guard-probe.json'], [], []),
'C10':('PASS','Imports estrictos, contribuciones idempotentes y preservación de otras fuentes verificados localmente; 200 filas Unicode JSON/CSV nuevas.', ['backend-complete.xml','content-independent.json'], [], []),
'C11':('FAIL','El cálculo redondea mal algunos empates y el selector nativo de Billing se desvía al flujo de trabajo; publicación atómica y persistencia sí operan.', ['rounding-counterexample.json','billing-native-lookup.json','finance-restored-baseline.log'], ['FIN-01','BILLING-NATIVE-LOOKUP'], []),
'C12':('FAIL','PDF real y custodia/immutabilidad comprobados, pero el contraejemplo monetario se exporta como USD0.50 en PDF frente a USD0.51; no se omite el compromiso de totales exactos.', ['rounding-counterexample.json','rounding-exports-counterexample.log','finance-restored-baseline.log','fresh-process-reader-r2.log','migration-guard-probe.json'], ['FIN-01'], []),
'C13':('PASS','Créditos parciales/cumulativos y completos conservan original y claims; oracle SQL verifica .02+.01+.02=.05 y rechaza mutaciones.', ['migration-guard-probe.json','finance-restored-baseline.log','backend-complete.xml'], [], []),
'C14':('PASS','Pagos manuales, reversión, receipt/due date y saldo compartido se verifican por rutas, SQL nuevo y balances independientes.', ['finance-restored-baseline.log','fresh-process-reader-r2.log','backend-complete.xml'], [], []),
'C15':('FAIL','Consultas y navegación funcionan, pero Reports CSV repite la estimación USD0.50 para2min a15.15 frente0.51. Se conserva el compromiso de exactitud monetaria de la matriz congelada.', ['rounding-counterexample.json','rounding-exports-counterexample.log','backend-complete.xml','browser-complete.xml'], ['FIN-01'], []),
'C16':('PASS','Estimaciones y revisiones publicadas están conectadas; 500 oráculos Fraction y transformación de orden nuevos pasan.', ['content-independent.json','backend-complete.xml','browser-complete.xml'], [], []),
'C17':('PASS','Library preserva originales completos/versiones, valida documentos y publica PDF local real.', ['content-independent.json','backend-complete.xml','browser-complete.xml'], [], []),
'C18':('UNKNOWN','Claims durables, estados y fallos de transporte se verifican localmente; no hay nueva confirmación externa Email Sending y no se autoriza otro envío.', ['backend-complete.xml','behavior-independent.json'], [], ['Fresh external provider acceptance/delivery path']),
'C19':('UNKNOWN','Outbox comercial y revisión local verificadas; el transporte externo y aceptación real no se ejercitan de nuevo.', ['backend-complete.xml','behavior-independent.json','browser-complete.xml'], [], ['Fresh external commercial-document delivery']),
'C20':('UNKNOWN','EML, adjuntos, normalización/hash y asignación local verificados; captura real de proveedor no comprobada en esta auditoría.', ['content-independent.json','backend-complete.xml','browser-complete.xml'], [], ['Actual inbound provider capture']),
'C21':('PASS','Archivo conserva consultas/exportes y rechazos de edición por expiry; guards y lectura local vigentes comprobados.', ['backend-complete.xml','browser-setup-recovered.xml','migration-guard-probe.json'], [], []),
'C22':('FAIL','OAuth/PKCE/MCP local real duplica el mismo timecard al añadir un cliente ajeno. La compatibilidad/refresh/revoke del host asistente real sigue pendiente.', ['behavior-mcp-cartesian.json','refutation-mcp-duplicate.json'], ['B02'], ['Real assistant host interoperability and financial confirmation']),
'C23':('FAIL','Eventos fallidos repetidos alteran la gracia una hora al cruzar DST en sesiones no UTC. Checkout/3DS/renovación real actuales siguen sin observar.', ['behavior-grace-dst.json','backend-complete.xml'], ['B04'], ['Actual current Paddle catalog/checkout/3DS/renewal and provider timezone']),
'C24':('PASS','Sesiones simultáneas, revocación y recuperación local de formularios verificadas; el preflight renueva CSRF sin aceptar un POST crudo inválido.', ['backend-complete.xml','browser-setup-recovered.xml','oauth-csrf-refutation.json','session-preflight-csrf.json'], [], []),
'C25':('PASS','Export/cierre local conserva PDFs, historial y estado de retención pendiente; errores/cancelación no probada se declaran action-required y no purgan.', ['backend-complete.xml','browser-setup-recovered.xml','behavior-independent.json'], [], []),
'C26':('PASS','Logs sanitizados y auditoría de negocio ejecutados; fallo técnico no convierte un commit en fracaso ni imprime payloads reales en las pruebas revisadas.', ['backend-complete.xml','behavior-independent.json','fresh-process-reader-r2.log'], [], []),
'C27':('FAIL','El lookup nativo de Billing pierde formulario/fechas. Checks axe y renders desktop/mobile ejecutados no detectaron violaciones; no certifican todo WCAG.', ['billing-native-lookup.json','browser-complete.xml','browser-setup-recovered.xml'], ['BILLING-NATIVE-LOOKUP'], []),
'C28':('FAIL','Readiness acepta configuraciones prohibidas. Recovery local de regresión pasa, pero operación desatendida, RPO/RTO, nuevo dispositivo y capacidad sostenida siguen sin acreditar.', ['behavior-hosted-singleton-readiness.json','backend-setup-recovered.xml','hosted-public-readback.json'], ['B01'], ['Unattended backup/rotation, adopted retention/RPO, independent key custody, new-device/provider-loss/business recovery/RTO, sustained C5K capacity']),
'C29':('FAIL','La medición opcional pública con consentimiento queda desconectada por middleware cuando se habilita localmente; baseline remoto OFF no se altera. Contacto externo no se reenvía.', ['behavior-usage-route.json','usage-browser-enabled.xml','backend-complete.xml'], ['B03'], ['Fresh external contact delivery not performed']),
'C30':('FAIL','Suite del Worker acepta el entrypoint desconectado; fixtures/expectativas desactualizadas y docs contradictorias impiden declarar suite verde. Sin manipulación indebida observada.', ['adapter-negative-controls.json','adapter-independent-entrypoint.json','backend-complete.xml','browser-complete.xml'], ['EVAL-01','EVAL-02'], [])
}
matrix=copy.deepcopy(contract)
matrix.update(schema='functional-integrity.matrix.v1',snapshot_head=snapshot['head'],inventory_closed=True,
    adjudication_policy='PASS applies to the declared local source contract; external provider obligations remain UNKNOWN when not exercised. A confirmed failure remains FAIL with other pending checks. Contract author froze weights before receiving behavior results; existing suites had already begun. No weights changed after outcomes.')
for row in matrix['capabilities']:
    status,reason,evidence,findings,pending=decisions[row['id']]
    row.update(status=status,reason=reason,evidence=['evidence/'+x for x in evidence],finding_ids=findings,pending_checks=pending)
    row.pop('unknown_reason',None)
write('MATRIX.json',matrix)

financial={
'id':'FIN-01','status':'CONFIRMED','category':'CONTRACT_FAILURE','severity':'medium',
'title':'El cálculo monetario subredondea empates exactos de medio centavo',
'requirement_sources':['docs/DECISIONS.md:67-68 (D002)','docs/PROJECT_BRIEF.md:609-619','AGENTS.md:Data and billing invariants'],
'locations':[{'path':'app/domain.py','start_line':48,'end_line':49},{'path':'app/billing.py','start_line':338,'end_line':377},{'path':'app/reports.py','start_line':49,'end_line':49}],
'trajectory':'POST timecards/save -> finalización y tarifa Ready -> POST billing/create -> agrupación project/week/rate -> line_amount -> invoice_lines/invoices NUMERIC -> lectura SQL nueva.',
'input':{'minutes':2,'rate':'15.15','period':'2026-10-19 / 2026-10-25','line_count':1},
'expected':'2*15.15/60 = 0.505; ROUND_HALF_UP a dos decimales = USD0.51',
'observed':'HTTP200 y total/line_amount persistidos USD0.50. Otra muestra:602min*602.85/h =>6048.59 frente6048.60.',
'evidence':['evidence/rounding-counterexample.json','evidence/rounding-counterexample.log','evidence/rounding-counterexample.receipt.json','evidence/rounding-exports-counterexample.log','evidence/rounding-exports-counterexample.receipt.json','evidence/independent-finance.log'],
'repro':['repro/rounding_probe.py','repro/independent_finance.py'],
'oracle':'Centavos enteros: floor((minutes*rate_cents+30)/60), Fraction y Decimal precisión80 independientes. Semilla20261026;400 casos,398 iguales/2 discrepancias.',
'alternative_considered':'D002 redondea por línea agrupada, no por intervención. El contraejemplo tiene una sola línea; esa política no explica el error. Decimal evita float pero la división periódica antes de multiplicar puede bajar el empate exacto.',
'impact':'Subfacturación de un centavo en combinaciones válidas de minutos/tarifa; afecta también consumidores del helper. No se mide pérdida real ni se modifica factura real.',
'correction':'Calcular el producto exacto minutos*tarifa antes de dividir por60 y cuantizar una sola vez; conservar límites Decimal y redondeo por grupo.',
'verification':'Nuevos casos racionales fuera de las muestras publicadas, límites, varias tarifas/semana y ruta hasta SQL/PDF. Verificar guards de importe/snapshot sin reparar el snapshot auditado.',
'refutation':'Agente de comportamiento confirmó el oráculo contra D002; no encontró alternativa legítima para una línea.'}
behavior=read('reviews/behavior.json')['findings']
evaluation=read('reviews/evaluator.json')['findings']
triage=read('reviews/suite-triage.json')['findings']
for finding in behavior:
    if finding['id']=='B02':
        finding['requirement_sources']=[x.replace('106-119','93-101') for x in finding['requirement_sources']]
        for location in finding['locations']:
            if location['path']=='app/archiving.py': location.update(start_line=38,end_line=42)
    if finding['id']=='B01':
        finding['locations'] += [{'path':'app/main.py','start_line':129,'end_line':134},{'path':'app/main.py','start_line':741,'end_line':747}]
for finding in evaluation:
    if finding['id']=='EVAL-02':
        for location in finding['locations']:
            if location['path'].endswith('wrangler.jsonc'): location['line']=11
findings=[financial,*behavior,*triage,*evaluation]
write('FINDINGS.json',{'schema':'functional-integrity.findings.v1','snapshot':snapshot['head'],'configuration':'Isolated local/native PostgreSQL/Edge; conditional hosted-shaped and feature-enabled reproductions identified per finding','findings':findings,'evaluator_tampering':'NOT_OBSERVED','test_special_casing':'NOT_OBSERVED','agent_attribution':'NOT_DETERMINED','intent':'NOT_DETERMINED'})

# Exact-node overlays, never adding overlapping pytest run counts.
run_names=['backend-complete','backend-setup-recovered','backend-runtime-role-recovered','usage-browser-enabled','browser-complete','browser-setup-recovered','browser-navigation-diagnosis']
latest={}
runs=[]
for label in run_names:
    xml=ROOT/'evidence'/(label+'.xml')
    if not xml.exists(): continue
    counts=collections.Counter()
    for case in ET.parse(xml).iter('testcase'):
        key=case.get('classname')+'::'+case.get('name')
        state=next((s for s in ('error','failure','skipped') if case.find(s) is not None),'passed')
        counts[state]+=1
        latest[key]={'state':state,'run':label,'area':'browser' if case.get('classname','').startswith('tests.e2e') else 'backend'}
    receipt=ROOT/'evidence'/(label+'.receipt.json')
    runs.append({'run':label,'counts':dict(counts),'nodes':sum(counts.values()),'duration_seconds':read('evidence/'+receipt.name).get('duration_seconds') if receipt.exists() else None})
aggregates={area:dict(collections.Counter(x['state'] for x in latest.values() if x['area']==area)) for area in ('backend','browser')}
write('TEST_RESULTS.json',{'runs':runs,'latest_per_exact_node':aggregates,'distinct_nodes':len(latest),'not_a_single_green_invocation':True,'node_results':latest,'independent_assertions_not_added_to_test_node_counts':True})

semantic=set(); sampled=set()
for name in ('evaluator','product-content'):
    value=read('reviews/'+name+'.json')
    semantic.update(x if isinstance(x,str) else x['path'] for x in value['reviewed_semantically'])
    sampled.update(x if isinstance(x,str) else x['path'] for x in value['sampled_not_complete'])
semantic.update(x['path'] for x in read('reviews/migrations.json')['files'])
for row in read('reviews/behavior.json')['coverage_ledger']:
    (semantic if 'full' in row.get('mode','').lower() else sampled).add(row['path'])
root_full=['app/domain.py','app/billing.py','app/timecards.py','app/db.py','app/pdf.py','app/audit.py','app/repositories.py','app/work_rates.py','app/reports.py','app/dashboard.py','app/pagination.py','app/forms.py','app/static_assets.py','app/web/static/app.js','app/web/static/timecards.js','app/web/static/session_recovery.js','app/web/templates/statement.html','app/web/templates/base.html','app/web/templates/dashboard.html','app/web/templates/billing.html','Dockerfile','compose.yaml','compose.demo.yaml','AGENTS.md','README.md','CONTINUE.md','docs/contracts/ALCO_CONTRACT_SOURCE_NOTES.md']
semantic.update(root_full)
semantic.discard('AGENTS.md')
semantic.update(read('reviews/suite-triage.json')['additional_semantically_reviewed_files'])
sampled.update(read('reviews/suite-triage.json')['additional_sampled_files'])
sampled.update(['app/main.py','docs/STATUS.md','docs/DECISIONS.md','docs/design/DESIGN_SPEC.md','HOSTING.md','docs/PROJECT_BRIEF.md','docs/legal/PRIVACY_DISCOVERY.md'])
files=[]
for row in snapshot['files']:
    path=row['path']
    modes=['inventoried']
    if path=='AGENTS.md': modes.append('operating_and_product_contract_instructions_read; governance_not_evaluated')
    if path in semantic: modes.append('static_semantic_full')
    elif path in sampled: modes.append('static_sampled')
    if path.startswith('tests/') and path.endswith('.py'): modes.append('inventoried_AST_and_collection; see exact-node execution')
    if path.startswith('alembic/versions/'): modes.append('executed_clean_migration')
    if path.startswith('app/web/templates/'): modes.append('template_checks_executed; branch/layout coverage selective')
    files.append({**row,'modes':modes})
coverage={'inventory_files':len(files),'inventory_closed':True,'inventory_percent':100,'semantic_full_files':sum('static_semantic_full' in x['modes'] for x in files),'sampled_files':sum('static_sampled' in x['modes'] for x in files),'files':files,'branch_or_line_execution_coverage':'NOT_MEASURED','third_party':'Vendored HTMX/axe, binary assets/fonts,61 locked Python packages and npm transitive code are inventoried/versions or hashes checked, not semantically audited in full. Node installed dependencies are ignored project-local inputs; lock correspondence checked.','ignored':'Metadata-only groups in ignored-inventory.json; private instructions read only to operate; credentials, historical logs/outputs, archive payload and personal unrelated credentials not evaluated/exported.','relevance':'Inventory coverage is not capability verification or full semantic review of every file. No area silently narrowed to diff/src; tests/docs/config/build/migrations/integrations all included with stated depth.'}
write('COVERAGE.json',coverage)
subprocess.run([sys.executable,str(ROOT/'repro'/'calculate_score.py')],check=True)
score=read('SCORECARD.json')
summary={**read('PROGRESS.json'),'state':'AUDIT_EXECUTED_FINDINGS_OPEN','completed':run_names+['frozen matrix adjudicated','independent counterexamples and refutations','source identity preserved','score script checked'],'running':[],'remaining':['Public package seal/publication/readback'],'coverage':{k:v for k,v in coverage.items() if k!='files'},'pending_verification':[(x['id'],x['pending_checks']) for x in matrix['capabilities'] if x['pending_checks']],'verdict':score['verdict'],'next_action':'Publish only sanitized audit artifacts to the requested documentation repository; no product fixes.'}
write('PROGRESS.json',summary)

table='\n'.join(f"| {x['id']} | {x['weight']} | {x['status']} | {x['description']} |" for x in matrix['capabilities'])
find_table='\n'.join(f"| {x['id']} | {x['severity']} | {x['category']} | {x['title']} |" for x in findings)
tests_table='\n'.join(f"| {r['run']} | {r['nodes']} | {r['counts'].get('passed',0)} | {r['counts'].get('failure',0)} | {r['counts'].get('error',0)} | {r['counts'].get('skipped',0)} | {r['duration_seconds']} |" for r in runs)
report=f'''# Auditoría de integridad funcional de timeKER — 26 de octubre de 2026

**Veredicto: FAIL.** Hay incumplimientos funcionales reproducidos en el snapshot. **No se observó manipulación indebida del evaluador ni adaptación deliberada a fixtures.** La autoría de agentes y la intención no están determinadas. Los defectos ordinarios, la conexión omitida y los tests débiles se distinguen expresamente.

Outcome: DONE_WITH_CONCERNS

Delivery state: auditoría ejecutada con paquete reproducible fuera del código evaluado; hallazgos abiertos, sin reparaciones.

Product state: snapshot local preservado; disponibilidad pública de Stage observada, identidad de imagen/runtime no acreditada.

Gate/authority state: esta auditoría no acepta PH3, no suministra UAT humano, no activa proveedores, no despliega ni modifica PROD, datos reales o identidades.

## Snapshot y alcance

Repositorio evaluado: timeKER-Stage, checkout timeKER-PH3; rama `{snapshot['branch']}`, HEAD `{snapshot['head']}`. Estado inicial/final: untracked `timeKER-PH3-Master-Prompt-2026-10-18.txt`; no cambio tracked local. El master se incluyó como requisito aceptado y su hash, sin publicar su contenido completo. El [manifiesto inicial](evidence/snapshot-before.json) y el [readback final](evidence/snapshot-after.json) preservan {len(snapshot['files'])} archivos y {sum(x['bytes'] for x in snapshot['files']):,} bytes. No se cambió el producto, sus tests, STATUS ni configuración efectiva de hosting.

Se incluyeron backend, UI/JS/templates, APIs/MCP, algoritmos, SQL/modelos/34 migraciones, integraciones, auth/tenancy, configuración, dependencias/locks, build/CI, despliegue y documentación. No hay procedimientos externos inventados:45 funciones y69 triggers fueron observados en el catálogo local reconstruido. Gobernanza de asistentes se leyó para operar y se excluyó como objeto de evaluación. Archivos privados/credenciales/histórico y código completo de terceros tienen el tratamiento explícito de [COVERAGE](COVERAGE.json) e [inventario ignorado](evidence/ignored-inventory.json).

Inventario: **100% de los568 archivos en alcance**, {coverage['semantic_full_files']} con revisión semántica completa registrada y {coverage['sampled_files']} muestreados. Los restantes conservan clasificación inventariada/ejecutada según corresponda; no se presentan como lectura semántica completa. No se midió cobertura de líneas/ramas. La revisión cubre todas las áreas, con profundidad declarada; no garantiza ausencia de todos los defectos posibles.

## Puntuación reproducible

30 capacidades, pesos congelados por el agente contractual antes de recibir resultados de comportamiento. Las suites existentes ya habían comenzado; ningún peso se cambió tras conocer resultados. Registro original: [contract.json](reviews/contract.json); adjudicación: [MATRIX.json](MATRIX.json).

`W={score['W']} = P({score['P']}) + F({score['F']}) + U({score['U']})`.

- Cumplimiento demostrado **D={score['D_demonstrated']['display_percent']}%** ({score['P']}/{score['W']}).
- Cobertura de decisión **C={score['C_decision']['display_percent']}%** ({score['P']+score['F']}/{score['W']}).
- Fallo confirmado ponderado **{score['confirmed_failure']['display_percent']}%**; pendiente ponderado **{score['pending']['display_percent']}%**.
- Capacidades: {score['capability_counts']['PASS']} PASS, {score['capability_counts']['FAIL']} FAIL, {score['capability_counts']['UNKNOWN']} UNKNOWN. UNKNOWN permanece en el denominador y no significa defecto demostrado.

El score es una política de evidencia por capacidad, no probabilidad de trampa, autoría AI, porcentaje del código correcto ni cobertura de tests. C03/C28 y C11/C27 tienen compromisos distintos preexistentes afectados por una causa compartida; no se añadieron pesos por cada contraejemplo. El inventario está cerrado y la puntuación no es provisional por inventario; los pendientes están visibles. [SCORECARD.json](SCORECARD.json) y [calculate_score.py](repro/calculate_score.py) conservan fracciones exactas, denominadores y comprobación de pesos.

## Hallazgos confirmados

| ID | Gravedad | Categoría | Resultado |
| --- | --- | --- | --- |
{find_table}

Todos los detalles obligatorios —requisito/ubicación, configuración, entrada mínima, esperado/observado, reproducción, evidencia, impacto, alternativas y corrección— están en [FINDINGS.json](FINDINGS.json). Se intentó refutarlos por roles separados; [refutación contractual](reviews/refutation.md), [revisión de comportamiento](reviews/behavior.md) y [triage](reviews/suite-triage.md) retienen las alternativas.

1. **Dinero:** una sola línea de2minutos a USD15,15/h produce USD0,50 por HTTP/SQL frente al USD0,51 exigido por D002; el mismo importe incorrecto se reproduce abriendo PDF real y CSV de Reports. Dividir minutos antes de multiplicar introduce una aproximación decimal que puede bajar un empate. De400 combinaciones nuevas con oráculo racional,398 coinciden y2 fallan. No es redondeo legítimo por múltiples líneas. C11, C12 y C15 conservan FAIL por sus obligaciones originales de cálculo/exportación/reportes, aunque custodia y consultas tengan pruebas positivas.
2. **MCP:** agregar un cliente Draft ajeno duplica el mismo UUID de timecard y elimina la selección singular; la base sigue conteniendo un solo timecard de37minutos. Falta unir Client antes del predicado de archivo. No se afirma duplicación persistida ni fuga entre tenants.
3. **Readiness:** una configuración staging válida con TLS local verify-full y un solo workspace arranca con rol administrativo/propietario. Con varios workspaces se omite REPLICATION. Esto prueba un diagnóstico incorrecto bajo esa configuración; **no** que los roles actuales de Stage sean administrativos.
4. **Gracia:** con el mismo primer fallo y período, eventos posteriores cambian604800 a608400segundos al cruzar DST de otoño, y a601200 en primavera. UTC y fechas sin transición permanecen estables. Incluso interpretar días calendario no justifica que repetir la observación cambie el vencimiento. Timezone real de Stage no observado.
5. **Billing nativo:** Search/Previous/Next del selector envían GET a `/billing/work`; cliente vacío devuelve400, cliente seleccionado abre selección de trabajo. Se pierden selector/fechas. El nuevo flujo PH3 no elimina el fallback nativo aceptado.
6. **Medición opcional:** con flag habilitado sólo localmente y consentimiento válido, el visitante anónimo recibe303 antes de llegar al collector; un owner obtiene204. El flag remoto sigue OFF y no se afirma tracking no consentido.
7. **Verificador del Worker:** sustituir sólo el export real por HTTP200 constante conserva55/55 tests. Un verificador nuevo ejecuta el export, proxy y binding simulado y sí detecta la mutación. El baseline real pasa; no hay no-op actual demostrado en ese handler ni evidencia de intención.
8. **Documentación:** README del adaptador niega cron pese a export/config con agenda diaria; el README raíz conserva un encabezado PH2 anterior a la autoridad PH3 actual. Son contradicciones documentales, no prueba de que el código PH3 esté ausente.

## Qué funciona y evidencia

El flujo independiente atraviesa formularios HTTP, servicios y PostgreSQL real: guarda69minutos inéditos, finaliza con tarifa47,13, prepara/publica USD54,20, abre PDF real y su texto, simula fallo de renderer y confirma rollback por una sesión nueva, registra pago13,07 y crédito11,19, conserva claims/artefacto y calcula saldo29,94. Son24 checks, más6 lecturas independientes en un proceso nuevo que no importa el producto. El PDF sintético de dos páginas se renderizó con Poppler y se inspeccionaron ambas páginas; no se usó como prueba un archivo simplemente existente.

1936 checks independientes cubren todos los1441 valores H:MM hasta24:00,481 pasos decimales, inválidos y frontera de semana UTC/Santiago. Otras pasadas separadas contienen317 assertions sobre credenciales/configuración/transportes,500 oráculos Fraction de estimación y200 filas Unicode equivalentes JSON/CSV; esas cantidades **no se suman como nodos pytest**.

La reconstrucción limpia contiene59 tablas/modelos,150 CHECK,45 funciones y69 triggers sin tablas/columnas/tipos faltantes. Catorce controles SQL independientes incluyen10 rechazos, créditos acumulativos y preservación de original/claims tras crédito completo. Existe una deriva no bloqueante: default servidor draft de Project.status no reflejado como server_default en el mapper; el default Python sí es draft. El paquete Python wheel/sdist se construyó con lock vigente; Ruff y mypy pasan. Mypy revisó102 módulos. Tests Node55/55 y TypeScript7.0.2 pasan, con la limitación de wiring demostrada arriba.

## Ejecuciones y fiabilidad de pruebas

Los argv completos, entorno local depurado, duración y exit están en los recibos. Los XML retienen cada nodo descubierto/ejecutado, error, fallo y skip.

| Ejecución | Nodos | PASS | FAIL | ERROR | SKIP | Segundos de proceso |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
{tests_table}

Último resultado por **identidad exacta del nodo**, sin sumar reejecuciones: `{json.dumps(aggregates,ensure_ascii=False)}`. No existió una nueva invocación única de toda la suite verde. [TEST_RESULTS](TEST_RESULTS.json) conserva el overlay y resultados originales.

La instalación nueva necesitó roles locales de harness: timeker_test, anon/authenticated/service_role y dos roles runtime sintéticos. Los130 errores de backend eran129 fallos por anon ausente y1 requisito de sentinels; se recuperaron130/130 después de preparar el cluster. Dos fallos por otro rol ausente pasaron al prepararlo. Los dos skips por BROWSER_EXECUTABLE pasaron con Edge. La primera ejecución interrumpida y el diagnóstico de rol faltante se conservaron; no se acreditan como PASS.

Los65 errores iniciales de navegador fueron `.local/e2e-server.log` ausente en una copia limpia; tras crear el directorio,59 pasaron y6 ejecutaron assertions fallidas. Esto es una dependencia del harness sin preparar, no65 defectos de la aplicación. Hay expectativas anteriores a PH3/D084 (etiquetas de total, publicación, estilos y títulos de fechas futuras), selectores estrictos que también encuentran help oculto y fixtures HTML que no implementan el nuevo `/auth/session`. Se refutó la sospecha CSRF: un POST crudo inválido devuelve403 con cero grant/código; el preflight JavaScript reemplaza el token inyectado en DOM antes del submit. La corrección de un oracle de auditoría o fixture se hace sólo fuera del código evaluado; nunca se normalizan a verde las evidencias originales. Ver [triage detallado](reviews/suite-triage.md).

Los4 ERR_ABORTED se reprodujeron sin cambiar baseline y se investigaron en una copia instrumentada: el test navega inmediatamente después de Save mientras corre `/auth/session`; el POST reanudado aborta esa navegación. No hubo diálogos. Añadir esperas explícitas de la URL/estado final sólo a la copia de tests produce4/4 PASS y SQL confirma flexfields Unicode,45minutos y lifecycle de caso. El baseline de esos4 tests sigue FAIL; los4 PASS instrumentados no se suman ni reemplazan en el overlay de nodos originales. Evidencia: [navigation-race-proof](evidence/navigation-race-proof.json).

No se encontraron hooks que cambien resultados, xfail, tests borrados en el historial consultado ni detección indebida de fixtures en runtime. Mocks de proveedor, capacidad Pro de ingeniería, seeding sintético y feature flags se declaran como alcance local; no acreditan pago, identidad, email o aceptación externa.

## Controles negativos y separación del juicio

En copias desechables se inyectaron3 defectos financieros: constante de cálculo, omitir escritura y devolver éxito de publicación sin procesar. El verificador externo detectó3/3. La primera instrumentación del tercer mutante fue inválida por CRLF y se conserva como intento inválido, no mutante detectado. Tras corregir el reemplazo se ejecutó sólo ese control. Cada archivo mutado se restauró y su SHA256 se comprobó.

En el adaptador hubo4 controles:3 detectados por tests existentes y1 superviviente del entrypoint. El verificador independiente recupera la evidencia de wiring y mata el superviviente, sin borrar la debilidad original. No se suma este dato como score de integridad ni se descarta un superviviente para inflar resultados. No hubo timeouts declarados como detecciones correctas. El cálculo monetario se juzga con enteros/Fraction y el almacenamiento con SQL/conexión/proceso nuevo, fuera de hooks pytest del producto.

## Lo que no se pudo comprobar

No hay Docker CLI/engine utilizable en este host: imagen y ejecución container desde cero quedan UNKNOWN, aunque wheel/sdist y código de Docker se comprobaron. No se revisó semánticamente cada dependencia transitive/binario/vendored; no hay certificación de supply chain ni nuevo escaneo de CVE solicitado. No se inspeccionaron secrets efectivos, roles/TLS cloud actuales, payloads de backup privados o bases reales.

No se ejercitaron proveedores remotos con credenciales ni se hicieron envíos/compras/cobros: Google/GitHub/OTP reales, Paddle anual/3DS/renovación efectiva, aceptación de Email Sending, captura inbound y refresh/revoke/dos owners en host asistente quedan sin evidencia nueva. Un adapter con transporte simulado sólo acredita la parte ejecutada.

Sigue pendiente operación desatendida de backup/rotación, política/RPO/retención adoptados y custodia independiente de llaves, recuperación en nuevo dispositivo/pérdida de proveedor/full-business/RTO y capacidad sostenida C5K. Son límites aceptados/documentados, no simulaciones descubiertas ni controles completados por esta auditoría. El ensayo local de dump/restore es evidencia de ese alcance estrecho.

Readback público nuevo de Stage: health/live, health/ready y sign-in200; wordmark exacto; timecards.js difiere sólo por LF/CRLF; app.js y app.css difieren realmente de HEAD local. No se infiere defecto por ello: la auditoría evalúa este snapshot y **no acredita** que esa misma imagen/código esté desplegada. No se accedió a PROD ni se usó login/grant real.

## Correcciones prioritarias y verificación posterior

1. Corregir orden exacto del cálculo monetario y fijar UTC para la aritmética técnica de gracia; probar nuevos valores racionales y transiciones DST distintas de los ejemplos publicados, con lectura de sesiones nuevas y repetición de eventos.
2. Unir Client correctamente en MCP antes de aplicar archivo/límite, y reparar routing/preservación de formulario del lookup Billing; verificar cardinalidad con varios clientes/timezones y flujos nativos de Search/Previous/Next.
3. Separar permiso local de desarrollo de validación hosted de privilegios propios; incluir REPLICATION y mantener rechazos recíprocos. Probar singleton seguro, singleton inseguro, multi-tenant y desarrollo legítimo.
4. Conectar collector público manteniendo consentimiento/origen/budget/flag y sin activarlo remotamente. Añadir tests del create_app completo.
5. Fortalecer tests del export real, preparar harness reproducible, actualizar fixtures/expectativas a los contratos vigentes y reconciliar documentación. Conservar negativos y fallos originales; ejecutar una nueva suite completa contra un **snapshot nuevo**.

Ninguna propuesta se aplicó durante esta auditoría. Reparar una futura versión no convierte en correcta la versión original ni elimina estos hallazgos. No se solicita UAT genérico para suplir verificaciones técnicas pendientes.

## Matriz resumida

| Capacidad | Peso | Estado | Compromiso |
| --- | ---: | --- | --- |
{table}

## Entradas del paquete

- [MATRIX](MATRIX.json), [SCORECARD](SCORECARD.json), [FINDINGS](FINDINGS.json), [COVERAGE](COVERAGE.json), [PROGRESS](PROGRESS.json), [TEST_RESULTS](TEST_RESULTS.json).
- [Reproducción](REPRODUCE.md), scripts `repro/`, recibos/logs/XML/inputs `evidence/` y pasadas separadas `reviews/`.
- [Recalcular score](repro/calculate_score.py): `python repro/calculate_score.py --check`.

Las evidencias publicadas son sintéticas/depuradas. Sandbox, base PostgreSQL, claves TLS temporales, entornos de dependencias, código privado completo y artefactos de distribución quedan fuera de la publicación.
'''
(ROOT/'REPORT.md').write_text(report,encoding='utf-8')
print(json.dumps({'findings':len(findings),'semantic_full_files':coverage['semantic_full_files'],'sampled':coverage['sampled_files'],'score':score['D_demonstrated']['display_percent'],'verdict':score['verdict'],'tests':aggregates}))
