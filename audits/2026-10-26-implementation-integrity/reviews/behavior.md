# Revisión independiente de comportamiento — timeKER

Snapshot `1036d705f7f3721e2fa83df67cf913a40dad65b8`. Pasada separada con contexto heredado; no equivale a auditor sin contexto. Producto original intacto.

## Resultado

Cuatro incumplimientos funcionales CONFIRMED: tres de severidad media y uno de severidad baja; no se observó simulación intencional ni manipulación del evaluador en las rutas asignadas. La atribución de intención/autoría permanece indeterminada. Las integraciones remotas reales no se acreditan con estos sandboxes.

### B01 — Readiness acepta autoridad runtime prohibida

`app/tenancy.py:425-443` omite todos los controles de propiedad/atributos elevados cuando existe un solo descriptor; con varios, la consulta no comprueba `rolreplication`. HOSTING.md:247–252 y deploy/postgres/README.md:52–61,77–79 exigen separación runtime/migrator/admin y anuncian que readiness comprueba propiedad/privilegios.

La reproducción r2 empleó Settings **staging válidos**, esquema timeker, certificado TLS local verificado (`sslmode=verify-full`), una sola workspace y configuración sintética de proveedores que nunca se contactaron. El proceso inició y GET `/health/ready` devolvió200 `ready` con rol superusuario, CREATEDB, CREATEROLE, BYPASSRLS y propietario de clients. Esto refuta la alternativa legítima de que el bypass solo permita tests/desarrollo. Otra reproducción creó dos esquemas/roles no propietarios, activó únicamente REPLICATION en uno y observó readiness aceptado; se restauró el atributo antes de eliminar las fixtures.

El hallazgo demuestra una validación de configuración incompleta. **No demuestra que Stage o PROD estén actualmente mal configurados**, ni acceso remoto no autorizado. Corrección propuesta: comprobar propiedad/atributos siempre en hosted, incluyendo REPLICATION; reservar condiciones de cardinalidad para las comprobaciones que realmente requieren otra workspace. Verificar rechazo singleton admin/owner y multitenant replication y aceptación normal de roles mínimos.

Evidencia: `evidence/behavior-hosted-singleton-readiness.json`, `behavior-hosted-singleton-readiness-r2.log`, `behavior-replication-readiness.json` y recibos; scripts correspondientes bajo repro/.

### B02 — Lectura MCP duplica lotes por clientes ajenos

En `app/integration_routes.py:406-417`, `active_card_predicate()` usa Client.timezone y la consulta de Timecard no enlaza Client. PostgreSQL genera un producto cartesiano. El contrato público declara lectura de entradas reales de un cliente/semana y la guía exige usar las identidades de lote devueltas.

La reproducción atravesó autenticación local explícita de propietario sintético, consentimiento OAuth, código/PKCE, token y `/mcp tools/call`. Creó37minutos, leyó su timecard exacta y agregó un segundo cliente Draft ajeno. Una nueva conexión SQL confirmó una única timecard; la segunda lectura devolvió el mismo UUID dos veces y cambió `timecard` singular de objeto a null. Las entradas siguieron37minutos. Múltiples lotes legítimos no explican IDs idénticos ni el conteo SQL.

Corregir el JOIN de la tarjeta a su propio Client antes del filtro de archivo/zona y del LIMIT. Deduplicar después del límite no resuelve la pérdida temprana de lotes. Añadir propiedad metamórfica cliente ajeno/zonas y casos del límite101. Evidencia: `evidence/behavior-mcp-cartesian.json`, `behavior-mcp-cartesian-r2.log`, recibo y `repro/behavior_mcp_cartesian.py`.

## Evidencia positiva y límites

317 assertions independientes (no317 nodos pytest) comprobaron100 credenciales inéditas, tipo/truncación, cierre por configuración de proveedores deshabilitados, cambios de frecuencia bloqueados y clasificación conservadora de errores/ambigüedad/respuestas de correo. `evidence/behavior-independent.json` conserva el detalle y oráculo. El resto de pruebas de integración del proyecto pertenece a la ejecución central.

La inspección conectó consentimiento/PKCE/refresh/revocación con grants/tokens persistidos; preparación financiera con revisión nativa; Sending con outbox e incertidumbre antes del efecto; webhook con HMAC y lectura enlazada del proveedor; cierre con restricción/revocación/retención sin purge inventado. Ninguna observación estática acredita éxito de proveedores reales. El inventario exacto de archivos leídos completos y rangos muestreados está en `behavior.json`; se evita declarar revisión semántica de archivos truncados.

No se confirmó la sospecha inicial de export incompleto: el allowlist actual incluye los registros PH3 de negocio y excluye legítimamente material de autenticación/directorio. Tampoco es decoy que MCP terminal devuelva REVIEW_REQUIRED: el contrato aceptado requiere una confirmación nativa y la ruta efectiva está conectada.

Refutación solicitada del hallazgo monetario central: D002 prescribe HALF_UP por línea agrupada. Una línea de2minutos aUSD1.65 equivale exactamente aUSD0.055 y debe dar0.06; la política por grupo no justifica0.05. El oráculo entero de centavos es válido para el dominio no negativo.

Se conservaron fallos de setup y advertencias de dependencias; no se atribuyeron al producto. El cluster TLS propio55527 está detenido; roles/esquemas de la prueba REPLICATION se limpiaron. Los dos DB locales de reproducción quedan retenidos en el cluster55526 que administra el agente principal. No se modificó código, configuración o documentos del producto.


## Ampliación solicitada: privacidad, contacto, preferencias y recuperación

La revisión estática completa de privacy/usage/bot_check/settings/contact y session_recovery/settings_cache/usage JS se agregó al ledger. No se encontró un fallo confirmado adicional en contacto, caché o recuperación. El honeypot de Contact intencionalmente suprime correo; su contexto de abuso justifica el éxito aparente. Preview está prohibido en hosted. La recuperación de sesión conserva el DOM sin enviar, verifica propietario/tenant y actualiza CSRF antes del envío nativo. El refresco de archivos espera respuestas/cuerpos y reporta errores sin afirmar éxito parcial.

### B03 — Collector opcional desconectado del visitante anónimo

CONFIRMED, severidad baja, DISCONNECTED_IMPLEMENTATION con WEAK_TEST relacionado. `PUBLIC_PATHS` en tenancy no incluye `/privacy/usage`. El collector y usage.js sí contemplan home sin un requisito nuevo de autenticación. El contrato aceptado `docs/optional-usage-implementation.md:3-9,47-52,64-73` autoriza la implementación pública mientras conserva el flag OFF y separa activación.

Una prueba con create_app real y la bandera solo en configuración local obtuvo consentimiento firmado actual200/usage_enabled=true. El POST del visitante anónimo con Origin/Sec-Fetch-Site correctos fue303 `/`; después del login local normal del propietario sintético el mismo evento devolvió204 y emitió usage.page_view. La nueva bandera no se activó en ningún host. No se probaron proveedores. Evidencia: `behavior-usage-route.json/log/receipt.json`, `repro/behavior_usage_route.py`.

Los tests optional_usage y usage_browser_flow montan el collector sobre FastAPI sintético sin TenantMiddleware. Esta separación es legítima para aislar consentimiento pero no verifica la conexión real; no acredita manipulación deliberada. Corregir el allowlist público y agregar el recorrido create_app anónimo con aceptación/rechazo/señales/flag deshabilitado. No relajar consentimiento ni activar hosting para resolverlo.



## Observación pública Stage — 26 de octubre,20:31 UTC

GET público `/health/live`200/ok, `/health/ready`200/ready y `/sign-in`200 con etiqueta Google. Wordmark coincide por SHA256 exacto. timecards.js coincide tras normalizar LF/CRLF. app.js y app.css difieren del snapshot evaluado y de sus blobs Git HEAD, incluso tras normalizar saltos; dos lecturas conservaron los mismos hashes servidos. Esto separa fuente y despliegue: **no se acredita la identidad exacta de imagen/source runtime** ni se infiere por sí solo un defecto del despliegue.

JSON/log/recibo: hosted-public-readback y hosted-asset-canonicalization en evidence/. Solo GETs públicos Stage; ningún login, token/cookie reutilizado, acción de identidad/proveedor, escritura remota, despliegue o acceso PROD. La vista web no accedió a los dos endpoints; las observaciones HTTP directas anteriores están registradas separadamente.


## B04 — Los reintentos de fallo de renovación alteran la gracia en DST

CONFIRMED, severidad media, CONTRACT_FAILURE. D060 (`docs/DECISIONS.md:649–650`) fija7días vinculados al primer fallo verificado y prohíbe que los reintentos los extiendan. La norma de timestamps técnicos es UTC. `app/subscription_billing.py:1164–1175` aplica timedelta a `past_due_since` recargado con ZoneInfo de la sesión PostgreSQL. Al comparar instantes iguales, min conserva el primer argumento ya recargado; la suma posterior utiliza días de reloj local.

Reproducción independiente con datos/payloads propios y nueva DB local, sin reutilizar el oráculo del test original. Se ejecutó la ruta handle_verified_event y su adaptación real de respuestas de GETs de proveedor, interceptando solamente el transporte externo. Después de cada commit se consultó mediante una sesión nueva. No se simula evidencia de HMAC público ni de un proveedor real.

- Fallo fijo2026-10-25T09:17:23Z, sesión America/New_York: primer evento604800segundos; segundo/tercero608400.
- Mismo instante, sesión UTC:604800/604800/604800.
- Control sin cambio DST, NY15noviembre:604800/604800/604800.
- Control primavera, NY1marzo2026:604800/601200/601200.

El instante UTC del primer fallo permanece igual. Incluso si se discutiera el significado de7días calendario, un mismo ancla no puede producir expiraciones distintas en los reintentos. Los controles UTC/sin transición refutan un error general del fixture o comparador. No se conoce la zona de sesión real Stage y no se afirma exposición actual: una sesión externamente fijada a UTC evita esta condición, pero el factory de la aplicación no la exige.

Evidencia/repro: `evidence/behavior-grace-dst.json/log/receipt.json` y `repro/behavior_grace_dst.py`.24GETs de proveedor interceptados, cero writes. Zona elegida en cada conexión propia; no se modificó la configuración del cluster. Normalizar UTC antes de sumar y comprobar reintentos en ambas transiciones con sesiones nuevas. Producto original intacto.


## Refutación cruzada — búsqueda nativa de Billing

La revisión independiente de fuentes no encontró una excepción legítima que invalide el hallazgo del revisor de evaluación. DESIGN_SPEC337 conserva el fallback nativo de selectores. billing.html4 envía GET/billing/work; botones _lookup de lookup.html17–19 usan el mismo formulario con formnovalidate. main1539 exige UUID/fechas antes del handler y no despacha _lookup. Selección vacía produce400 y selección presente conduce a Choose billable work, no al buscador. La modificación PH3 de la acción de negocio no elimina este contrato compartido. Se revisaron evidencia/inputs y control positivo del revisor; no se atribuye aquí una segunda ejecución runtime. Los dos templates se agregaron al ledger completo.
