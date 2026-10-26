"""Summarize existing captured suite runs without running or changing tests."""
from collections import Counter
import json
from pathlib import Path
import xml.etree.ElementTree as ET

AUDIT=Path(__file__).resolve().parents[1]
def records(name):
    path=AUDIT/'evidence'/name
    if not path.exists():return None
    root=ET.parse(path).getroot();result=[]
    for case in root.iter('testcase'):
        child=next((x for x in case if x.tag in {'failure','error','skipped'}),None)
        result.append({'node':case.attrib['classname'].replace('.','/')+'.py::'+case.attrib['name'],
                       'status':child.tag if child is not None else 'passed',
                       'message':(child.attrib.get('message','')[:550] if child is not None else '')})
    return {'source':name,'counts':dict(Counter(x['status'] for x in result)),'tests':result}

backend=records('backend-complete.xml');browser=records('browser-complete.xml');recovered=records('browser-setup-recovered.xml')
navigation=records('browser-navigation-waited.xml')
classifications=[]
for run in [backend,browser,recovered]:
    if run is None:continue
    for item in run['tests']:
        if item['status']=='passed':continue
        node,message=item['node'],item['message']
        if 'No such file or directory' in message and 'e2e-server.log' in message:
            category,confidence,why='ENVIRONMENT_BLOCKER','CONFIRMED','Missing ignored .local directory before the E2E server log opened; product request not exercised.65-case replay exists separately.'
        elif ('role "anon" does not exist' in message or 'sentinel roles' in message or 'role "timeker_ph3_supplemental_runtime" does not exist' in message):
            category,confidence,why='ENVIRONMENT_BLOCKER','CONFIRMED','Disposable cluster role prerequisite absent; failure before tested business property. Parent replays after explicit isolated role provisioning.'
        elif 'first_failure_grace_is_stable' in node:
            category,confidence,why='CONTRACT_FAILURE','CONFIRMED','Repeated failure changes actual grace instant across DST. Independent fixed-instant service/DB controls confirm fall+1h and spring-1h; UTC/nonDST stable.'
        elif item['status']=='skipped':
            category,confidence,why='ENVIRONMENT_BLOCKER','CONFIRMED','Explicit BROWSER_EXECUTABLE not selected for two in-memory usage browser widths.'
        elif 'native_single_slot_clear_browse_and_billing_periods' in node:
            category,confidence,why='CONTRACT_FAILURE','CONFIRMED','Actual native Billing lookup submits to business/work-selection endpoint. Independently reproduced fullcreate_app: clearclient400, validclientwrongpage200; native controls and submitted dates disappear.'
        elif 'fixed_fee_and_authorized_extra' in node:
            category,confidence,why='TEST_LOCATOR_AMBIGUITY','CONFIRMED','get_by_text Fixed fee matches visible h2 and hidden help-dialog h3; strict locator fails before assertion of visible screen. No fee defect or axe violation demonstrated.'
        elif 'review_confirmation_stop_and_templates_use_native_forms' in node:
            category,confidence,why='STALE_SYNTHETIC_FIXTURE','CONFIRMED_STATIC','Mock transport serves HTML for /auth/session, while current sessionpreflight requires JSON before POST. JSfalse case and realowner flow are separate; no product send defect demonstrated.'
        elif 'week_metrics_keep_global_scope_clock_and_editor' in node:
            category,confidence,why='STALE_DOMAIN_FIXTURE','CONFIRMED_STATIC','Fixture creates new clients/projects then finalizes historical work without explicit rate choice. PH3 correctly rejects invented historical rate before browser exercise.'
        elif 'full_preset_tiles_and_semantic_work_colors' in node or 'complete_browser_workflow' in node:
            category,confidence,why='SUPERSEDED_UI_ASSERTION','CONFIRMED_STATIC','Expects Create draft statement button; accepted PH3 selective billing uses Choose work batches before draft preparation. Existing draft-action class remains on actual button.'
        elif 'dashboard_panels_and_chart_switch_keep_distinct_actions' in node or 'dashboard_five_panels_keep_independent_pages_chart_and_navigation' in node:
            category,confidence,why='SUPERSEDED_UI_ASSERTION','CONFIRMED_STATIC','Expects aria-hidden future cells or empty future title; accepted D084 requires explicit dated Future date/No recorded work yet titles and readable placeholder explanation.'
        elif 'test_without_javascript' in node:
            category,confidence,why='SUPERSEDED_UI_ASSERTION','CONFIRMED_STATIC','Aria snapshot shows saved0:15 in entry/history and Batch total0:15. Test expects old Weekly total label; no lost minutes demonstrated.'
        elif 'modified_consent_rejects_without_callback_or_grant[csrf]' in node:
            category,confidence,why='OBSOLETE_TAMPER_INJECTION','REFUTED_AS_PRODUCT_DEFECT','DOM invalidCSRF is replaced by valid fresh token in session_recovery preflight. Independent rawinvalidPOST403/zero grants and validcontrol302/+1grant; real source JS confirms replacement.'
        elif 'ERR_ABORTED' in message:
            if navigation and navigation['counts']=={'passed':4}:
                category,confidence,why='TEST_ASYNC_NAVIGATION_RACE','CONFIRMED','Exact4-node baseline and observedcopy fail; trace shows sessionpreflight pending while test launches goto, then resumedPOST aborts competing navigation. Zero dialogs. Samecopiedtests with explicit completed-save URL/FinalizedDOM waits4PASS plus new-session SQL readback; product source unchanged.'
            else:
                category,confidence,why='UNRESOLVED_BROWSER_NAVIGATION','SUSPECTED','Navigation interrupted after prior interactions. Needs isolated completion-wait/request/dialog trace.'
        else:category,confidence,why='UNCLASSIFIED','BLOCKED','Requires further trace inspection.'
        classifications.append({'run':run['source'],'node':node,'raw_status':item['status'],'classification':category,'confidence':confidence,'reason':why})

finding={'id':'BILLING-NATIVE-LOOKUP','category':'CONTRACT_FAILURE','status':'CONFIRMED','severity':'medium',
         'title':'Native Billing client search/paging invokes work selection and loses selector form',
         'requirement_sources':['docs/design/DESIGN_SPEC.md:334-338','docs/DECISIONS.md:D048'],
         'locations':[{'path':'app/web/templates/billing.html','line':4},{'path':'app/web/templates/lookup.html','line':17},{'path':'app/main.py','line':1539}],
         'snapshot':'1036d705f7f3721e2fa83df67cf913a40dad65b8','configuration':'test/fullcreate_app, native noJS behavior; selector_page_size1/search_limit4; own loopback diagnostic_test',
         'minimal_input':{'client_id':'','period_start':'2026-10-01','period_end':'2026-10-31','_lookup':'client_id:search'},
         'expected':'HTTP200 Billing selector page with preserved dates, searched/paged client options; no business navigation',
         'observed':'Rendered action/billing/work receives native lookup submit. Clearclient400 Invalidrequest; selectedclient200 workpage. Both lose lookup/periodediting controls. Normal validbusinesssubmit200workpage is positive control.',
         'repro':'python repro/run_check.py billing-native-lookup-r2 <audit>/repro/billing_native_lookup.py',
         'evidence':['evidence/billing-native-lookup.json','evidence/billing-native-lookup-r2.log','evidence/billing-native-lookup-r2.receipt.json','evidence/browser-complete.xml'],
         'impact':'NoJS user cannot search/page Billing client selector; clearing the sole selected record under page size1 cannot recover a different client and entered dates disappear with errorpage',
         'alternatives_refuted':'PH3 workselection is accepted business behavior, but shared selector fallback remains explicitly required; actual Searchbutton is submitted, not Choosework action. Validclient control independently shows the wrong branch even without validationfailure.',
         'correction':'Route native selector actions back through Billing form rendering with retained form state; only explicit Choosework reaches/billing/work. Verify Search/Previous/Next with empty/selectedclient, native/JS and size1/multipage.',
         'audit_instrumentation_note':'Initial probe assumed422; actual application errorhandler returns400. Initial failedoracle/log preserved; corrected probe reproduces same observed defect exit0. Original product untouched.',
         'capabilities_affected':['C11','C27']}

result={'snapshot':'1036d705f7f3721e2fa83df67cf913a40dad65b8','runs':[{'source':x['source'],'counts':x['counts']} for x in [backend,browser,recovered] if x],
        'classifications':classifications,'findings':[finding],
        'a11y_qualification':'None of the original17 plus recovered6 browser failures is an axe violation. Initially65 setup errors did not exercise accessibility. Successful cases/replays remain separately counted; no global WCAG certification.',
        'usage_B03_refutation':'Confirmed conditional source defect: accepted disabled-by-default public collector is excluded from anonymous middleware routes; activation deferral does not waive source readiness. No actual Stage activation claimed.',
        'csrf_refutation_evidence':['evidence/oauth-csrf-refutation.json','evidence/oauth-csrf-refutation-r2.log','evidence/session-preflight-csrf.json'],
        'navigation_refutation_evidence':['evidence/browser-navigation-diagnosis.xml','evidence/browser-navigation-observed.xml','evidence/browser-navigation-waited.xml','evidence/navigation-race-proof.json'],
        'additional_semantically_reviewed_files':['app/web/static/session_recovery.js','app/web/static/settings_cache.js','app/db.py','app/usage.py','app/web/templates/lookup.html','tests/e2e/test_lookups_browser.py','tests/e2e/test_sending_browser.py','tests/unit/test_sending_templates.py','docs/optional-usage-implementation.md'],
        'additional_sampled_files':['app/main.py','app/tenancy.py','app/subscription_billing.py','tests/e2e/test_stage_refinements.py','tests/e2e/test_work_management.py','tests/e2e/test_delegated_oauth_browser.py','tests/e2e/test_onboarding_browser.py','tests/integration/test_subscription_billing.py','tests/integration/test_public_admission.py','tests/integration/test_auth_notice.py','tests/integration/test_email_start_retries.py','tests/integration/test_recovery_rehearsal.py','tests/integration/test_operation_limits.py'],
        'qualification':'Raw unsuccessful runs stay unsuccessful. Do not sum repeated nodes as new tests or present aggregate reruns as one full green invocation. Further parent recovery runs may supersede only individual node decisions.'}
(AUDIT/'reviews/suite-triage.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
lines=['# Clasificación de suites capturadas','',f'Snapshot `{result["snapshot"]}`. Sin cambios de producto.','',
       'Los resultados originales conservan sus fallos y errores; los replays son ejecuciones separadas.','']
for run in result['runs']:lines.append(f'- `{run["source"]}`: {run["counts"]}')
lines+=['','## Hallazgo funcional confirmado','',finding['title'], '',
         'Billing nativo envía Search/Previous/Next al endpoint de trabajo. Con cliente vacío devuelve400 y pierde controles/fechas; con cliente válido devuelve200 pero abre la selección de trabajo. La prueba independiente extrae acción/botón del HTML real y mantiene un control positivo de la acción comercial. No usa imports de tests ni parches del router. Véanse `billing-native-lookup.json`, r2log/receipt y script.','',
         'Fuentes: `DESIGN_SPEC.md:334-338`, D048, `billing.html:4`, `lookup.html:17-19`, `main.py:1539`. Corrección futura: conservar dispatch nativo de lookup y estado de formulario antes de la selección comercial.','',
         '## Distinción de fallos de entorno y producto','',
         '- Backend:129 errores por rol anon ausente y1 por sentinelroles; dos fallos por supplementalruntime ausente. Se produjeron antes de la propiedad de negocio. El tercer fallo es la duración/invariancia de grace en DST, reproducida independientemente por la pasada de comportamiento.','',
         '- Browser:65 errores por carpeta.local ausente; replay59PASS/6FAIL. Las selecciones Fixedfee chocan con ayuda oculta. Sending sintético no implementa el nuevo endpointJSON de sesión. Los fixtures de tarifas históricas incumplen el nuevo contrato PH3; antiguos botones y títulos futuros quedaron superados por decisiones aceptadas.','',
         '- CSRF OAuth: refutado como defecto. El nuevo preflight reemplaza el valorDOM inválido antes de enviar. RawPOST inválido devuelve403 y no crea grants/codes; control válido devuelve302 y crea uno. Evidencias independientes conservadas.','',
         '- Los cuatro ERR_ABORTED se resolvieron como race del test: baseline exacto4FAIL; copia observada4FAIL con secuencia GET/auth/session pendiente → goto inmediato → POST reanudado aborta la navegación. No hay diálogos. La misma copia con esperas explícitas de save completado/estado Finalized pasa4/4 y verifica persistencia desde sesión SQL nueva. El producto no cambió; los resultados originales conservan sus fallos.','',
         result['a11y_qualification'],'',result['qualification'],'']
(AUDIT/'reviews/suite-triage.md').write_text('\n'.join(lines),encoding='utf-8')
print(json.dumps({'runs':result['runs'],'classifications':dict(Counter(x['classification'] for x in classifications)),'findings':[finding['id']]},indent=2))
