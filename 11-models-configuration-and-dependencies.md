# Models, configuration, migrations and dependencies

Snapshot: 2026-10-18. Source commit `4bb5c424d6e7d270cdca1479283896be77d581c3` on `main`.
Generated offline from tracked source only. No app import, product-test execution, database query, provider/identity action or deployment. Static counts do not describe executed tests or live routing/database state.

## 54 mapped class/table declarations

Fields below are directly declared annotated attributes, including relationships; common Base/mixin fields are inherited separately. This is not a database reflection or proof of deployed grants/indexes. No row values or secrets are included.

### `workspace_admissions` — `WorkspaceAdmission`

[`app/admission_models.py:12`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L12); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `slot_id` | `Mapped[UUID]` | `mapped_column(unique=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(unique=True)` |
| `email` | `Mapped[str]` | `mapped_column(String(254), unique=True)` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='reserved')` |

### `admission_identities` — `AdmissionIdentity`

[`app/admission_models.py:26`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L26); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `tenant_id` | `Mapped[UUID]` | `mapped_column()` |
| `owner_id` | `Mapped[UUID]` | `mapped_column()` |
| `identity_id` | `Mapped[UUID]` | `mapped_column()` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `verified_email` | `Mapped[str]` | `mapped_column(String(254))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='pending')` |

### `public_email_challenges` — `PublicEmailChallenge`

[`app/admission_models.py:43`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/admission_models.py#L43); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `destination` | `Mapped[str]` | `mapped_column(Text)` |
| `address_digest` | `Mapped[str]` | `mapped_column(String(64), index=True)` |
| `session_digest` | `Mapped[str]` | `mapped_column(String(64), index=True)` |
| `network_digest` | `Mapped[str]` | `mapped_column(String(64), index=True)` |
| `intent` | `Mapped[str]` | `mapped_column(String(12))` |
| `offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `return_to` | `Mapped[str]` | `mapped_column(String(30), default='')` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='reserved')` |
| `attempts` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |

### `credit_memos` — `CreditMemo`

[`app/credit_memo_models.py:14`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/credit_memo_models.py#L14); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), unique=True)` |
| `number` | `Mapped[str]` | `mapped_column(String(60), unique=True)` |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `issue_date` | `Mapped[date]` | `mapped_column(Date)` |
| `currency` | `Mapped[str]` | `mapped_column(String(3))` |
| `total` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `reason` | `Mapped[str]` | `mapped_column(Text)` |
| `snapshot` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(40))` |

### `owner_identities` — `OwnerIdentity`

[`app/enrollment_models.py:12`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L12); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `verified_email` | `Mapped[str]` | `mapped_column(String(254))` |
| `revoked_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `owner_registrations` — `OwnerRegistration`

[`app/enrollment_models.py:26`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L26); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `terms_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `privacy_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `catalog_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `accepted_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |

### `email_auth_challenges` — `EmailAuthChallenge`

[`app/enrollment_models.py:42`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/enrollment_models.py#L42); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `session_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `intent` | `Mapped[str]` | `mapped_column(String(12))` |
| `offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `attempts` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |

### `integration_grants` — `IntegrationGrant`

[`app/integration_models.py:21`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L21); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `tenant_id` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `client_id` | `Mapped[str]` | `mapped_column(String(120))` |
| `label` | `Mapped[str]` | `mapped_column(String(120))` |
| `scopes` | `Mapped[list]` | `mapped_column(JSONB)` |
| `resource` | `Mapped[str]` | `mapped_column(String(300))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `revoked_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `integration_codes` — `IntegrationCode`

[`app/integration_models.py:33`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L33); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `redirect_uri` | `Mapped[str]` | `mapped_column(String(1000))` |
| `code_challenge` | `Mapped[str]` | `mapped_column(String(128))` |
| `code_challenge_method` | `Mapped[str]` | `mapped_column(String(10), default='S256')` |
| `scope` | `Mapped[str]` | `mapped_column(String(500))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `used_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `integration_tokens` — `IntegrationToken`

[`app/integration_models.py:51`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L51); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `kind` | `Mapped[str]` | `mapped_column(String(10))` |
| `scope` | `Mapped[str]` | `mapped_column(String(500))` |
| `client_id` | `Mapped[str]` | `mapped_column(String(120))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `used_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `integration_operations` — `IntegrationOperation`

[`app/integration_models.py:69`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L69); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `tool` | `Mapped[str]` | `mapped_column(String(60))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |

### `client_drafts` — `ClientDraft`

[`app/integration_models.py:79`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/integration_models.py#L79); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `payload` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `library_documents` — `LibraryDocument`

[`app/library_models.py:26`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L26); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `object_id` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `title` | `Mapped[str]` | `mapped_column(String(180))` |
| `kind` | `Mapped[str]` | `mapped_column(String(16))` |
| `status` | `Mapped[str]` | `mapped_column(String(12), default='draft')` |
| `content` | `Mapped[str]` | `mapped_column(Text, default='')` |
| `is_template` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `case_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `client_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `source_template` | `Mapped[str &#124; None]` | `mapped_column(String(40))` |
| `source_upload_id` | `Mapped[UUID &#124; None]` | `mapped_column(Uuid)` |
| `revision` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `library_uploads` — `LibraryUpload`

[`app/library_models.py:52`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L52); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `document_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('library_documents.id'), index=True)` |
| `uploaded_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `content_type` | `Mapped[str]` | `mapped_column(String(128))` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |

### `library_document_versions` — `LibraryDocumentVersion`

[`app/library_models.py:68`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/library_models.py#L68); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `document_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('library_documents.id'), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `snapshot` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `source_upload_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('library_uploads.id'))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
| `pdf_size` | `Mapped[int]` | `mapped_column(Integer)` |
| `pdf_sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(80))` |
| `published_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |

### `mail_messages` — `MailMessage`

[`app/mail_models.py:22`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L22); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `case_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `message_id` | `Mapped[str &#124; None]` | `mapped_column(String(998))` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `subject` | `Mapped[str]` | `mapped_column(String(998))` |
| `sender` | `Mapped[str]` | `mapped_column(String(2000))` |
| `recipients` | `Mapped[str]` | `mapped_column(String(4000))` |
| `body` | `Mapped[str]` | `mapped_column(Text)` |
| `message_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `received_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `archived_basis_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `archive_basis_source` | `Mapped[str]` | `mapped_column(String(20))` |
| `archived_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `source` | `Mapped[str]` | `mapped_column(String(10))` |
| `attachment_count` | `Mapped[int]` | `mapped_column(Integer)` |

### `mail_addresses` — `MailAddress`

[`app/mail_models.py:49`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L49); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `case_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `token_digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `revoked_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `mail_attachments` — `MailAttachment`

[`app/mail_models.py:64`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/mail_models.py#L64); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `message_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('mail_messages.id'), index=True)` |
| `position` | `Mapped[int]` | `mapped_column(Integer)` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `declared_content_type` | `Mapped[str]` | `mapped_column(String(128), default='application/octet-stream')` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |

### `contact_attempts` — `ContactAttempt`

[`app/models.py:33`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L33); bases: `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `id` | `Mapped[UUID]` | `mapped_column(Uuid, primary_key=True)` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `session_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `address_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `network_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `status` | `Mapped[str]` | `mapped_column(String(12))` |

### `users` — `User`

[`app/models.py:59`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L59); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `email` | `Mapped[str]` | `mapped_column(String(254), unique=True)` |
| `display_name` | `Mapped[str]` | `mapped_column(String(100))` |
| `role` | `Mapped[str]` | `mapped_column(String(20), default='owner')` |
| `active` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `last_login_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `session_revision` | `Mapped[int]` | `mapped_column(Integer, default=0)` |

### `clients` — `Client`

[`app/models.py:69`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L69); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `object_id` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `code` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `legal_name` | `Mapped[str]` | `mapped_column(String(200))` |
| `display_name` | `Mapped[str]` | `mapped_column(String(120), index=True)` |
| `country_code` | `Mapped[str]` | `mapped_column(String(2))` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='draft', server_default='draft', index=True)` |
| `timezone` | `Mapped[str]` | `mapped_column(String(80), default='UTC')` |
| `language` | `Mapped[str]` | `mapped_column(String(2), default='en')` |
| `currency` | `Mapped[str]` | `mapped_column(String(3), default='USD')` |
| `rate` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `weekly_limit_minutes` | `Mapped[int &#124; None]` | `mapped_column(Integer)` |
| `payment_terms_days` | `Mapped[int]` | `mapped_column(Integer, default=15)` |
| `profile` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `contract` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `archived_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `contacts` — `Contact`

[`app/models.py:99`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L99); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `name` | `Mapped[str]` | `mapped_column(String(100))` |
| `title` | `Mapped[str &#124; None]` | `mapped_column(String(100))` |
| `email` | `Mapped[str &#124; None]` | `mapped_column(String(254))` |
| `phone` | `Mapped[str &#124; None]` | `mapped_column(String(50))` |
| `contact_type` | `Mapped[str]` | `mapped_column(String(40), default='general')` |
| `may_request_work` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `may_approve_hours` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `active` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |

### `projects` — `Project`

[`app/models.py:112`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L112); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `object_id` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `code` | `Mapped[str]` | `mapped_column(String(30))` |
| `name` | `Mapped[str]` | `mapped_column(String(150))` |
| `description` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='draft')` |
| `billable` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `rate_override` | `Mapped[Decimal &#124; None]` | `mapped_column(Numeric(14, 2))` |
| `project_type` | `Mapped[str &#124; None]` | `mapped_column(String(40))` |
| `budget_amount` | `Mapped[Decimal &#124; None]` | `mapped_column(Numeric(14, 2))` |
| `budget_currency` | `Mapped[str &#124; None]` | `mapped_column(String(3))` |
| `agreement_type` | `Mapped[str &#124; None]` | `mapped_column(String(10))` |
| `agreement_reference` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `allow_overbilling` | `Mapped[bool]` | `mapped_column(Boolean, default=False, server_default='false')` |

### `client_source_references` — `ClientSourceReference`

[`app/models.py:153`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L153); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), unique=True)` |
| `uploaded_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `media_type` | `Mapped[str]` | `mapped_column(String(80))` |
| `content` | `Mapped[bytes &#124; None]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
| `url` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `sha256` | `Mapped[str &#124; None]` | `mapped_column(String(64))` |

### `project_agreements` — `ProjectAgreement`

[`app/models.py:169`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L169); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), unique=True)` |
| `uploaded_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |

### `timecards` — `Timecard`

[`app/models.py:184`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L184); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `object_id` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `is_internal` | `Mapped[bool]` | `mapped_column(Boolean, default=False, server_default='false')` |
| `internal_case_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('cases.id'))` |
| `archived_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `client_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `week_start` | `Mapped[date]` | `mapped_column(Date, index=True)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Draft', index=True)` |
| `total_minutes` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `finalized_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `cap_override_reason` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `cap_override_reference` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `entries` | `Mapped[list['TimeEntry']]` | `relationship(cascade='all, delete-orphan', order_by='TimeEntry.work_date')` |

### `time_entries` — `TimeEntry`

[`app/models.py:215`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L215); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `timecard_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('timecards.id'), index=True)` |
| `project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'))` |
| `work_date` | `Mapped[date]` | `mapped_column(Date, index=True)` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `category` | `Mapped[str]` | `mapped_column(String(40), default='consulting')` |
| `description` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `billable` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `rate_override` | `Mapped[Decimal &#124; None]` | `mapped_column(Numeric(14, 2))` |

### `cases` — `Case`

[`app/models.py:233`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L233); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True, start=10001), unique=True)` |
| `object_id` | `Mapped[int]` | `synonym('number')` |
| `legacy_number` | `Mapped[str &#124; None]` | `mapped_column(String(30))` |
| `case_type` | `Mapped[str]` | `mapped_column(String(20))` |
| `title` | `Mapped[str]` | `mapped_column(String(200))` |
| `description` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Open', index=True)` |
| `opened_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `resolved_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `closed_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `archived_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `case_time_allocations` — `CaseTimeAllocation`

[`app/models.py:266`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L266); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `entry_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('time_entries.id'), index=True)` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `invoices` — `Invoice`

[`app/models.py:280`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L280); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `object_id` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `fixed_fee_project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'))` |
| `manual_extra_project_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('projects.id'))` |
| `manual_extra_reference` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `number` | `Mapped[str]` | `mapped_column(String(60), unique=True)` |
| `period_start` | `Mapped[date]` | `mapped_column(Date)` |
| `period_end` | `Mapped[date]` | `mapped_column(Date)` |
| `issue_date` | `Mapped[date &#124; None]` | `mapped_column(Date)` |
| `delivered_at` | `Mapped[date &#124; None]` | `mapped_column(Date)` |
| `due_date` | `Mapped[date &#124; None]` | `mapped_column(Date, index=True)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Draft', index=True)` |
| `currency` | `Mapped[str]` | `mapped_column(String(3))` |
| `subtotal` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `adjustments` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `total` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `snapshot` | `Mapped[dict &#124; None]` | `mapped_column(JSONB)` |
| `issued_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `voided_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `void_reason` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `lines` | `Mapped[list['InvoiceLine']]` | `relationship(cascade='all, delete-orphan', order_by='InvoiceLine.sort_order')` |

### `invoice_lines` — `InvoiceLine`

[`app/models.py:341`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L341); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'))` |
| `description` | `Mapped[str]` | `mapped_column(String(200))` |
| `service_period` | `Mapped[str]` | `mapped_column(String(40))` |
| `quantity_minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `unit_rate` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `amount` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `basis` | `Mapped[str]` | `mapped_column(String(20), default='time', server_default='time')` |
| `charge_metadata` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default=text("'{}'::jsonb"))` |
| `sort_order` | `Mapped[int]` | `mapped_column(Integer)` |

### `invoice_time_entries` — `Reservation`

[`app/models.py:365`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L365); bases: `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `entry_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('time_entries.id'), primary_key=True)` |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), index=True)` |

### `invoice_artifacts` — `Artifact`

[`app/models.py:371`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L371); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), unique=True)` |
| `filename` | `Mapped[str]` | `mapped_column(String(150))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(40))` |

### `payments` — `Payment`

[`app/models.py:380`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L380); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), index=True)` |
| `paid_at` | `Mapped[date]` | `mapped_column(Date)` |
| `amount` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `currency` | `Mapped[str]` | `mapped_column(String(3))` |
| `method` | `Mapped[str]` | `mapped_column(String(40))` |
| `reference` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `note` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `created_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `reversed_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `audit_events` — `Audit`

[`app/models.py:394`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L394); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('users.id'))` |
| `request_id` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `event_type` | `Mapped[str]` | `mapped_column(String(60))` |
| `entity_type` | `Mapped[str]` | `mapped_column(String(30))` |
| `entity_id` | `Mapped[UUID]` | `mapped_column(Uuid, index=True)` |
| `details` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |

### `app_settings` — `AppSettings`

[`app/models.py:404`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/models.py#L404); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `key` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `value` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `encrypted_value` | `Mapped[bytes &#124; None]` | `mapped_column(LargeBinary)` |

### `proposal_sending_deliveries` — `ProposalSendingDelivery`

[`app/proposal_sending_models.py:22`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L22); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `quote_artifact_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('quote_artifacts.id'))` |
| `library_version_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('library_document_versions.id'))` |
| `artifact_revision_id` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `revision_number` | `Mapped[int]` | `mapped_column(Integer)` |
| `document_kind` | `Mapped[str]` | `mapped_column(String(12))` |
| `attachment_filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `attachment_content_type` | `Mapped[str]` | `mapped_column(String(100))` |
| `attachment_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True)` |
| `attachment_sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `recipient` | `Mapped[str]` | `mapped_column(String(254))` |
| `subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `body` | `Mapped[str]` | `mapped_column(Text)` |
| `operation_key` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='draft', index=True)` |
| `attempt_count` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `last_code` | `Mapped[str &#124; None]` | `mapped_column(String(40))` |
| `confirmed_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `sent_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `stopped_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `proposal_sending_attempts` — `ProposalSendingAttempt`

[`app/proposal_sending_models.py:58`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/proposal_sending_models.py#L58); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `delivery_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('proposal_sending_deliveries.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `code` | `Mapped[str]` | `mapped_column(String(40))` |
| `completed_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `quotes` — `Quote`

[`app/quoting_models.py:30`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L30); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `object_id` | `Mapped[int]` | `synonym('number')` |
| `operation_key` | `Mapped[UUID]` | `mapped_column(Uuid, default=uuid4)` |
| `create_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `archived_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `quote_revisions` — `QuoteRevision`

[`app/quoting_models.py:46`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L46); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `flexfields` | `Mapped[dict]` | `mapped_column(JSONB, default=dict, server_default='{}')` |
| `quote_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('quotes.id'), index=True)` |
| `parent_revision_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('quote_revisions.id'))` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `status` | `Mapped[str]` | `mapped_column(String(12), default='draft')` |
| `title` | `Mapped[str]` | `mapped_column(String(200))` |
| `prepared_for` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `preset` | `Mapped[str]` | `mapped_column(String(30), default='quick_effort')` |
| `currency` | `Mapped[str &#124; None]` | `mapped_column(String(3))` |
| `assumptions` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `exclusions` | `Mapped[str &#124; None]` | `mapped_column(Text)` |
| `valid_until` | `Mapped[date &#124; None]` | `mapped_column(Date)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `quote_lines` — `QuoteLine`

[`app/quoting_models.py:79`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L79); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `revision_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('quote_revisions.id'), index=True)` |
| `position` | `Mapped[int]` | `mapped_column(Integer)` |
| `label` | `Mapped[str]` | `mapped_column(String(500))` |
| `scope_type` | `Mapped[str]` | `mapped_column(String(12), default='task')` |
| `min_minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `max_minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `pricing_model` | `Mapped[str &#124; None]` | `mapped_column(String(30))` |
| `unit_rate` | `Mapped[Decimal &#124; None]` | `mapped_column(Numeric(14, 2))` |
| `fixed_amount` | `Mapped[Decimal &#124; None]` | `mapped_column(Numeric(14, 2))` |

### `quote_artifacts` — `QuoteArtifact`

[`app/quoting_models.py:105`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/quoting_models.py#L105); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `revision_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('quote_revisions.id'), unique=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `snapshot` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(80))` |
| `published_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |

### `sending_preferences` — `SendingPreferences`

[`app/sending_models.py:21`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L21); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), unique=True)` |
| `paused` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `initial_subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `initial_body` | `Mapped[str]` | `mapped_column(Text)` |
| `followup_subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `followup_body` | `Mapped[str]` | `mapped_column(Text)` |

### `sending_plans` — `SendingPlan`

[`app/sending_models.py:31`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L31); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), unique=True)` |
| `artifact_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoice_artifacts.id'))` |
| `artifact_sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `recipient` | `Mapped[str]` | `mapped_column(String(254))` |
| `subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `body` | `Mapped[str]` | `mapped_column(Text)` |
| `followup_subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `followup_body` | `Mapped[str]` | `mapped_column(Text)` |
| `followup_interval_days` | `Mapped[int]` | `mapped_column(Integer)` |
| `followup_max` | `Mapped[int]` | `mapped_column(Integer)` |
| `stopped_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `stop_reason` | `Mapped[str &#124; None]` | `mapped_column(String(30))` |

### `sending_deliveries` — `SendingDelivery`

[`app/sending_models.py:55`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L55); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `plan_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('sending_plans.id'), index=True)` |
| `sequence` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='pending', index=True)` |
| `scheduled_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `sent_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `failure_code` | `Mapped[str &#124; None]` | `mapped_column(String(40))` |
| `attempt_count` | `Mapped[int]` | `mapped_column(Integer, default=0)` |

### `sending_attempts` — `SendingAttempt`

[`app/sending_models.py:72`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/sending_models.py#L72); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `delivery_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('sending_deliveries.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `code` | `Mapped[str]` | `mapped_column(String(40))` |
| `provider_reference` | `Mapped[str &#124; None]` | `mapped_column(String(200))` |
| `completed_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |

### `subscription_billing_accounts` — `BillingAccount`

[`app/subscription_billing_models.py:24`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L24); bases: `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `id` | `Mapped[int]` | `mapped_column(Integer, Identity(), primary_key=True)` |
| `current` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `customer_id` | `Mapped[str]` | `mapped_column(String(30))` |
| `subscription_id` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `checkout_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('subscription_billing_operations.id'))` |
| `provider_status` | `Mapped[str]` | `mapped_column(String(12))` |
| `provider_offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `entitlement_offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `paid_through` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `proven_period_start` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `past_due_since` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `failed_period_start` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `failed_transaction_id` | `Mapped[str &#124; None]` | `mapped_column(String(30))` |
| `provider_updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `pending_offer` | `Mapped[str &#124; None]` | `mapped_column(String(20))` |
| `pending_effective_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `pending_selection` | `Mapped[dict &#124; None]` | `mapped_column(JSONB)` |
| `requires_selection` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC), onupdate=lambda: datetime.now(UTC))` |

### `subscription_billing_operations` — `BillingOperation`

[`app/subscription_billing_models.py:71`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L71); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `action` | `Mapped[str]` | `mapped_column(String(30))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='reserved')` |
| `intent` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `transaction_id` | `Mapped[str &#124; None]` | `mapped_column(String(30), unique=True)` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |

### `subscription_billing_events` — `BillingEvent`

[`app/subscription_billing_models.py:89`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_billing_models.py#L89); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `provider_event_id` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `raw_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `event_type` | `Mapped[str]` | `mapped_column(String(80))` |
| `outcome` | `Mapped[str]` | `mapped_column(String(24))` |
| `facts` | `Mapped[dict]` | `mapped_column(JSONB)` |

### `workspace_subscriptions` — `WorkspaceSubscription`

[`app/subscription_models.py:13`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L13); bases: `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `id` | `Mapped[int]` | `mapped_column(Integer, primary_key=True, default=1, autoincrement=False)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `plan_code` | `Mapped[str]` | `mapped_column(String(12))` |
| `catalog_revision` | `Mapped[str]` | `mapped_column(String(60))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `access_expires_at` | `Mapped[datetime &#124; None]` | `mapped_column(DateTime(timezone=True))` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC), onupdate=lambda: datetime.now(UTC))` |

### `subscription_operations` — `SubscriptionOperation`

[`app/subscription_models.py:37`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/subscription_models.py#L37); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `action` | `Mapped[str]` | `mapped_column(String(80))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |

### `time_import_records` — `TimeImportRecord`

[`app/time_command_models.py:13`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L13); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `source_record_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `batch_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `payload_hash` | `Mapped[str]` | `mapped_column(String(64))` |

### `time_contributions` — `TimeContribution`

[`app/time_command_models.py:26`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L26); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `source_item_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `import_record_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('time_import_records.id'))` |
| `timecard_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('timecards.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'))` |
| `work_date` | `Mapped[date]` | `mapped_column(Date)` |
| `entry_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('time_entries.id'), index=True)` |
| `case_id` | `Mapped[UUID &#124; None]` | `mapped_column(ForeignKey('cases.id'))` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `description` | `Mapped[str]` | `mapped_column(Text, default='')` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |

### `time_operations` — `TimeOperation`

[`app/time_command_models.py:49`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/time_command_models.py#L49); bases: `Entity`, `Base`.

| Attribute | Annotation | Persistence/relationship declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `idempotency_key` | `Mapped[str]` | `mapped_column(String(128))` |
| `payload_hash` | `Mapped[str]` | `mapped_column(String(64))` |
| `operation` | `Mapped[str]` | `mapped_column(String(20))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |

## 49 Settings fields

[`app/config.py:14`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/app/config.py#L14). Names and types are source metadata; string/provider/identity/connection values are deliberately omitted. Properties and environment loaders are behavior, not extra dataclass fields.

| Name | Type | Declared default category |
| --- | --- | --- |
| `environment` | `str` | development |
| `database_url` | `str` | Declared; value omitted |
| `database_role` | `str` | Declared; value omitted |
| `database_schema` | `str` | Empty string |
| `tenant_registry_json` | `str` | Declared; value omitted |
| `tenant_slots_json` | `str` | Declared; value omitted |
| `tenant_demo` | `bool` | False |
| `base_url` | `str` | Declared; value omitted |
| `session_secret` | `str` | Empty string |
| `encryption_key` | `str` | Empty string |
| `google_client_id` | `str` | Empty string |
| `google_client_secret` | `str` | Empty string |
| `github_client_id` | `str` | Empty string |
| `github_client_secret` | `str` | Declared; value omitted |
| `turnstile_site_key` | `str` | Empty string |
| `turnstile_secret_key` | `str` | Empty string |
| `dev_login` | `bool` | False |
| `allowlist` | `tuple[str, ...]` | Declared; value omitted |
| `trusted_hosts` | `tuple[str, ...]` | Declared; value omitted |
| `invoice_prefix` | `str` | Declared; value omitted |
| `contact_delivery` | `str` | disabled |
| `mail_domain` | `str` | Empty string |
| `mail_address_domain` | `str` | Empty string |
| `optional_usage_enabled` | `bool` | False |
| `mail_capture_enabled` | `bool` | False |
| `internal_secret` | `str` | Empty string |
| `integration_enabled` | `bool` | False |
| `integration_clients_json` | `str` | Declared; value omitted |
| `subscription_provider` | `str` | disabled |
| `paddle_live_enabled` | `bool` | False |
| `prelaunch_enabled` | `bool` | False |
| `paddle_api_key` | `str` | Declared; value omitted |
| `paddle_client_token` | `str` | Declared; value omitted |
| `paddle_webhook_secret` | `str` | Declared; value omitted |
| `paddle_price_ids_json` | `str` | Declared; value omitted |
| `paddle_retention_discount_id` | `str` | Empty string |
| `stage_onboarding_enabled` | `bool` | False |
| `onboarding_enabled` | `bool` | False |
| `public_signup_enabled` | `bool` | False |
| `email_public_signup_enabled` | `bool` | False |
| `email_auth_provider` | `str` | disabled |
| `email_auth_url` | `str` | Empty string |
| `email_auth_publishable_key` | `str` | Declared; value omitted |
| `sending_provider` | `str` | disabled |
| `sending_sender` | `str` | Declared; value omitted |
| `sending_account_id` | `str` | Empty string |
| `sending_api_token` | `str` | Declared; value omitted |
| `sending_jobs_enabled` | `bool` | False |
| `sending_production_enabled` | `bool` | False |

## Migration declarations

Historical revision names containing `ph2` or `ph3` are retained identifiers; administrative phase naming never renumbers migration history. The last verified Stage head is `ph3_009_read_indexes` across nine actual schemas. A source chain is not a fresh hosted inventory.

| Revision | Parent | Source |
| --- | --- | --- |
| 3f3c0f09ecf4 | e672c40fa912 | [`alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py) |
| 7e416c6444fe | None | [`alembic/versions/7e416c6444fe_baseline.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/7e416c6444fe_baseline.py) |
| a10d45de891c | f409a1ac1700 | [`alembic/versions/a10d45de891c_issued_status_guard.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a10d45de891c_issued_status_guard.py) |
| a82d43cf6120 | f710bc319ae2 | [`alembic/versions/a82d43cf6120_project_workflow_and_agreements.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/a82d43cf6120_project_workflow_and_agreements.py) |
| b07c9d621a30 | a10d45de891c | [`alembic/versions/b07c9d621a30_pin_guard_schema.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/b07c9d621a30_pin_guard_schema.py) |
| c41894d13cb7 | 3f3c0f09ecf4 | [`alembic/versions/c41894d13cb7_project_commercial_metadata.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c41894d13cb7_project_commercial_metadata.py) |
| c46f2f62a011 | 7e416c6444fe | [`alembic/versions/c46f2f62a011_immutable_artifacts.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/c46f2f62a011_immutable_artifacts.py) |
| d3517d81ce20 | b07c9d621a30 | [`alembic/versions/d3517d81ce20_contact_reservations.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d3517d81ce20_contact_reservations.py) |
| d529b08f14a2 | c41894d13cb7 | [`alembic/versions/d529b08f14a2_project_billing.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/d529b08f14a2_project_billing.py) |
| e3b42aea781a | c46f2f62a011 | [`alembic/versions/e3b42aea781a_parent_guards_and_sessions.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e3b42aea781a_parent_guards_and_sessions.py) |
| e640ab7230cd | d529b08f14a2 | [`alembic/versions/e640ab7230cd_case_identity_and_types.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e640ab7230cd_case_identity_and_types.py) |
| e672c40fa912 | d3517d81ce20 | [`alembic/versions/e672c40fa912_cases_and_allocations.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/e672c40fa912_cases_and_allocations.py) |
| f409a1ac1700 | e3b42aea781a | [`alembic/versions/f409a1ac1700_parent_lock_guards.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f409a1ac1700_parent_lock_guards.py) |
| f710bc319ae2 | e640ab7230cd | [`alembic/versions/f710bc319ae2_mail_attachment_custody.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/f710bc319ae2_mail_attachment_custody.py) |
| ph2_001_credit_memos | a82d43cf6120 | [`alembic/versions/ph2_001_credit_memos.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_001_credit_memos.py) |
| ph2_002_time_commands | ph2_001_credit_memos | [`alembic/versions/ph2_002_time_commands.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_002_time_commands.py) |
| ph2_003_integrations | ph2_002_time_commands | [`alembic/versions/ph2_003_integrations.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph2_003_integrations.py) |
| ph3_001_subscriptions | ph2_003_integrations | [`alembic/versions/ph3_001_subscriptions.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_001_subscriptions.py) |
| ph3_002_sandbox_billing | ph3_001_subscriptions | [`alembic/versions/ph3_002_sandbox_billing.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_002_sandbox_billing.py) |
| ph3_003_onboarding_auth | ph3_002_sandbox_billing | [`alembic/versions/ph3_003_onboarding_auth.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_003_onboarding_auth.py) |
| ph3_004_sending | ph3_003_onboarding_auth | [`alembic/versions/ph3_004_sending.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_004_sending.py) |
| ph3_005_public_admission | ph3_004_sending | [`alembic/versions/ph3_005_public_admission.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_005_public_admission.py) |
| ph3_006_quoting_library | ph3_005_public_admission | [`alembic/versions/ph3_006_quoting_library.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_006_quoting_library.py) |
| ph3_007_work_records | ph3_006_quoting_library | [`alembic/versions/ph3_007_work_records.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_007_work_records.py) |
| ph3_008_client_lifecycle | ph3_007_work_records | [`alembic/versions/ph3_008_client_lifecycle.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_008_client_lifecycle.py) |
| ph3_009_read_indexes | ph3_008_client_lifecycle | [`alembic/versions/ph3_009_read_indexes.py`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/alembic/versions/ph3_009_read_indexes.py) |

## Python project declarations

Python requirement `>=3.12`; project version `0.1.0`.

| Group | Requirement |
| --- | --- |
| runtime | fastapi>=0.115,<1 |
| runtime | uvicorn>=0.34,<1 |
| runtime | sqlalchemy>=2.0,<3 |
| runtime | alembic>=1.15,<2 |
| runtime | psycopg[binary]>=3.2,<4 |
| runtime | jinja2>=3.1,<4 |
| runtime | python-multipart>=0.0.20,<1 |
| runtime | authlib>=1.6,<2 |
| runtime | httpx>=0.28,<1 |
| runtime | itsdangerous>=2.2,<3 |
| runtime | cryptography>=45,<49 |
| runtime | weasyprint>=66,<71 |
| runtime | tzdata>=2025.2 |
| runtime | python-dotenv>=1.1,<2 |

| Group | Requirement |
| --- | --- |
| development | pytest>=8,<10 |
| development | ruff>=0.12,<1 |
| development | mypy>=1.16,<2 |
| development | pypdf>=5,<7 |
| development | playwright>=1.55,<2 |

## Complete uv.lock package inventory (61)

Locked versions are snapshot facts, not recommendations or a current vulnerability assessment.

| Package | Version |
| --- | --- |
| alembic | 1.20.0 |
| annotated-doc | 0.0.5 |
| annotated-types | 0.8.0 |
| anyio | 4.15.1 |
| authlib | 1.8.0 |
| brotli | 1.2.0 |
| brotlicffi | 1.2.0.2 |
| certifi | 2026.7.22 |
| cffi | 2.1.1 |
| click | 8.5.0 |
| colorama | 0.4.6 |
| cryptography | 48.0.1 |
| cssselect2 | 0.10.1 |
| fastapi | 0.143.0 |
| fonttools | 4.66.1 |
| greenlet | 3.5.6 |
| h11 | 0.16.0 |
| httpcore | 1.0.9 |
| httpx | 0.28.1 |
| idna | 3.20 |
| iniconfig | 2.3.1 |
| itsdangerous | 2.2.0 |
| jinja2 | 3.1.6 |
| joserfc | 1.7.5 |
| librt | 0.16.0 |
| mako | 1.4.3 |
| markupsafe | 3.0.4 |
| mypy | 1.20.2 |
| mypy-extensions | 1.1.0 |
| opentelemetry-api | 1.45.1 |
| packaging | 26.3 |
| pathspec | 1.1.1 |
| pillow | 12.3.0 |
| playwright | 1.63.0 |
| pluggy | 1.6.0 |
| psycopg | 3.3.6 |
| psycopg-binary | 3.3.6 |
| pycparser | 3.11 |
| pydantic | 2.14.0 |
| pydantic-core | 2.50.0 |
| pydyf | 0.12.1 |
| pyee | 13.0.1 |
| pygments | 2.21.0 |
| pypdf | 6.20.0 |
| pyphen | 0.18.1 |
| pytest | 9.1.1 |
| python-dotenv | 1.2.4 |
| python-multipart | 0.0.32 |
| ruff | 0.17.0 |
| sqlalchemy | 2.1.4 |
| starlette | 1.7.0 |
| timeker | 0.1.0 |
| tinycss2 | 1.5.1 |
| tinyhtml5 | 2.1.0 |
| typing-extensions | 4.16.0 |
| typing-inspection | 0.4.4 |
| tzdata | 2026.5 |
| uvicorn | 0.54.0 |
| weasyprint | 70.0 |
| webencodings | 0.6.1 |
| zopfli | 0.4.3 |

## Worker package declarations

[`deploy/cloudflare/package.json`](https://github.com/edlopezpm-ops/timeKER-Stage/blob/4bb5c424d6e7d270cdca1479283896be77d581c3/deploy/cloudflare/package.json)

| Group | Package | Version |
| --- | --- | --- |
| dependencies | @cloudflare/containers | 0.3.7 |
| devDependencies | @cloudflare/workers-types | 5.20261011.1 |
| devDependencies | @types/node | 26.6.5 |
| devDependencies | typescript | 7.0.2 |
| devDependencies | wrangler | 4.149.0 |
