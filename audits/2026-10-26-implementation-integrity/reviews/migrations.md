# Revisión semántica de migraciones, modelos y SQL

Snapshot evaluado: `1036d705f7f3721e2fa83df67cf913a40dad65b8`. Se leyó por completo cada archivo de `alembic/versions/` (34), `alembic/env.py`, los tres `scripts/postgres-*.sql`, los 17 módulos `app/*models.py` y `app/db.py`. El ledger adjunto identifica hash, líneas y límites por archivo. Un fragmento truncado de PH3.010 se volvió a leer completo; no se acredita lectura por grep.

## Resultado

No se confirmó un defecto nuevo de migración o de guard financiero en esta pasada. La cadena completa aplica a una base vacía desechable y converge a `ph3_017_operation_limits`. Los 59 modelos tienen sus 59 tablas, sin columnas ausentes/extra ni diferencias de tipos compilados para PostgreSQL. El catálogo contiene 150 CHECK constraints. La comparación automática no compara semánticamente cada CHECK ni trigger; sus definiciones se revisaron separadamente.

Existe una diferencia de metadatos: `Project.status` tiene default de servidor `draft` instalado por PH3.007, pero el mapper declara solo default Python. No se encontró un comportamiento erróneo actual: las inserciones ORM proporcionan `draft`, y el default instalado es el mismo estado. Se registra como deriva de mantenimiento, sin elevarla a incumplimiento confirmado ni proponer una migración que quite el default por accidente.

## Integridad preservada

- Los guards de invoice/line/artifact/audit y las restricciones de pagos continúan instalados. Las operaciones de parent lock usan órdenes estables; las funciones de guard se fijan al schema instalado.
- PH3.010 añade ordinales y rate provenance sin inventar tasas históricas. Agrega el límite diario de 1440 minutos entre batches y el cap semanal agregado; el guard de reprice no permite modificar fuentes que todavía tengan claims.
- PH3.011 vuelve permanentes los claims de publicaciones `ph3.v1`, prohíbe convertirlas a Void y compara `source_ids` contra los claims exactos. No reescribe el significado de Void histórico.
- PH3.012 elimina deliberadamente la unicidad invoice-credit y la unión obligatoria Void/crédito, instala límites acumulativos bajo lock de invoice y conserva guard de inmutabilidad de créditos. Los pagos existentes ya no bloquean emitir créditos. La aritmética SQL usa NUMERIC.
- PH3.015 y .016 mantienen revisiones de Sending y los bytes/revisión/destinatario/mensaje de Publish-and-send; no reactivan por sí mismas planes detenidos o inciertos.
- Las migraciones PH3.012, .015 y .016 rechazan downgrade destructivo expresamente; otras migraciones con custody requieren tablas vacías o preservan guards compatibles. Es una decisión legítima de conservación, no un no-op que pretenda implementar downgrade completo.
- Los SQL de Compose son explícitamente desarrollo/datos ficticios y permiten que su rol posea la base. El SQL de grants hospedado concede DML limitado y no otorga propiedad, CREATE, TRUNCATE o TRIGGER. Las credenciales y grants operativos efectivos de Stage/PROD no se inspeccionaron; no se infieren desde este script.

## Prueba independiente de guards instalados

`repro/migration_guard_probe.py` crea una base nueva únicamente en loopback y usa SQL/ORM directo, fuera de hooks y helpers pytest. Construye una publicación sintética de tres minutos a USD1/h por USD0.05, con bytes PDF placeholder identificados como sintéticos. Eso no es una prueba de render PDF.

Resultado: 14 comprobaciones. Diez mutaciones se rechazan con SQLSTATE P0001: total/snapshot/linea emitidos, edición/borrado de artifact, borrado de claim, conversión a Void, edición de minutos publicados, borrado de claim después de crédito completo y edición de crédito emitido. Se aceptan tres créditos de un minuto por USD0.02, USD0.01 y USD0.02; la suma independiente es USD0.05. Una conexión nueva confirma original Issued, total/snapshot/bytes/hash intactos, tres minutos trabajados y un claim permanente después del crédito completo.

La primera versión del harness falló antes del segundo challenge porque SQLAlchemy interpretó el `:true` de JSON inline como bind. Se conserva `evidence/migration-guard-probe-initial-error.json`; no se clasifica como defecto del producto. La versión corregida usa `jsonb_build_object` y una base nueva. La comparación inicial de tipos genéricos también produjo aliases UUID/CHAR, TIMESTAMP/DATETIME y BYTEA/BLOB; se conservó y se corrigió compilando ambos tipos al mismo dialecto PostgreSQL.

## Evidencia y límites

- `evidence/migration-model-compare.json`: catálogo limpio, tipos, diferencias, funciones y triggers.
- `evidence/migration-model-compare-initial.json`: salida de instrumentación previa, conservada.
- `evidence/migration-guard-probe.json`: las 14 decisiones y readback independiente.
- `repro/migration_model_compare.py` y `migration_guard_probe.py`: comandos reproducibles; los targets nuevos no se reutilizan silenciosamente.

La prueba usa PostgreSQL local y datos nuevos. No es una migración de todos los historiales posibles, una restauración de Stage, un test de concurrencia exhaustivo ni una verificación de privilegios de despliegue. La suite del agente principal aporta sus propios resultados, sin sumarlos a estas 14 decisiones como si fueran casos únicos de la misma suite. La debilidad singleton de readiness se trata en `refutation.md`, separada de la correcta instalación de estos guards.
