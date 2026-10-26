# Clasificación de suites capturadas

Snapshot `1036d705f7f3721e2fa83df67cf913a40dad65b8`. Sin cambios de producto.

Los resultados originales conservan sus fallos y errores; los replays son ejecuciones separadas.

- `backend-complete.xml`: {'passed': 2327, 'error': 130, 'failure': 3, 'skipped': 2}
- `browser-complete.xml`: {'error': 65, 'passed': 246, 'failure': 17}
- `browser-setup-recovered.xml`: {'passed': 59, 'failure': 6}

## Hallazgo funcional confirmado

Native Billing client search/paging invokes work selection and loses selector form

Billing nativo envía Search/Previous/Next al endpoint de trabajo. Con cliente vacío devuelve400 y pierde controles/fechas; con cliente válido devuelve200 pero abre la selección de trabajo. La prueba independiente extrae acción/botón del HTML real y mantiene un control positivo de la acción comercial. No usa imports de tests ni parches del router. Véanse `billing-native-lookup.json`, r2log/receipt y script.

Fuentes: `DESIGN_SPEC.md:334-338`, D048, `billing.html:4`, `lookup.html:17-19`, `main.py:1539`. Corrección futura: conservar dispatch nativo de lookup y estado de formulario antes de la selección comercial.

## Distinción de fallos de entorno y producto

- Backend:129 errores por rol anon ausente y1 por sentinelroles; dos fallos por supplementalruntime ausente. Se produjeron antes de la propiedad de negocio. El tercer fallo es la duración/invariancia de grace en DST, reproducida independientemente por la pasada de comportamiento.

- Browser:65 errores por carpeta.local ausente; replay59PASS/6FAIL. Las selecciones Fixedfee chocan con ayuda oculta. Sending sintético no implementa el nuevo endpointJSON de sesión. Los fixtures de tarifas históricas incumplen el nuevo contrato PH3; antiguos botones y títulos futuros quedaron superados por decisiones aceptadas.

- CSRF OAuth: refutado como defecto. El nuevo preflight reemplaza el valorDOM inválido antes de enviar. RawPOST inválido devuelve403 y no crea grants/codes; control válido devuelve302 y crea uno. Evidencias independientes conservadas.

- Los cuatro ERR_ABORTED se resolvieron como race del test: baseline exacto4FAIL; copia observada4FAIL con secuencia GET/auth/session pendiente → goto inmediato → POST reanudado aborta la navegación. No hay diálogos. La misma copia con esperas explícitas de save completado/estado Finalized pasa4/4 y verifica persistencia desde sesión SQL nueva. El producto no cambió; los resultados originales conservan sus fallos.

None of the original17 plus recovered6 browser failures is an axe violation. Initially65 setup errors did not exercise accessibility. Successful cases/replays remain separately counted; no global WCAG certification.

Raw unsuccessful runs stay unsuccessful. Do not sum repeated nodes as new tests or present aggregate reruns as one full green invocation. Further parent recovery runs may supersede only individual node decisions.
