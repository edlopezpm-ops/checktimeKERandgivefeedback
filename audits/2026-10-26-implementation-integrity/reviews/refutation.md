# Revisión independiente de refutación

Revisor: agente de reconstrucción contractual, separado de los autores de reproducciones. El contrato se congeló antes de recibir resultados de comportamiento. Esta revisión no modifica el producto y no atribuye intención ni autoría.

## R01 — Debilidad del test del entrypoint del Worker

**Confirmado; WEAK_TEST; gravedad media (P2).** Se intentó refutar la conclusión considerando que los tests sean deliberadamente unitarios y que los helpers sí ejecuten lógica real. Esa alternativa explica legítimamente su diseño, pero no elimina el hueco de integración: todos los tests actuales importan helpers; el entrypoint real se inspecciona con texto/expresiones regulares en `deploy/cloudflare/test/proxy.test.mjs:302-305` y `deploy/cloudflare/test/stage-archive.test.mjs:58-63`. El handler público real está en `deploy/cloudflare/src/index.ts:68-70`.

En la copia desechable, sustituir ese forwarding por un HTTP 200 constante deja los 55 tests verdes (`evidence/adapter-control-entrypoint-false-success.log`). Los controles sobre falsos acknowledgments de Mail, no enviar Contact y forwarding suplantado sí fallan: la suite conserva evidencia útil para esos helpers. Por ello no se invalida toda la suite ni se afirma manipulación del evaluador.

El oráculo adicional usa un cuerpo upstream impredecible, código 201, una invocación exacta del binding y rechazos de origen/configuración/ruta. El baseline pasa y la mutación falla por `200 != 201` (`evidence/adapter-independent-entrypoint.json`, `adapter-independent-mutated.log`). El revisor volvió a ejecutar el baseline restaurado con Node; devolvió `PASS`, cinco comprobaciones. El stub sustituye únicamente la dependencia SDK/container; el entrypoint exportado y `proxyRequest` del producto se ejecutan. Esto verifica el cableado local; no el proveedor ni un Worker desplegado.

La clasificación es debilidad del test de cableado, **no** FALSE_SUCCESS del snapshot original: su handler sí propaga el resultado de la dependencia en el baseline independiente. No se observó EVALUATOR_TAMPERING ni TEST_SPECIAL_CASING. Corrección propuesta: incorporar un test semántico del export real que compruebe el efecto y preserve estado/cuerpo/cookies/errores, además de tests unitarios de helpers. Verificación: este mutante debe fallar y los tres controles previamente detectados deben seguir fallando.

Contrato pertinente: auditoría solicitada, pasos 3 y 6; `docs/PROJECT_BRIEF.md:645-666` y master PH3:46,184-206. La capacidad C30 conserva peso 3, fijado antes de este resultado.

## R02 — Validación incompleta del rol en despliegue singleton

**Conclusión contractual: defecto condicional defendible; CONTRACT_FAILURE y éxito incorrecto de diagnóstico, gravedad media (P2).** Este es un fallo de preflight/deep readiness ante una configuración sobreprivilegiada, no prueba de que el runtime actual de Stage esté sobreprivilegiado ni de acceso explotable desde un usuario.

Se consideró la alternativa legítima: Docker/desarrollo local usa una base que el rol puede poseer, y no debería bloquearse por una regla de despliegue hospedado. README:61-72 describe ese ámbito. Sin embargo `app/tenancy.py:425-443` decide si realiza **todas** las comprobaciones propias del rol —superuser, createdb, createrole, bypassrls, propiedad de tablas, CREATE de esquema y membresías— únicamente por `len(checked)>1`, sin distinguir `settings.hosted`. Un tenant hospedado sin slots es admitido por `TenantRegistry` (`99-163`, `252-294`). El contrato de runtime no propietario aplica a cada schema, independientemente del número: `deploy/postgres/README.md:13-14,52-79`, `HOSTING.md:247-252`, master PH3:40.

Ruta real: `app/main.py:129-134` (startup) y `741-747` (diagnóstico protegido) llaman `registry.ready()`; `app/tenancy.py:349-356` llama la comprobación incompleta. El probe barato se documenta por separado en `358-370`; no se exige convertirlo en un escaneo completo en cada GET.

La reproducción inicial bajo `environment=test` prueba que se omite el guard en esa configuración, pero por sí sola no demuestra incumplimiento hospedado. La contradicción estática es independiente: no hay otro guard de atributos/propiedad para un descriptor singleton hospedado en Settings, session_factory ni la construcción del registro. La reproducción reforzada debe declarar cualquier adaptación de conexión local/TLS y no describirla como conexión cloud real. La evidencia de producción/Stage actual queda UNKNOWN, y los checks multi-tenant existentes no se invalidan.

Corrección propuesta: separar comprobaciones de privilegios propios (obligatorias siempre en hosted) de comprobaciones recíprocas (cuando existan otros tenants); mantener la excepción explícita de desarrollo/test. Verificación: singleton hospedado-shaped seguro pasa y sobreprivilegiado falla; desarrollo con base poseída sigue funcionando; multi-tenant y roles normales continúan con denegaciones recíprocas. Capacidades potencialmente afectadas C03/C28; no sumar un peso nuevo por cada subcheck.

## R03 — MCP duplica el mismo timecard por un cliente ajeno a la consulta

**Confirmado; CONTRACT_FAILURE; gravedad media (P2), capacidad C22.** Requisito: devolver el trabajo real del cliente/semana/batch solicitado, conservando IDs, versiones y límites de consulta (`master PH3:113-128`, `docs/PROJECT_BRIEF.md:699-710`).

`app/integration_routes.py:406-416` construye `select(Timecard)` sin unir Client y llama `active_card_predicate()`. Ese predicado usa `Client.timezone` y documenta expresamente que el caller debe unir Client a Timecard (`app/archiving.py:38-42`). SQLAlchemy añade entonces Client al FROM sin condición de asociación, generando un producto cartesiano.

La reproducción de comportamiento atraviesa OAuth/PKCE/tokens y la ruta MCP local: una entrada nueva de 37 minutos produce un único timecard. Antes de agregar el segundo cliente, la lectura explícita de ese mismo `timecard_id` devuelve una fila y `timecard` singular. Agregar un cliente Draft sin relación con la consulta hace aparecer dos resúmenes con el mismo UUID y vuelve `timecard` null (`integration_routes.py:476` usa longitud sin deduplicación). La entrada sigue teniendo 37 minutos y SQL cuenta una sola tarjeta persistida. No se demuestra creación duplicada de trabajo ni acceso a otro tenant.

Se intentó refutar por batches suplementales legítimos o artefacto de helpers. Ambos se descartan: la selección tiene UUID exacto; los dos resúmenes tienen el mismo UUID. El revisor ejecutó SQL independiente de solo lectura, sin helpers del producto, en el target sintético retenido: una tarjeta exacta y un cliente ajeno; cross join devuelve 2 filas y la asociación explícita `c.id=t.client_id` devuelve 1. Evidencia: `evidence/refutation-mcp-duplicate.json`; reproducción: `repro/refute_mcp_duplicate.py`.

Impacto confirmado: respuesta MCP de lectura incorrecta y pérdida del objeto singular pese a una selección única. Duplicados pueden consumir el límite de la lista; no se atribuye a esta evidencia un cobro duplicado ni una fuga entre propietarios. Corrección propuesta: aplicar el join correcto antes del predicado y paginación. Verificación: propiedad metamórfica con varios clientes y zonas, UUID explícito y múltiples batches; agregar o cambiar un cliente no relacionado no debe alterar IDs, minutos ni truncamiento de la consulta del cliente seleccionado.

## Límites

Esta revisión es estática y de reproducciones retenidas, con una repetición fresca del baseline del entrypoint. No se inspeccionaron secretos, roles cloud efectivos, payloads privados de recuperación ni datos personales. Consenso entre agentes no sustituye los recibos reproducibles.
