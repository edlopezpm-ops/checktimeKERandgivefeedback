import json
import os
import sys
import subprocess
import ipaddress
from pathlib import Path
from datetime import datetime, timedelta, timezone
ROOT=Path(__file__).resolve().parents[1]
PRODUCT=ROOT/'sandbox'/'product'
sys.path.insert(0,str(PRODUCT))
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.fernet import Fernet
import psycopg
from alembic.config import Config
from alembic import command
from sqlalchemy import text
from fastapi.testclient import TestClient
from app.config import Settings
from app.main import create_app

PG=Path(r'<POSTGRES_BIN>')
DATA=ROOT/'sandbox'/'behavior-pg-ssl'
PORT=55527
ADMIN='behavior_audit_admin'
DATABASE='behavior_hosted_test'
assert DATABASE.endswith('_test') and DATA.parent==ROOT/'sandbox'
if not (DATA/'PG_VERSION').exists():
    result=subprocess.run([str(PG/'initdb.exe'),'-D',str(DATA),'-A','trust','-U',ADMIN,'--locale=C','--encoding=UTF8'],capture_output=True,text=True)
    if result.returncode: raise RuntimeError('initdb failed')
key=rsa.generate_private_key(public_exponent=65537,key_size=2048)
name=x509.Name([x509.NameAttribute(NameOID.COMMON_NAME,'localhost')])
cert=(x509.CertificateBuilder().subject_name(name).issuer_name(name).public_key(key.public_key()).serial_number(x509.random_serial_number()).not_valid_before(datetime.now(timezone.utc)-timedelta(minutes=1)).not_valid_after(datetime.now(timezone.utc)+timedelta(days=1)).add_extension(x509.SubjectAlternativeName([x509.DNSName('localhost'),x509.IPAddress(ipaddress.ip_address('127.0.0.1'))]),critical=False).add_extension(x509.BasicConstraints(ca=True,path_length=None),critical=True).sign(key,hashes.SHA256()))
(DATA/'server.key').write_bytes(key.private_bytes(serialization.Encoding.PEM,serialization.PrivateFormat.TraditionalOpenSSL,serialization.NoEncryption()))
(DATA/'server.crt').write_bytes(cert.public_bytes(serialization.Encoding.PEM))
with (DATA/'postgresql.conf').open('a',encoding='utf-8') as f:f.write("\nlisten_addresses='127.0.0.1'\nport=55527\nssl=on\nssl_cert_file='server.crt'\nssl_key_file='server.key'\n")
started=False
try:
    with (ROOT/'evidence'/'behavior-pg-start.log').open('w',encoding='utf-8') as pglog:
        result=subprocess.run([str(PG/'pg_ctl.exe'),'-D',str(DATA),'-l',str(DATA/'server.log'),'-w','start'],stdout=pglog,stderr=subprocess.STDOUT)
    if result.returncode:raise RuntimeError('pg_ctl start failed; see behavior-pg-start.log')
    started=True
    with psycopg.connect(host='127.0.0.1',port=PORT,dbname='postgres',user=ADMIN,autocommit=True) as c:
        if not c.execute('SELECT 1 FROM pg_database WHERE datname=%s',(DATABASE,)).fetchone():c.execute('CREATE DATABASE behavior_hosted_test')
    with psycopg.connect(host='127.0.0.1',port=PORT,dbname=DATABASE,user=ADMIN,autocommit=True) as c:
        c.execute('CREATE SCHEMA IF NOT EXISTS timeker')
        c.execute('ALTER ROLE behavior_audit_admin IN DATABASE behavior_hosted_test SET search_path=timeker,pg_catalog')
    tls='?sslmode=verify-full&sslrootcert='+str(DATA/'server.crt').replace('\\','/')
    url=f'postgresql+psycopg://{ADMIN}@127.0.0.1:{PORT}/{DATABASE}'+tls
    os.environ['TIMEKER_DATABASE_URL']=url
    os.environ['TIMEKER_ENVIRONMENT']='test'
    command.upgrade(Config(str(PRODUCT/'alembic.ini')),'head')
    settings=Settings(environment='staging',database_url=url,database_role=ADMIN,database_schema='timeker',base_url='https://audit.example.invalid',trusted_hosts=('audit.example.invalid',),allowlist=('new-audit@example.invalid',),session_secret='synthetic-audit-signing-secret-7351'*2,encryption_key=Fernet.generate_key().decode(),google_client_id='synthetic-audit-client',google_client_secret='synthetic-audit-provider-key',turnstile_site_key='synthetic-audit-site-key',turnstile_secret_key='synthetic-audit-bot-key')
    app=create_app(settings)
    with app.state.tenants.default.factory() as db:
        row=db.execute(text("SELECT rolsuper,rolcreatedb,rolcreaterole,rolbypassrls FROM pg_roles WHERE rolname=current_user")).one()
        owns=db.scalar(text("SELECT current_user::regrole::oid=relowner FROM pg_class WHERE oid='clients'::regclass"))
        ssl=db.scalar(text('SELECT ssl FROM pg_stat_ssl WHERE pid=pg_backend_pid()'))
    with TestClient(app,base_url=settings.base_url) as web:
        response=web.get('/health/ready')
    result={'configuration':'Valid staging Settings; one configured workspace; onboarding disabled; synthetic Google/Turnstile names never sent; PostgreSQL local TLS verify-full','database':DATABASE,'port':PORT,'ssl_verified_connection':ssl,'runtime_privileges':{'superuser':row[0],'createdb':row[1],'createrole':row[2],'bypassrls':row[3],'clients_owner':owns},'application_startup':'ACCEPTED','health_ready_status':response.status_code,'health_ready_body':response.json(),'expected':'Runtime readiness must reject admin/table-owner role under HOSTING.md:247-252 and deploy/postgres/README.md:52-55,58-79.','live_state':'No hosted or production target contacted; actual Stage role configuration not evaluated.'}
    (ROOT/'evidence'/'behavior-hosted-singleton-readiness.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(result))
finally:
    if started:
        stop=subprocess.run([str(PG/'pg_ctl.exe'),'-D',str(DATA),'-m','fast','-w','stop'],capture_output=True,text=True)
        if stop.returncode:raise RuntimeError('Own audit cluster failed stop')
        print('Own SSL audit PostgreSQL stopped.')

