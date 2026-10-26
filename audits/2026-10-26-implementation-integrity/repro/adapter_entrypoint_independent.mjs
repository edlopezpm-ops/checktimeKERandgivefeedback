// Independent exported-handler oracle. Container boundary is stubbed; no hosted service is called.
import assert from 'node:assert/strict';
import {pathToFileURL} from 'node:url';
import {randomUUID} from 'node:crypto';

const handler = (await import(pathToFileURL(process.argv[2]).href)).default;
const nonce = randomUUID();
const calls = [];
globalThis.__auditUpstream = async (namespace, id, request) => {
  calls.push({namespace, id, request});
  return new Response(nonce, {status: 201});
};
const env = {
  TIMEKER_ENVIRONMENT: 'staging', TIMEKER_DEV_LOGIN: 'false', TIMEKER_OPTIONAL_USAGE_ENABLED: 'false',
  TIMEKER_BASE_URL: 'https://stage-timeker.aekr.io', TIMEKER_TRUSTED_HOSTS: 'stage-timeker.aekr.io,127.0.0.1',
  TIMEKER_INVOICE_PREFIX: 'AUDIT', TIMEKER_DATABASE_ROLE: 'timeker_app', TIMEKER_DATABASE_SCHEMA: 'timeker',
  TIMEKER_DATABASE_URL: 'postgresql+psycopg://timeker_app.ityphppmbomkmergwtze:synthetic@aws-0-us-east-2.pooler.supabase.com:5432/postgres?sslmode=verify-full&sslrootcert=/app/certs/supabase-ca.crt',
  TIMEKER_SESSION_SECRET: 'independent-synthetic-signing-material-never-deployed',
  TIMEKER_ENCRYPTION_KEY: 'synthetic-never-used-for-encryption',
  TIMEKER_GOOGLE_CLIENT_ID: 'synthetic-client', TIMEKER_GOOGLE_CLIENT_SECRET: 'synthetic-secret',
  TIMEKER_TURNSTILE_SITE_KEY: 'synthetic-site', TIMEKER_TURNSTILE_SECRET_KEY: 'synthetic-secret',
  TIMEKER_ALLOWLIST: 'audit@example.invalid', TIMEKER_CONTACT_DELIVERY: 'disabled',
  TIMEKER_INTERNAL_SECRET: 'independent-synthetic-internal-material-never-deployed',
  TIMEKER_MAIL_CAPTURE_ENABLED: 'false', TIMEKER_MAIL_DOMAIN: '', TIMEKER_MAIL_ADDRESS_DOMAIN: '',
  TIMEKER_TENANT_REGISTRY_JSON: '{"version":1,"tenants":[]}',
  TIMEKER_INTEGRATION_ENABLED: 'true', TIMEKER_INTEGRATION_CLIENTS_JSON: '[]',
  TIMEKER_PH2_STAGE_CONTAINER: {auditBinding: nonce},
};
const response = await handler.fetch(new Request('https://stage-timeker.aekr.io/health/live'), env);
assert.equal(response.status, 201, 'actual export must preserve container outcome');
assert.equal(await response.text(), nonce, 'actual export must preserve unpredictable container body');
assert.equal(calls.length, 1, 'actual export must invoke container exactly once');
assert.equal(calls[0].namespace, env.TIMEKER_PH2_STAGE_CONTAINER);
assert.equal(calls[0].id, 'timeker-ph2-stage-v1');
assert.equal(calls[0].request.url, 'https://stage-timeker.aekr.io/health/live');
for (const [url, changes, status] of [
  ['https://stage-timeker.aekr.io/internal/archive', {}, 404],
  ['https://foreign.example.invalid/health/live', {}, 421],
  ['https://stage-timeker.aekr.io/health/live', {TIMEKER_SESSION_SECRET:''}, 503],
]) {
  assert.equal((await handler.fetch(new Request(url), {...env, ...changes})).status, status);
  assert.equal(calls.length, 1, 'rejected requests must not dispatch');
}
globalThis.__auditUpstream = async () => {throw new Error('synthetic controlled failure');};
const failed = await handler.fetch(new Request('https://stage-timeker.aekr.io/health/live'), env);
assert.equal(failed.status, 503, 'container failure must never report success');
assert.equal(await failed.text(), 'Service unavailable.');
console.log(JSON.stringify({checks: 5, result:'PASS', boundary:'exported Stage handler -> proxy -> stubbed container, no provider proof'}));
