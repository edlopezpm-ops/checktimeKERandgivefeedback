# Reproducción de la auditoría

La versión evaluada es `1036d705f7f3721e2fa83df67cf913a40dad65b8`, más el master sin seguimiento identificado por SHA256 en `evidence/snapshot-before.json`. No aplicar correcciones al baseline antes de reproducir. Las rutas absolutas de los recibos identifican esta máquina; los scripts auxiliares pueden ajustarse en una copia externa para otra ubicación, sin cambiar el producto.

## Entorno observado

- Windows, Python3.13.4, uv0.13.0, PostgreSQL18.4 nativo, Node24.18.0, Microsoft Edge/Playwright del lock; TypeScript7.0.2.
- `uv sync --locked --all-groups` en la copia desechable. Pango/WeasyPrint procede del runtime local ya instalado; el lock instala WeasyPrint70.0. No Docker CLI disponible.
- Cluster exclusivo `sandbox/pgdata`, loopback127.0.0.1:55526. No se conecta el servicio PostgreSQL personal/hosted. Base principal `timeker_audit_test`, otra para browser, otra para migraciones y bases `behavior_*_test`/independientes. Todos los datos son sintéticos.
- El administrador del cluster de prueba prepara roles `timeker_app` (migración/harness), `timeker_test` (sólo fixture), `anon`, `authenticated`, `service_role` (sentinels NOLOGIN), `timeker_ph3_baseline_runtime` y `timeker_ph3_supplemental_runtime` (LOGIN sin privilegios). Los tests de aislamiento crean roles no propietarios adicionales; no se representa la conexión de migración como evidencia de aislamiento runtime.
- El initdb de este cluster temporal usa trust **sólo en loopback** y no guarda password real. La reproducción hosted-shaped usa otro cluster local con TLS verify-full y claves efímeras, excluidas de la publicación.

## Comandos y salidas

Los comandos exactos, cwd, entornos depurados, tiempos y códigos de salida están en cada `evidence/*.receipt.json`; XML y logs conservan fallos originales. `repro/run_check.py` limpia variables TIMEKER heredadas y fija destinos locales. No ejecutar sus fixtures contra un servidor remoto o una base real.

Desde la copia desechable preparada:

```powershell
python <audit>/repro/run_check.py backend-complete -m pytest tests --ignore=tests/e2e --junitxml=<audit>/evidence/backend-complete.xml -q --tb=short
python <audit>/repro/run_check.py browser-complete -m pytest tests/e2e --junitxml=<audit>/evidence/browser-complete.xml -q --tb=short
python <audit>/repro/run_check.py ruff -m ruff check app tests scripts
python <audit>/repro/run_check.py mypy -m mypy app
```

Usar base distinta para browser y no ejecutar dos suites contra las mismas tablas. El wrapper admite `AUDIT_DATABASE_NAME` con nombre local `timeker_*_test`. Crear `.local` en la copia antes del servidor E2E. Los dos tests de usage browser requieren `BROWSER_EXECUTABLE` apuntando a Edge. La evidencia distingue tests de app completa de los que montan routers aislados.

Para oráculos: `duration_oracle.py`, `rounding_probe.py`, `independent_finance.py`, `fresh_process_reader.py`, `content_independent.py`, `behavior_independent.py` y los `behavior_*.py` ejecutados por sus respectivos recibos. Para guards: `migration_guard_probe.py` y `migration_model_compare.py`, según rutas efectivamente incluidas. Las muestras monetarias y DST incluyen entradas/semillas exactas en JSON.

`finance_negative_controls.py` y `adapter_negative_controls.py` escriben sólo copias desechables, introducen mutaciones dirigidas y verifican restauración por hash. No ejecutar sobre el checkout evaluado. El entrypoint independiente ejecuta el export/proxy reales con stub de SDK/container; no acredita infraestructura Cloudflare real.

## Recalcular y revisar

```powershell
python repro/calculate_score.py --check
```

Esto compara todos los pesos contra `reviews/contract.json` y recomputa W/P/F/U y sus fracciones desde MATRIX, sin invocar el producto ni confiar en un PASS del runner del repositorio.

Los reintentos de entorno sólo recuperan los nodos identificados en XML. `TEST_RESULTS.json` conserva el último resultado del mismo nodo y todos los runs; no suma ejecuciones solapadas ni afirma una suite completa verde. Las copias instrumentadas de navegador permanecen separadas.

No hay datos/credenciales reales, env privada, bases, clave TLS, `.venv`, node_modules, distribución Python ni código privado completo dentro del paquete publicado. Las claves/configuraciones sintéticas de los probes no son credenciales hospedadas. Los recibos conservan las ubicaciones locales para trazabilidad.

Una reparación posterior exige otro snapshot, nuevos casos y revalidación. Este paquete no autoriza modificar PROD, proveedores, identidades, contratos, facturas reales o configuración hospedada.

Public path aliases and withheld binary evidence are documented in [PUBLICATION](PUBLICATION.md). Configure aliases in an external copy before executing machine-bound probe templates.
