# Revisión separada de integridad de evaluación y adaptador

Snapshot: `1036d705f7f3721e2fa83df67cf913a40dad65b8`, `codex/ph3-stage`, 26-10-2026. Esta pasada no repara ni despliega el producto. La revisión se concentra en el mecanismo de evaluación, runners, fixtures, build, dependencias y adaptador Cloudflare; no sustituye la revisión del dominio realizada por otras pasadas.

## Resultado

No se observó manipulación del evaluador ni selección de respuestas por `PYTEST_CURRENT_TEST`, fixtures o nombres de tests en la ruta efectiva revisada. No se atribuye intención ni autoría. Se confirmó una debilidad de cobertura de la suite del adaptador y una contradicción documental de bajo impacto. La conexión del export Stage actual se comprobó después mediante un verificador independiente, con el SDK/contenedor sustituido explícitamente por un boundary sintético.

## Ejecución reproducible

- `python repro/run_evaluator_checks.py`: Node `v24.18.0`, suite nativa de 55 tests: 55 PASS, 0 FAIL, 0 SKIP, 0 CANCELLED, 0 TODO. `node node_modules/typescript/bin/tsc --noEmit` con TypeScript `7.0.2`: exit 0. Comandos completos, cwd, duración y salidas en `evidence/evaluator-runs.json` y logs asociados.
- `python repro/evaluation_inventory.py`: 1.242 definiciones Python `test_*`, 5.002 nodos `assert`. No son cantidades descubiertas parametrizadas ni una afirmación de revisión semántica completa de cada test. Inventario de cada archivo en `evidence/evaluation-inventory.json`.
- Cinco dependencias Node raíz tienen exactamente la versión declarada en `package-lock.json`. `uv.lock` v1/revisión5 contiene 61 paquetes y coincide con el requisito Python del proyecto. No se revisó exhaustivamente código de dependencias ni binarios.
- No existe configuración CI versionada reconocida (`.github`, GitLab, CircleCI, Jenkins, Azure Pipelines) en este snapshot. Esto no demuestra ausencia de checks externos del repositorio remoto. No se inspeccionó ni afirmó una ejecución remota.

## EVAL-01 — WEAK_TEST — CONFIRMED — media

La suite Node ejecuta los helpers `proxyRequest`, firma interna, validación de proveedores y transporte de correo, pero no invoca el `default.fetch` exportado por `deploy/cloudflare/src/index.ts:68-70`. Sus comprobaciones de entrada real son lecturas de fuente/regex en `test/proxy.test.mjs:302-305` y `test/stage-archive.test.mjs:58-64`.

Control negativo mínimo: en una copia desechable sustituir solo el cuerpo del export `fetch` por `return new Response("Simulated success without product execution", {status:200});`. Se elimina toda ejecución de proxy/contenedor del recorrido público. La suite completa conserva **55 PASS, exit 0**. El control muestra que esa suite no acredita la conexión de su entrada real. No demuestra que la versión evaluada contenga el no-op, ni que el autor intentase engañar.

Reproducción: `python repro/adapter_negative_controls.py`. Evidencia: `evidence/adapter-control-entrypoint-false-success.log`, baseline asociado y `evidence/adapter-negative-controls.json`. Se validó el baseline antes de cada mutación. Se restauraron bytes y SHA-256; el producto original no fue editado.

Refutación/alternativas: las suites de helpers sí detectan tres errores relevantes (aceptar correo no persistido, éxito sin envío y forwarding adulterado). Los checks de texto son útiles para política/configuración, pero no sustituyen la invocación del handler. La ausencia del test puede ser una omisión ordinaria; no hay evidencia de manipulación deliberada.

Verificación independiente recuperada: `python repro/run_adapter_entrypoint.py` instrumenta únicamente los imports del SDK en una copia separada, conserva el código del export y ejecuta el handler real contra el proxy y un boundary de contenedor sintético. Comprueba respuesta de estado201/cuerpo aleatorio, resolución exacta del binding, una única llamada, denegaciones internal/origen/configuración y error upstream503. El baseline pasa y el no-op superviviente falla por assertion. `evidence/adapter-independent-entrypoint.json` y sus dos logs preservan ambos resultados. Esto acredita conexión del código actual hasta el boundary; no acredita ejecución de Cloudflare ni persistencia PostgreSQL real.

Corrección propuesta para un snapshot futuro: añadir una prueba del export completo y una del lifecycle del contenedor que fallen al desconectar el handler. Mantener tests de helpers. No se modificó la suite del producto.

## EVAL-02 — CONTRACT_FAILURE documental — CONFIRMED — baja

`deploy/cloudflare/README.md:40-42` afirma que no hay handler cron configurado. `src/index.ts:63-66` contiene `scheduled` y `wrangler.jsonc:12` configura el cron diario `17 2 * * *`. La implementación de archivo programado existe y sus cinco tests pasan; no es una simulación. El bloque denominado “Current release routing” permanece fechado 16-10-2026 (`README.md:76`) y el propio documento remite al registro de entrega vigente.

Esperado: límites y capacidades del adaptador coherentes con el snapshot. Observado: la descripción de runtime conserva la exclusión previa del job. Evidencia estática inequívoca; no se ejecutó cron remoto. La remisión a registros posteriores limita el impacto pero no elimina la contradicción. Corregir esa descripción y mantener la historia identificada como tal.

## Controles negativos brutos

Herramienta: orquestador Python propio y runner nativo Node24.18.0; sustitución dirigida, sin framework masivo de mutación. Cuatro mutaciones válidas: 3 detectadas, 1 superviviente; 0 equivalentes, inválidas o timeouts. La superviviente se conserva en el resultado original y fue detectada posteriormente por un mecanismo independiente. No se presenta este cociente como score de integridad del producto. Copy y source conservan baseline por SHA-256.

## Señales examinadas y alternativas legítimas

- `tests/conftest.py:23-32` limita la DB a loopback y sufijo `_test`, rechaza `staging`/`production`, configura migración real a head. El fixture añade un plan Pro de ingeniería (`63-73`) y habilita login local (`52`); lo declara explícitamente y no representa un pago de proveedor. Los tests con ese fixture no prueban la activación comercial ni el login Google real.
- E2E arranca un servidor real con login local y Contact preview, separado de producción. CSP se evita solo en contextos de auditor axe, según `tests/e2e/README.md`; no acredita comportamiento CSP ni prueba login de proveedor.
- Solo se encontraron dos sitios de skip explícito: ausencia de Node para Paddle.js (`tests/unit/test_paddle_templates.py:188`) y ausencia de `BROWSER_EXECUTABLE` para dos anchos del flujo de uso (`tests/integration/test_usage_browser_flow.py:28`). No hay `xfail`, hooks de colección/finalización pytest ni un runner que convierta fallos en exit0 en las superficies rastreadas.
- La única coincidencia AST de comparación aparentemente idéntica (`tests/e2e/test_browser.py:51-54`) ejecuta **dos solicitudes PDF distintas**: es una comprobación de determinismo, no un fixture comparado consigo mismo. No acredita por sí sola que el PDF sea semánticamente correcto; hay pruebas separadas de texto/totales.
- `app/demo.py` importa `unittest.mock.patch` para fecha histórica de PDFs ficticios. Antes de seed exige entorno no hosted, DB local `_demo`, origen loopback, propietario ficticio y base vacía. No se observó filtración a una configuración hosted prometiendo trabajo real.
- El logger Worker Stage es no-op por diseño (`src/proxy.ts:33-36`) y tiene observabilidad desactivada; la documentación lo declara. La producción conserva logger JSON y la aplicación Python conserva su logging. Esta constante no constituye por sí misma un decoy.
- `scripts/dev.ps1` propaga errores de sync/migrate/seed; su comando final deja el resultado del proceso uvicorn. `scripts/ph3_capacity_probe.py` usa READ ONLY/timeout, distingue contadores acumulados de capacidad y no presenta un resultado de throughput ficticio.
- `tests/timecard_history.py` deshabilita un trigger solo dentro de DB loopback `_test` con rol administrador de test expresamente seleccionado y transacción controlada; exige que el guard vuelva a estar habilitado. Es creación de historia sintética, no bypass de producción.
- Git disponible: no aparecen eliminaciones de archivos de tests. Los cambios muestreados `e8e3ff0` y `2feb479` añaden comprobaciones alineadas con contratos declarados; no se observó debilitamiento en esas muestras. No se auditó semánticamente cada commit histórico.

## Cobertura y límites

Ledger detallado en `reviews/evaluator.json`. Todos los archivos de tests se inventariaron mediante AST y los 55 casos Node se ejecutaron. Se revisaron semánticamente los runners/configuraciones, los siete archivos fuente TypeScript del adaptador, siete módulos Node y los tests Python explícitamente listados. Las restantes pruebas Python quedaron inventariadas/rastreadas, con ejecución global a cargo de la pasada principal; no se marcan aquí como revisión semántica exhaustiva. Los grandes documentos de entrega se muestrearon y no se usan como prueba vigente. No se ejecutaron proveedores, Docker build/dry-run ni CI remoto en esta pasada.
