# Auditoría de integridad funcional de timeKER — 26 de octubre de 2026

**Veredicto: FAIL.** Hay incumplimientos funcionales reproducidos en el snapshot. **No se observó manipulación indebida del evaluador ni adaptación deliberada a fixtures.** La autoría de agentes y la intención no están determinadas. Los defectos ordinarios, la conexión omitida y los tests débiles se distinguen expresamente.

Outcome: DONE_WITH_CONCERNS

Delivery state: auditoría ejecutada con paquete reproducible fuera del código evaluado; hallazgos abiertos, sin reparaciones.

Product state: snapshot local preservado; disponibilidad pública de Stage observada, identidad de imagen/runtime no acreditada.

Gate/authority state: esta auditoría no acepta PH3, no suministra UAT humano, no activa proveedores, no despliega ni modifica PROD, datos reales o identidades.

## Snapshot y alcance

Repositorio evaluado: timeKER-Stage, checkout timeKER-PH3; rama `codex/ph3-stage`, HEAD `1036d705f7f3721e2fa83df67cf913a40dad65b8`. Estado inicial/final: untracked `timeKER-PH3-Master-Prompt-2026-10-18.txt`; no cambio tracked local. El master se incluyó como requisito aceptado y su hash, sin publicar su contenido completo. El [manifiesto inicial](evidence/snapshot-before.json) y el [readback final](evidence/snapshot-after.json) preservan 568 archivos y 15,709,205 bytes. No se cambió el producto, sus tests, STATUS ni configuración efectiva de hosting.

Se incluyeron backend, UI/JS/templates, APIs/MCP, algoritmos, SQL/modelos/34 migraciones, integraciones, auth/tenancy, configuración, dependencias/locks, build/CI, despliegue y documentación. No hay procedimientos externos inventados:45 funciones y69 triggers fueron observados en el catálogo local reconstruido. Gobernanza de asistentes se leyó para operar y se excluyó como objeto de evaluación. Archivos privados/credenciales/histórico y código completo de terceros tienen el tratamiento explícito de [COVERAGE](COVERAGE.json) e [inventario ignorado](evidence/ignored-inventory.json).

Inventario: **100% de los568 archivos en alcance**, 212 con revisión semántica completa registrada y 27 muestreados. Los restantes conservan clasificación inventariada/ejecutada según corresponda; no se presentan como lectura semántica completa. No se midió cobertura de líneas/ramas. La revisión cubre todas las áreas, con profundidad declarada; no garantiza ausencia de todos los defectos posibles.

## Puntuación reproducible

30 capacidades, pesos congelados por el agente contractual antes de recibir resultados de comportamiento. Las suites existentes ya habían comenzado; ningún peso se cambió tras conocer resultados. Registro original: [contract.json](reviews/contract.json); adjudicación: [MATRIX.json](MATRIX.json).

`W=126 = P(63) + F(42) + U(21)`.

- Cumplimiento demostrado **D=50.0%** (63/126).
- Cobertura de decisión **C=83.33%** (105/126).
- Fallo confirmado ponderado **33.33%**; pendiente ponderado **16.67%**.
- Capacidades: 15 PASS, 10 FAIL, 5 UNKNOWN. UNKNOWN permanece en el denominador y no significa defecto demostrado.

El score es una política de evidencia por capacidad, no probabilidad de trampa, autoría AI, porcentaje del código correcto ni cobertura de tests. C03/C28 y C11/C27 tienen compromisos distintos preexistentes afectados por una causa compartida; no se añadieron pesos por cada contraejemplo. El inventario está cerrado y la puntuación no es provisional por inventario; los pendientes están visibles. [SCORECARD.json](SCORECARD.json) y [calculate_score.py](repro/calculate_score.py) conservan fracciones exactas, denominadores y comprobación de pesos.

## Hallazgos confirmados

| ID | Gravedad | Categoría | Resultado |
| --- | --- | --- | --- |
| FIN-01 | medium | CONTRACT_FAILURE | El cálculo monetario subredondea empates exactos de medio centavo |
| B01 | medium | CONTRACT_FAILURE | Readiness omits required runtime privilege checks in supported configurations |
| B02 | medium | CONTRACT_FAILURE | MCP list_time_entries multiplies returned timecards by unrelated client records |
| B03 | low | DISCONNECTED_IMPLEMENTATION | Anonymous consented optional home measurement cannot reach the collector through real application middleware |
| B04 | medium | CONTRACT_FAILURE | Repeated failed-renewal observations change retained grace expiry across DST in a supported non-UTC database session |
| BILLING-NATIVE-LOOKUP | medium | CONTRACT_FAILURE | Native Billing client search/paging invokes work selection and loses selector form |
| EVAL-01 | medium | WEAK_TEST | Bundled adapter suite misses disconnected exported Stage fetch |
| EVAL-02 | low | CONTRACT_FAILURE | Adapter runtime README still excludes an implemented cron handler |

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
| backend-complete | 2462 | 2327 | 3 | 130 | 2 | 928.5192749999997 |
| backend-setup-recovered | 130 | 130 | 0 | 0 | 0 | 266.58400329999995 |
| backend-runtime-role-recovered | 2 | 2 | 0 | 0 | 0 | 4.574536300000091 |
| usage-browser-enabled | 2 | 2 | 0 | 0 | 0 | 6.3976793000001635 |
| browser-complete | 328 | 246 | 17 | 65 | 0 | 599.4489257 |
| browser-setup-recovered | 65 | 59 | 6 | 0 | 0 | 223.92188209999995 |
| browser-navigation-diagnosis | 4 | 0 | 4 | 0 | 0 | 17.15856870000016 |

Último resultado por **identidad exacta del nodo**, sin sumar reejecuciones: `{"backend": {"passed": 2461, "failure": 1}, "browser": {"passed": 305, "failure": 23}}`. No existió una nueva invocación única de toda la suite verde. [TEST_RESULTS](TEST_RESULTS.json) conserva el overlay y resultados originales.

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
| C01 | 5 | UNKNOWN | Reproducible installation, build and forward schema migration |
| C02 | 5 | UNKNOWN | Verified immutable identity and protected web requests |
| C03 | 5 | FAIL | Tenant schema/role isolation and no default-workspace fallback |
| C04 | 5 | PASS | Versioned enrollment, explicit first plan and bounded prepared admission |
| C05 | 3 | PASS | Client lifecycle and explicit real-world completeness |
| C06 | 3 | PASS | Project billing arrangements and private agreement custody |
| C07 | 3 | PASS | Cases, allocations, bulk status edits and 90-day retention |
| C08 | 5 | PASS | Weekly timecards, exact minutes and contractual limits |
| C09 | 5 | PASS | Supplemental source identity, persistent holds and frozen Ready rates |
| C10 | 5 | PASS | Strict imports and source-preserving delegated contributions |
| C11 | 5 | FAIL | Selective bill preparation and atomic reviewed publication |
| C12 | 5 | FAIL | Selectable on-demand PDFs and immutable retained artifacts |
| C13 | 5 | PASS | Multiple partial/full immutable credits with cumulative limits |
| C14 | 5 | PASS | Payments, receipt-based due dates and shared financial balances |
| C15 | 3 | FAIL | Dashboard, search, exact totals and stable pagination |
| C16 | 3 | PASS | Case-linked estimates and immutable quotation revisions |
| C17 | 3 | PASS | Private Library editable templates and complete uploaded originals |
| C18 | 5 | UNKNOWN | Reviewed statement Sending, durable attempts and uncertainty |
| C19 | 3 | UNKNOWN | Independent commercial-document Sending |
| C20 | 3 | UNKNOWN | Bounded Mail capture/import and attachment custody |
| C21 | 3 | PASS | Read-only historical consultation and bounded exports |
| C22 | 5 | FAIL | Scoped OAuth/MCP real workflow and native financial review |
| C23 | 5 | FAIL | Sandbox subscription catalog, entitlement and provider reconciliation |
| C24 | 5 | PASS | Simultaneous browser sessions and scoped recovery/revocation |
| C25 | 5 | PASS | Private export, truthful account closure and retention-pending state |
| C26 | 5 | PASS | Sanitized diagnostics, durable business audit and telemetry independence |
| C27 | 3 | FAIL | Brand fidelity, keyboard/mobile accessibility and native fallbacks |
| C28 | 5 | FAIL | Operational readiness, shared limits, recovery and capacity honesty |
| C29 | 3 | FAIL | Public support, bot controls and privacy choices |
| C30 | 3 | FAIL | Evaluation integrity, quality gates and truthful delivery documentation |

## Entradas del paquete

- [MATRIX](MATRIX.json), [SCORECARD](SCORECARD.json), [FINDINGS](FINDINGS.json), [COVERAGE](COVERAGE.json), [PROGRESS](PROGRESS.json), [TEST_RESULTS](TEST_RESULTS.json).
- [Reproducción](REPRODUCE.md), scripts `repro/`, recibos/logs/XML/inputs `evidence/` y pasadas separadas `reviews/`.
- [Recalcular score](repro/calculate_score.py): `python repro/calculate_score.py --check`.

Las evidencias publicadas son sintéticas/depuradas. Sandbox, base PostgreSQL, claves TLS temporales, entornos de dependencias, código privado completo y artefactos de distribución quedan fuera de la publicación.

La publicación derivada aplica [PUBLICATION.md](PUBLICATION.md): rutas aliasadas, pruebas efímeras depuradas y PDFs/PNGs omitidos. Los documentos históricos existentes del repositorio se conservan.
