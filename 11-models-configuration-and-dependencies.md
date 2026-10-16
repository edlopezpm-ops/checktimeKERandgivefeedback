# Models, configuration, migrations and dependencies

Snapshot: 2026-10-16; Stage source-analysis commit `48e854ff2107dffb217dfe7c487b1b9d36a7f41d`.
Generated offline from tracked source. No application import, database connection, provider request, credential read or test execution occurred.
This is a dated review appendix, not a replacement for canonical contracts. Source pointers below refer to this commit.

## Mapped entities and declared fields

Static SQLAlchemy declarations are listed, including central directory models. Actual tenant membership, row values, runtime ownership, active allocations and ACLs are not inferred from these declarations. Constraint/trigger behavior is explained in chapter02 and maintained by migrations.

### `workspace_admissions` — `WorkspaceAdmission`

`app/admission_models.py:12`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `slot_id` | `Mapped[UUID]` | `mapped_column(unique=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(unique=True)` |
| `email` | `Mapped[str]` | `mapped_column(String(254), unique=True)` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='reserved')` |
### `admission_identities` — `AdmissionIdentity`

`app/admission_models.py:26`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `tenant_id` | `Mapped[UUID]` | `mapped_column()` |
| `owner_id` | `Mapped[UUID]` | `mapped_column()` |
| `identity_id` | `Mapped[UUID]` | `mapped_column()` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `verified_email` | `Mapped[str]` | `mapped_column(String(254))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='pending')` |
### `public_email_challenges` — `PublicEmailChallenge`

`app/admission_models.py:43`

| Attribute | Annotation | Persistence declaration |
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

`app/credit_memo_models.py:14`

| Attribute | Annotation | Persistence declaration |
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

`app/enrollment_models.py:12`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `issuer` | `Mapped[str]` | `mapped_column(String(255))` |
| `subject` | `Mapped[str]` | `mapped_column(String(255))` |
| `verified_email` | `Mapped[str]` | `mapped_column(String(254))` |
| `revoked_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `owner_registrations` — `OwnerRegistration`

`app/enrollment_models.py:26`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `terms_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `privacy_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `catalog_version` | `Mapped[str]` | `mapped_column(String(60))` |
| `offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `accepted_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
### `email_auth_challenges` — `EmailAuthChallenge`

`app/enrollment_models.py:42`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `session_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `intent` | `Mapped[str]` | `mapped_column(String(12))` |
| `offer` | `Mapped[str]` | `mapped_column(String(20))` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `attempts` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
### `integration_grants` — `IntegrationGrant`

`app/integration_models.py:21`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `tenant_id` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `client_id` | `Mapped[str]` | `mapped_column(String(120))` |
| `label` | `Mapped[str]` | `mapped_column(String(120))` |
| `scopes` | `Mapped[list]` | `mapped_column(JSONB)` |
| `resource` | `Mapped[str]` | `mapped_column(String(300))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `revoked_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `integration_codes` — `IntegrationCode`

`app/integration_models.py:33`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `redirect_uri` | `Mapped[str]` | `mapped_column(String(1000))` |
| `code_challenge` | `Mapped[str]` | `mapped_column(String(128))` |
| `code_challenge_method` | `Mapped[str]` | `mapped_column(String(10), default='S256')` |
| `scope` | `Mapped[str]` | `mapped_column(String(500))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `used_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `integration_tokens` — `IntegrationToken`

`app/integration_models.py:51`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `kind` | `Mapped[str]` | `mapped_column(String(10))` |
| `scope` | `Mapped[str]` | `mapped_column(String(500))` |
| `client_id` | `Mapped[str]` | `mapped_column(String(120))` |
| `expires_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `used_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `integration_operations` — `IntegrationOperation`

`app/integration_models.py:69`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `grant_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('integration_grants.id'), index=True)` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `tool` | `Mapped[str]` | `mapped_column(String(60))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |
### `client_drafts` — `ClientDraft`

`app/integration_models.py:79`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `payload` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `library_documents` — `LibraryDocument`

`app/library_models.py:24`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `title` | `Mapped[str]` | `mapped_column(String(180))` |
| `kind` | `Mapped[str]` | `mapped_column(String(16))` |
| `status` | `Mapped[str]` | `mapped_column(String(12), default='draft')` |
| `content` | `Mapped[str]` | `mapped_column(Text, default='')` |
| `is_template` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `case_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `client_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `source_template` | `Mapped[str \| None]` | `mapped_column(String(40))` |
| `source_upload_id` | `Mapped[UUID \| None]` | `mapped_column(Uuid)` |
| `revision` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `library_uploads` — `LibraryUpload`

`app/library_models.py:48`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `document_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('library_documents.id'), index=True)` |
| `uploaded_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `content_type` | `Mapped[str]` | `mapped_column(String(128))` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
### `library_document_versions` — `LibraryDocumentVersion`

`app/library_models.py:64`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `document_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('library_documents.id'), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `snapshot` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `source_upload_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('library_uploads.id'))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
| `pdf_size` | `Mapped[int]` | `mapped_column(Integer)` |
| `pdf_sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(80))` |
| `published_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
### `mail_messages` — `MailMessage`

`app/mail_models.py:21`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `case_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `message_id` | `Mapped[str \| None]` | `mapped_column(String(998))` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `subject` | `Mapped[str]` | `mapped_column(String(998))` |
| `sender` | `Mapped[str]` | `mapped_column(String(2000))` |
| `recipients` | `Mapped[str]` | `mapped_column(String(4000))` |
| `body` | `Mapped[str]` | `mapped_column(Text)` |
| `message_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `received_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `archived_basis_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `archive_basis_source` | `Mapped[str]` | `mapped_column(String(20))` |
| `archived_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `source` | `Mapped[str]` | `mapped_column(String(10))` |
| `attachment_count` | `Mapped[int]` | `mapped_column(Integer)` |
### `mail_addresses` — `MailAddress`

`app/mail_models.py:48`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `case_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `token_digest` | `Mapped[str]` | `mapped_column(String(64), unique=True)` |
| `revoked_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `mail_attachments` — `MailAttachment`

`app/mail_models.py:58`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `message_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('mail_messages.id'), index=True)` |
| `position` | `Mapped[int]` | `mapped_column(Integer)` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `declared_content_type` | `Mapped[str]` | `mapped_column(String(128), default='application/octet-stream')` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
### `contact_attempts` — `ContactAttempt`

`app/models.py:33`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `id` | `Mapped[UUID]` | `mapped_column(Uuid, primary_key=True)` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `session_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `address_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `network_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `status` | `Mapped[str]` | `mapped_column(String(12))` |
### `users` — `User`

`app/models.py:59`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `email` | `Mapped[str]` | `mapped_column(String(254), unique=True)` |
| `display_name` | `Mapped[str]` | `mapped_column(String(100))` |
| `role` | `Mapped[str]` | `mapped_column(String(20), default='owner')` |
| `active` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `last_login_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `session_revision` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
### `clients` — `Client`

`app/models.py:69`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `code` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `legal_name` | `Mapped[str]` | `mapped_column(String(200))` |
| `display_name` | `Mapped[str]` | `mapped_column(String(120), index=True)` |
| `country_code` | `Mapped[str]` | `mapped_column(String(2))` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='active', index=True)` |
| `timezone` | `Mapped[str]` | `mapped_column(String(80), default='UTC')` |
| `language` | `Mapped[str]` | `mapped_column(String(2), default='en')` |
| `currency` | `Mapped[str]` | `mapped_column(String(3), default='USD')` |
| `rate` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `weekly_limit_minutes` | `Mapped[int \| None]` | `mapped_column(Integer)` |
| `payment_terms_days` | `Mapped[int]` | `mapped_column(Integer, default=15)` |
| `profile` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `contract` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `archived_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `contacts` — `Contact`

`app/models.py:95`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `name` | `Mapped[str]` | `mapped_column(String(100))` |
| `title` | `Mapped[str \| None]` | `mapped_column(String(100))` |
| `email` | `Mapped[str \| None]` | `mapped_column(String(254))` |
| `phone` | `Mapped[str \| None]` | `mapped_column(String(50))` |
| `contact_type` | `Mapped[str]` | `mapped_column(String(40), default='general')` |
| `may_request_work` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `may_approve_hours` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `active` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
### `projects` — `Project`

`app/models.py:108`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `code` | `Mapped[str]` | `mapped_column(String(30))` |
| `name` | `Mapped[str]` | `mapped_column(String(150))` |
| `description` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='active')` |
| `billable` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `rate_override` | `Mapped[Decimal \| None]` | `mapped_column(Numeric(14, 2))` |
| `project_type` | `Mapped[str \| None]` | `mapped_column(String(40))` |
| `budget_amount` | `Mapped[Decimal \| None]` | `mapped_column(Numeric(14, 2))` |
| `budget_currency` | `Mapped[str \| None]` | `mapped_column(String(3))` |
| `agreement_type` | `Mapped[str \| None]` | `mapped_column(String(10))` |
| `agreement_reference` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `allow_overbilling` | `Mapped[bool]` | `mapped_column(Boolean, default=False, server_default='false')` |
### `project_agreements` — `ProjectAgreement`

`app/models.py:147`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), unique=True)` |
| `uploaded_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `filename` | `Mapped[str]` | `mapped_column(String(180))` |
| `size` | `Mapped[int]` | `mapped_column(Integer)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload` | `Mapped[bytes]` | `mapped_column(LargeBinary, deferred=True, deferred_raiseload=True)` |
### `timecards` — `Timecard`

`app/models.py:162`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `archived_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `week_start` | `Mapped[date]` | `mapped_column(Date, index=True)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Draft', index=True)` |
| `total_minutes` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
| `finalized_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `cap_override_reason` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `cap_override_reference` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `entries` | `Mapped[list['TimeEntry']]` | `relationship(cascade='all, delete-orphan', order_by='TimeEntry.work_date')` |
### `time_entries` — `TimeEntry`

`app/models.py:186`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `timecard_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('timecards.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'))` |
| `work_date` | `Mapped[date]` | `mapped_column(Date, index=True)` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `category` | `Mapped[str]` | `mapped_column(String(40), default='consulting')` |
| `description` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `billable` | `Mapped[bool]` | `mapped_column(Boolean, default=True)` |
| `rate_override` | `Mapped[Decimal \| None]` | `mapped_column(Numeric(14, 2))` |
### `cases` — `Case`

`app/models.py:202`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True, start=10001), unique=True)` |
| `legacy_number` | `Mapped[str \| None]` | `mapped_column(String(30))` |
| `case_type` | `Mapped[str]` | `mapped_column(String(20))` |
| `title` | `Mapped[str]` | `mapped_column(String(200))` |
| `description` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Open', index=True)` |
| `opened_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `resolved_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `closed_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `archived_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `case_time_allocations` — `CaseTimeAllocation`

`app/models.py:233`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `entry_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('time_entries.id'), index=True)` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `invoices` — `Invoice`

`app/models.py:247`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `fixed_fee_project_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('projects.id'))` |
| `manual_extra_project_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('projects.id'))` |
| `manual_extra_reference` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `number` | `Mapped[str]` | `mapped_column(String(60), unique=True)` |
| `period_start` | `Mapped[date]` | `mapped_column(Date)` |
| `period_end` | `Mapped[date]` | `mapped_column(Date)` |
| `issue_date` | `Mapped[date \| None]` | `mapped_column(Date)` |
| `delivered_at` | `Mapped[date \| None]` | `mapped_column(Date)` |
| `due_date` | `Mapped[date \| None]` | `mapped_column(Date, index=True)` |
| `status` | `Mapped[str]` | `mapped_column(String(20), default='Draft', index=True)` |
| `currency` | `Mapped[str]` | `mapped_column(String(3))` |
| `subtotal` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `adjustments` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `total` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `snapshot` | `Mapped[dict \| None]` | `mapped_column(JSONB)` |
| `issued_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `voided_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `void_reason` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `lines` | `Mapped[list['InvoiceLine']]` | `relationship(cascade='all, delete-orphan', order_by='InvoiceLine.sort_order')` |
### `invoice_lines` — `InvoiceLine`

`app/models.py:306`

| Attribute | Annotation | Persistence declaration |
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

`app/models.py:330`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `entry_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('time_entries.id'), primary_key=True)` |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), index=True)` |
### `invoice_artifacts` — `Artifact`

`app/models.py:336`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), unique=True)` |
| `filename` | `Mapped[str]` | `mapped_column(String(150))` |
| `pdf_bytes` | `Mapped[bytes]` | `mapped_column(LargeBinary)` |
| `sha256` | `Mapped[str]` | `mapped_column(String(64))` |
| `renderer_version` | `Mapped[str]` | `mapped_column(String(40))` |
### `payments` — `Payment`

`app/models.py:345`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `invoice_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('invoices.id'), index=True)` |
| `paid_at` | `Mapped[date]` | `mapped_column(Date)` |
| `amount` | `Mapped[Decimal]` | `mapped_column(Numeric(14, 2))` |
| `currency` | `Mapped[str]` | `mapped_column(String(3))` |
| `method` | `Mapped[str]` | `mapped_column(String(40))` |
| `reference` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `note` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `created_by` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `reversed_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `audit_events` — `Audit`

`app/models.py:359`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('users.id'))` |
| `request_id` | `Mapped[UUID]` | `mapped_column(Uuid)` |
| `event_type` | `Mapped[str]` | `mapped_column(String(60))` |
| `entity_type` | `Mapped[str]` | `mapped_column(String(30))` |
| `entity_id` | `Mapped[UUID]` | `mapped_column(Uuid, index=True)` |
| `details` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
### `app_settings` — `AppSettings`

`app/models.py:369`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `key` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `value` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
| `encrypted_value` | `Mapped[bytes \| None]` | `mapped_column(LargeBinary)` |
### `proposal_sending_deliveries` — `ProposalSendingDelivery`

`app/proposal_sending_models.py:22`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `quote_artifact_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('quote_artifacts.id'))` |
| `library_version_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('library_document_versions.id'))` |
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
| `last_code` | `Mapped[str \| None]` | `mapped_column(String(40))` |
| `confirmed_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `sent_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `stopped_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `proposal_sending_attempts` — `ProposalSendingAttempt`

`app/proposal_sending_models.py:58`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `delivery_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('proposal_sending_deliveries.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `code` | `Mapped[str]` | `mapped_column(String(40))` |
| `completed_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `quotes` — `Quote`

`app/quoting_models.py:30`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(BigInteger, Identity(always=True), unique=True)` |
| `operation_key` | `Mapped[UUID]` | `mapped_column(Uuid, default=uuid4)` |
| `create_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `archived_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `quote_revisions` — `QuoteRevision`

`app/quoting_models.py:45`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `quote_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('quotes.id'), index=True)` |
| `parent_revision_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('quote_revisions.id'))` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `status` | `Mapped[str]` | `mapped_column(String(12), default='draft')` |
| `title` | `Mapped[str]` | `mapped_column(String(200))` |
| `prepared_for` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `case_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('cases.id'), index=True)` |
| `client_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('clients.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'), index=True)` |
| `preset` | `Mapped[str]` | `mapped_column(String(30), default='quick_effort')` |
| `currency` | `Mapped[str \| None]` | `mapped_column(String(3))` |
| `assumptions` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `exclusions` | `Mapped[str \| None]` | `mapped_column(Text)` |
| `valid_until` | `Mapped[date \| None]` | `mapped_column(Date)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `quote_lines` — `QuoteLine`

`app/quoting_models.py:77`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `revision_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('quote_revisions.id'), index=True)` |
| `position` | `Mapped[int]` | `mapped_column(Integer)` |
| `label` | `Mapped[str]` | `mapped_column(String(500))` |
| `scope_type` | `Mapped[str]` | `mapped_column(String(12), default='task')` |
| `min_minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `max_minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `pricing_model` | `Mapped[str \| None]` | `mapped_column(String(30))` |
| `unit_rate` | `Mapped[Decimal \| None]` | `mapped_column(Numeric(14, 2))` |
| `fixed_amount` | `Mapped[Decimal \| None]` | `mapped_column(Numeric(14, 2))` |
### `quote_artifacts` — `QuoteArtifact`

`app/quoting_models.py:103`

| Attribute | Annotation | Persistence declaration |
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

`app/sending_models.py:21`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), unique=True)` |
| `paused` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `initial_subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `initial_body` | `Mapped[str]` | `mapped_column(Text)` |
| `followup_subject` | `Mapped[str]` | `mapped_column(String(200))` |
| `followup_body` | `Mapped[str]` | `mapped_column(Text)` |
### `sending_plans` — `SendingPlan`

`app/sending_models.py:31`

| Attribute | Annotation | Persistence declaration |
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
| `stopped_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `stop_reason` | `Mapped[str \| None]` | `mapped_column(String(30))` |
### `sending_deliveries` — `SendingDelivery`

`app/sending_models.py:55`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'), index=True)` |
| `plan_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('sending_plans.id'), index=True)` |
| `sequence` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='pending', index=True)` |
| `scheduled_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), index=True)` |
| `sent_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `failure_code` | `Mapped[str \| None]` | `mapped_column(String(40))` |
| `attempt_count` | `Mapped[int]` | `mapped_column(Integer, default=0)` |
### `sending_attempts` — `SendingAttempt`

`app/sending_models.py:72`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `delivery_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('sending_deliveries.id'), index=True)` |
| `number` | `Mapped[int]` | `mapped_column(Integer)` |
| `state` | `Mapped[str]` | `mapped_column(String(12))` |
| `code` | `Mapped[str]` | `mapped_column(String(40))` |
| `provider_reference` | `Mapped[str \| None]` | `mapped_column(String(200))` |
| `completed_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
### `subscription_billing_accounts` — `BillingAccount`

`app/subscription_billing_models.py:24`

| Attribute | Annotation | Persistence declaration |
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
| `past_due_since` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `failed_period_start` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `failed_transaction_id` | `Mapped[str \| None]` | `mapped_column(String(30))` |
| `provider_updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True))` |
| `pending_offer` | `Mapped[str \| None]` | `mapped_column(String(20))` |
| `pending_effective_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `pending_selection` | `Mapped[dict \| None]` | `mapped_column(JSONB)` |
| `requires_selection` | `Mapped[bool]` | `mapped_column(Boolean, default=False)` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC), onupdate=lambda: datetime.now(UTC))` |
### `subscription_billing_operations` — `BillingOperation`

`app/subscription_billing_models.py:71`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `action` | `Mapped[str]` | `mapped_column(String(30))` |
| `state` | `Mapped[str]` | `mapped_column(String(12), default='reserved')` |
| `intent` | `Mapped[dict]` | `mapped_column(JSONB)` |
| `transaction_id` | `Mapped[str \| None]` | `mapped_column(String(30), unique=True)` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB, default=dict)` |
### `subscription_billing_events` — `BillingEvent`

`app/subscription_billing_models.py:89`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `provider_event_id` | `Mapped[str]` | `mapped_column(String(30), unique=True)` |
| `raw_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `event_type` | `Mapped[str]` | `mapped_column(String(80))` |
| `outcome` | `Mapped[str]` | `mapped_column(String(24))` |
| `facts` | `Mapped[dict]` | `mapped_column(JSONB)` |
### `workspace_subscriptions` — `WorkspaceSubscription`

`app/subscription_models.py:13`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `id` | `Mapped[int]` | `mapped_column(Integer, primary_key=True, default=1, autoincrement=False)` |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `plan_code` | `Mapped[str]` | `mapped_column(String(12))` |
| `catalog_revision` | `Mapped[str]` | `mapped_column(String(60))` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
| `access_expires_at` | `Mapped[datetime \| None]` | `mapped_column(DateTime(timezone=True))` |
| `created_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC))` |
| `updated_at` | `Mapped[datetime]` | `mapped_column(DateTime(timezone=True), default=lambda: datetime.now(UTC), onupdate=lambda: datetime.now(UTC))` |
### `subscription_operations` — `SubscriptionOperation`

`app/subscription_models.py:37`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `owner_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `key_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `payload_digest` | `Mapped[str]` | `mapped_column(String(64))` |
| `action` | `Mapped[str]` | `mapped_column(String(80))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |
### `time_import_records` — `TimeImportRecord`

`app/time_command_models.py:13`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `source_record_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `batch_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `payload_hash` | `Mapped[str]` | `mapped_column(String(64))` |
### `time_contributions` — `TimeContribution`

`app/time_command_models.py:26`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `source_item_id` | `Mapped[str]` | `mapped_column(String(128))` |
| `import_record_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('time_import_records.id'))` |
| `timecard_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('timecards.id'), index=True)` |
| `project_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('projects.id'))` |
| `work_date` | `Mapped[date]` | `mapped_column(Date)` |
| `entry_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('time_entries.id'), index=True)` |
| `case_id` | `Mapped[UUID \| None]` | `mapped_column(ForeignKey('cases.id'))` |
| `minutes` | `Mapped[int]` | `mapped_column(Integer)` |
| `description` | `Mapped[str]` | `mapped_column(Text, default='')` |
| `version` | `Mapped[int]` | `mapped_column(Integer, default=1)` |
### `time_operations` — `TimeOperation`

`app/time_command_models.py:49`

| Attribute | Annotation | Persistence declaration |
| --- | --- | --- |
| `actor_id` | `Mapped[UUID]` | `mapped_column(ForeignKey('users.id'))` |
| `source` | `Mapped[str]` | `mapped_column(String(100))` |
| `idempotency_key` | `Mapped[str]` | `mapped_column(String(128))` |
| `payload_hash` | `Mapped[str]` | `mapped_column(String(64))` |
| `operation` | `Mapped[str]` | `mapped_column(String(20))` |
| `result` | `Mapped[dict]` | `mapped_column(JSONB)` |

## Environment configuration contract

Names derive from Settings dataclass fields; environment loader uses `TIMEKER_` plus uppercase field name. Defaults are source defaults, not a hosted configuration readback. Credential-bearing and identity/configuration payload defaults are deliberately not reproduced. See chapter06 for the recorded Stage profile.

| Environment name | Type | Source default classification | Source |
| --- | --- | --- | --- |
| `TIMEKER_ENVIRONMENT` | `str` | 'development' | `app/config.py:15` |
| `TIMEKER_DATABASE_URL` | `str` | Deployment-provided / omitted from dossier | `app/config.py:16` |
| `TIMEKER_DATABASE_ROLE` | `str` | 'timeker_app' | `app/config.py:17` |
| `TIMEKER_DATABASE_SCHEMA` | `str` | '' | `app/config.py:18` |
| `TIMEKER_TENANT_REGISTRY_JSON` | `str` | Deployment-provided / omitted from dossier | `app/config.py:19` |
| `TIMEKER_TENANT_SLOTS_JSON` | `str` | Deployment-provided / omitted from dossier | `app/config.py:20` |
| `TIMEKER_TENANT_DEMO` | `bool` | False | `app/config.py:21` |
| `TIMEKER_BASE_URL` | `str` | 'http://127.0.0.1:8000' | `app/config.py:22` |
| `TIMEKER_SESSION_SECRET` | `str` | Deployment-provided / omitted from dossier | `app/config.py:23` |
| `TIMEKER_ENCRYPTION_KEY` | `str` | Deployment-provided / omitted from dossier | `app/config.py:24` |
| `TIMEKER_GOOGLE_CLIENT_ID` | `str` | '' | `app/config.py:25` |
| `TIMEKER_GOOGLE_CLIENT_SECRET` | `str` | Deployment-provided / omitted from dossier | `app/config.py:26` |
| `TIMEKER_GITHUB_CLIENT_ID` | `str` | '' | `app/config.py:27` |
| `TIMEKER_GITHUB_CLIENT_SECRET` | `str` | Deployment-provided / omitted from dossier | `app/config.py:28` |
| `TIMEKER_TURNSTILE_SITE_KEY` | `str` | Deployment-provided / omitted from dossier | `app/config.py:29` |
| `TIMEKER_TURNSTILE_SECRET_KEY` | `str` | Deployment-provided / omitted from dossier | `app/config.py:30` |
| `TIMEKER_DEV_LOGIN` | `bool` | False | `app/config.py:31` |
| `TIMEKER_ALLOWLIST` | `tuple[str, ...]` | Deployment-provided / omitted from dossier | `app/config.py:32` |
| `TIMEKER_TRUSTED_HOSTS` | `tuple[str, ...]` | ('127.0.0.1', 'localhost', 'testserver') | `app/config.py:33` |
| `TIMEKER_INVOICE_PREFIX` | `str` | 'AEKR' | `app/config.py:34` |
| `TIMEKER_CONTACT_DELIVERY` | `str` | 'disabled' | `app/config.py:35` |
| `TIMEKER_MAIL_DOMAIN` | `str` | '' | `app/config.py:36` |
| `TIMEKER_MAIL_ADDRESS_DOMAIN` | `str` | '' | `app/config.py:37` |
| `TIMEKER_OPTIONAL_USAGE_ENABLED` | `bool` | False | `app/config.py:38` |
| `TIMEKER_MAIL_CAPTURE_ENABLED` | `bool` | False | `app/config.py:39` |
| `TIMEKER_INTERNAL_SECRET` | `str` | Deployment-provided / omitted from dossier | `app/config.py:40` |
| `TIMEKER_INTEGRATION_ENABLED` | `bool` | False | `app/config.py:41` |
| `TIMEKER_INTEGRATION_CLIENTS_JSON` | `str` | Deployment-provided / omitted from dossier | `app/config.py:42` |
| `TIMEKER_SUBSCRIPTION_PROVIDER` | `str` | 'disabled' | `app/config.py:43` |
| `TIMEKER_PADDLE_LIVE_ENABLED` | `bool` | False | `app/config.py:44` |
| `TIMEKER_PADDLE_API_KEY` | `str` | Deployment-provided / omitted from dossier | `app/config.py:45` |
| `TIMEKER_PADDLE_CLIENT_TOKEN` | `str` | Deployment-provided / omitted from dossier | `app/config.py:46` |
| `TIMEKER_PADDLE_WEBHOOK_SECRET` | `str` | Deployment-provided / omitted from dossier | `app/config.py:47` |
| `TIMEKER_PADDLE_PRICE_IDS_JSON` | `str` | Deployment-provided / omitted from dossier | `app/config.py:48` |
| `TIMEKER_PADDLE_RETENTION_DISCOUNT_ID` | `str` | '' | `app/config.py:49` |
| `TIMEKER_STAGE_ONBOARDING_ENABLED` | `bool` | False | `app/config.py:50` |
| `TIMEKER_ONBOARDING_ENABLED` | `bool` | False | `app/config.py:51` |
| `TIMEKER_PUBLIC_SIGNUP_ENABLED` | `bool` | False | `app/config.py:52` |
| `TIMEKER_EMAIL_PUBLIC_SIGNUP_ENABLED` | `bool` | False | `app/config.py:53` |
| `TIMEKER_EMAIL_AUTH_PROVIDER` | `str` | 'disabled' | `app/config.py:54` |
| `TIMEKER_EMAIL_AUTH_URL` | `str` | '' | `app/config.py:55` |
| `TIMEKER_EMAIL_AUTH_PUBLISHABLE_KEY` | `str` | Deployment-provided / omitted from dossier | `app/config.py:56` |
| `TIMEKER_SENDING_PROVIDER` | `str` | 'disabled' | `app/config.py:57` |
| `TIMEKER_SENDING_SENDER` | `str` | 'timeker@aekr.io' | `app/config.py:58` |
| `TIMEKER_SENDING_ACCOUNT_ID` | `str` | '' | `app/config.py:59` |
| `TIMEKER_SENDING_API_TOKEN` | `str` | Deployment-provided / omitted from dossier | `app/config.py:60` |
| `TIMEKER_SENDING_JOBS_ENABLED` | `bool` | False | `app/config.py:61` |
| `TIMEKER_SENDING_PRODUCTION_ENABLED` | `bool` | False | `app/config.py:62` |

## Alembic revision chain

| File | Revision | Down revision | Purpose |
| --- | --- | --- | --- |
| `alembic/versions/3f3c0f09ecf4_mail_custody_and_six_month_archive.py` | `3f3c0f09ecf4` | `e672c40fa912` | mail custody and six-month archive |
| `alembic/versions/7e416c6444fe_baseline.py` | `7e416c6444fe` | `None` | baseline |
| `alembic/versions/a10d45de891c_issued_status_guard.py` | `a10d45de891c` | `f409a1ac1700` | Keep financial immutability independent of operational status. |
| `alembic/versions/a82d43cf6120_project_workflow_and_agreements.py` | `a82d43cf6120` | `f710bc319ae2` | Closed project status and bounded immutable private project agreement. |
| `alembic/versions/b07c9d621a30_pin_guard_schema.py` | `b07c9d621a30` | `a10d45de891c` | Pin immutable-record guards to their installation schema. |
| `alembic/versions/c41894d13cb7_project_commercial_metadata.py` | `c41894d13cb7` | `3f3c0f09ecf4` | Add nullable descriptive project terms without changing invoice calculations. |
| `alembic/versions/c46f2f62a011_immutable_artifacts.py` | `c46f2f62a011` | `7e416c6444fe` | Database immutability and cross-client/period integrity guards. |
| `alembic/versions/d3517d81ce20_contact_reservations.py` | `d3517d81ce20` | `b07c9d621a30` | Durable short-lived contact abuse reservations. |
| `alembic/versions/d529b08f14a2_project_billing.py` | `d529b08f14a2` | `c41894d13cb7` | Explicit project fees, authorized additional charges, and budget reservations. |
| `alembic/versions/e3b42aea781a_parent_guards_and_sessions.py` | `e3b42aea781a` | `c46f2f62a011` | Guard both parents of immutable records; add revocable owner sessions. |
| `alembic/versions/e640ab7230cd_case_identity_and_types.py` | `e640ab7230cd` | `d529b08f14a2` | Automatic global case identity and mandatory project/type validation. |
| `alembic/versions/e672c40fa912_cases_and_allocations.py` | `e672c40fa912` | `d3517d81ce20` | Retained work cases and guarded exact-minute attribution. |
| `alembic/versions/f409a1ac1700_parent_lock_guards.py` | `f409a1ac1700` | `e3b42aea781a` | Serialize database parent guards with concurrent issuance/finalization. |
| `alembic/versions/f710bc319ae2_mail_attachment_custody.py` | `f710bc319ae2` | `e640ab7230cd` | Bounded immutable extracted mail attachments, separate from normalized text. |
| `alembic/versions/ph2_001_credit_memos.py` | `ph2_001_credit_memos` | `a82d43cf6120` | Immutable full credit memos; prohibit new timecard voids, retain history. |
| `alembic/versions/ph2_002_time_commands.py` | `ph2_002_time_commands` | `ph2_001_credit_memos` | Source-owned time contributions, import/command receipts and aggregate guards. |
| `alembic/versions/ph2_003_integrations.py` | `ph2_003_integrations` | `ph2_002_time_commands` | Tenant-local delegated grants, hashed credentials and unpublished client proposals. |
| `alembic/versions/ph3_001_subscriptions.py` | `ph3_001_subscriptions` | `ph2_003_integrations` | Explicit tenant assignment and immutable capacity-operation receipts. |
| `alembic/versions/ph3_002_sandbox_billing.py` | `ph3_002_sandbox_billing` | `ph3_001_subscriptions` | Verified sandbox subscription bindings, durable intents and expiring access. |
| `alembic/versions/ph3_003_onboarding_auth.py` | `ph3_003_onboarding_auth` | `ph3_002_sandbox_billing` | Explicit registration, provider identities and bounded one-time email challenges. |
| `alembic/versions/ph3_004_sending.py` | `ph3_004_sending` | `ph3_003_onboarding_auth` | Retained, owner-confirmed statement sending and conservative dispatch history. |
| `alembic/versions/ph3_005_public_admission.py` | `ph3_005_public_admission` | `ph3_004_sending` | Central prepared-slot admission, immutable identity routing and public challenges. |
| `alembic/versions/ph3_006_quoting_library.py` | `ph3_006_quoting_library` | `ph3_005_public_admission` | Case-bound estimates, Library documents and separate retained commercial delivery. |

## Declared Python requirements

- `fastapi>=0.115,<1`
- `uvicorn>=0.34,<1`
- `sqlalchemy>=2.0,<3`
- `alembic>=1.15,<2`
- `psycopg[binary]>=3.2,<4`
- `jinja2>=3.1,<4`
- `python-multipart>=0.0.20,<1`
- `authlib>=1.6,<2`
- `httpx>=0.28,<1`
- `itsdangerous>=2.2,<3`
- `cryptography>=45,<49`
- `weasyprint>=66,<71`
- `tzdata>=2025.2`
- `python-dotenv>=1.1,<2`
- `pytest>=8,<10`
- `ruff>=0.12,<1`
- `mypy>=1.16,<2`
- `pypdf>=5,<7`
- `playwright>=1.55,<2`

## Complete Python lock inventory

Versions below are locked source versions, not a claim that every optional/transitive package is imported in production. Platform markers and wheel availability remain in uv.lock.

| Package | Locked version |
| --- | --- |
| `alembic` | `1.20.0` |
| `annotated-doc` | `0.0.5` |
| `annotated-types` | `0.8.0` |
| `anyio` | `4.15.1` |
| `authlib` | `1.8.0` |
| `brotli` | `1.2.0` |
| `brotlicffi` | `1.2.0.2` |
| `certifi` | `2026.7.22` |
| `cffi` | `2.1.1` |
| `click` | `8.5.0` |
| `colorama` | `0.4.6` |
| `cryptography` | `48.0.1` |
| `cssselect2` | `0.10.1` |
| `fastapi` | `0.143.0` |
| `fonttools` | `4.66.1` |
| `greenlet` | `3.5.6` |
| `h11` | `0.16.0` |
| `httpcore` | `1.0.9` |
| `httpx` | `0.28.1` |
| `idna` | `3.20` |
| `iniconfig` | `2.3.1` |
| `itsdangerous` | `2.2.0` |
| `jinja2` | `3.1.6` |
| `joserfc` | `1.7.5` |
| `librt` | `0.16.0` |
| `mako` | `1.4.3` |
| `markupsafe` | `3.0.4` |
| `mypy` | `1.20.2` |
| `mypy-extensions` | `1.1.0` |
| `opentelemetry-api` | `1.45.1` |
| `packaging` | `26.3` |
| `pathspec` | `1.1.1` |
| `pillow` | `12.3.0` |
| `playwright` | `1.63.0` |
| `pluggy` | `1.6.0` |
| `psycopg` | `3.3.6` |
| `psycopg-binary` | `3.3.6` |
| `pycparser` | `3.11` |
| `pydantic` | `2.14.0` |
| `pydantic-core` | `2.50.0` |
| `pydyf` | `0.12.1` |
| `pyee` | `13.0.1` |
| `pygments` | `2.21.0` |
| `pypdf` | `6.20.0` |
| `pyphen` | `0.18.1` |
| `pytest` | `9.1.1` |
| `python-dotenv` | `1.2.4` |
| `python-multipart` | `0.0.32` |
| `ruff` | `0.17.0` |
| `sqlalchemy` | `2.1.4` |
| `starlette` | `1.7.0` |
| `timeker` | `0.1.0` |
| `tinycss2` | `1.5.1` |
| `tinyhtml5` | `2.1.0` |
| `typing-extensions` | `4.16.0` |
| `typing-inspection` | `0.4.4` |
| `tzdata` | `2026.5` |
| `uvicorn` | `0.54.0` |
| `weasyprint` | `70.0` |
| `webencodings` | `0.6.1` |
| `zopfli` | `0.4.3` |

## `deploy/cloudflare/package.json`

### scripts

```json
{
  "types": "wrangler types",
  "typecheck": "tsc --noEmit",
  "test": "node --test test/*.test.mjs",
  "dry-run": "wrangler deploy --dry-run --outdir .wrangler/dry-run"
}
```

### dependencies

```json
{
  "@cloudflare/containers": "0.3.7"
}
```

### devDependencies

```json
{
  "@cloudflare/workers-types": "5.20261011.1",
  "@types/node": "26.6.5",
  "typescript": "7.0.2",
  "wrangler": "4.149.0"
}
```


## `deploy/cloudflare/package-lock.json`

| Package path | Version |
| --- | --- |
| `node_modules/@cloudflare/containers` | `0.3.7` |
| `node_modules/@cloudflare/kv-asset-handler` | `0.5.0` |
| `node_modules/@cloudflare/unenv-preset` | `2.16.2` |
| `node_modules/@cloudflare/workerd-darwin-64` | `1.20261006.1` |
| `node_modules/@cloudflare/workerd-darwin-arm64` | `1.20261006.1` |
| `node_modules/@cloudflare/workerd-linux-64` | `1.20261006.1` |
| `node_modules/@cloudflare/workerd-linux-arm64` | `1.20261006.1` |
| `node_modules/@cloudflare/workerd-windows-64` | `1.20261006.1` |
| `node_modules/@cloudflare/workers-types` | `5.20261011.1` |
| `node_modules/@cspotcode/source-map-support` | `0.8.1` |
| `node_modules/@emnapi/runtime` | `1.11.3` |
| `node_modules/@esbuild/aix-ppc64` | `0.28.2` |
| `node_modules/@esbuild/android-arm` | `0.28.2` |
| `node_modules/@esbuild/android-arm64` | `0.28.2` |
| `node_modules/@esbuild/android-x64` | `0.28.2` |
| `node_modules/@esbuild/darwin-arm64` | `0.28.2` |
| `node_modules/@esbuild/darwin-x64` | `0.28.2` |
| `node_modules/@esbuild/freebsd-arm64` | `0.28.2` |
| `node_modules/@esbuild/freebsd-x64` | `0.28.2` |
| `node_modules/@esbuild/linux-arm` | `0.28.2` |
| `node_modules/@esbuild/linux-arm64` | `0.28.2` |
| `node_modules/@esbuild/linux-ia32` | `0.28.2` |
| `node_modules/@esbuild/linux-loong64` | `0.28.2` |
| `node_modules/@esbuild/linux-mips64el` | `0.28.2` |
| `node_modules/@esbuild/linux-ppc64` | `0.28.2` |
| `node_modules/@esbuild/linux-riscv64` | `0.28.2` |
| `node_modules/@esbuild/linux-s390x` | `0.28.2` |
| `node_modules/@esbuild/linux-x64` | `0.28.2` |
| `node_modules/@esbuild/netbsd-arm64` | `0.28.2` |
| `node_modules/@esbuild/netbsd-x64` | `0.28.2` |
| `node_modules/@esbuild/openbsd-arm64` | `0.28.2` |
| `node_modules/@esbuild/openbsd-x64` | `0.28.2` |
| `node_modules/@esbuild/openharmony-arm64` | `0.28.2` |
| `node_modules/@esbuild/sunos-x64` | `0.28.2` |
| `node_modules/@esbuild/win32-arm64` | `0.28.2` |
| `node_modules/@esbuild/win32-ia32` | `0.28.2` |
| `node_modules/@esbuild/win32-x64` | `0.28.2` |
| `node_modules/@img/colour` | `1.1.0` |
| `node_modules/@img/sharp-darwin-arm64` | `0.35.5` |
| `node_modules/@img/sharp-darwin-x64` | `0.35.5` |
| `node_modules/@img/sharp-freebsd-wasm32` | `0.35.5` |
| `node_modules/@img/sharp-libvips-darwin-arm64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-darwin-x64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-arm` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-arm64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-ppc64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-riscv64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-s390x` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linux-x64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linuxmusl-arm64` | `1.3.4` |
| `node_modules/@img/sharp-libvips-linuxmusl-x64` | `1.3.4` |
| `node_modules/@img/sharp-linux-arm` | `0.35.5` |
| `node_modules/@img/sharp-linux-arm64` | `0.35.5` |
| `node_modules/@img/sharp-linux-ppc64` | `0.35.5` |
| `node_modules/@img/sharp-linux-riscv64` | `0.35.5` |
| `node_modules/@img/sharp-linux-s390x` | `0.35.5` |
| `node_modules/@img/sharp-linux-x64` | `0.35.5` |
| `node_modules/@img/sharp-linuxmusl-arm64` | `0.35.5` |
| `node_modules/@img/sharp-linuxmusl-x64` | `0.35.5` |
| `node_modules/@img/sharp-wasm32` | `0.35.5` |
| `node_modules/@img/sharp-webcontainers-wasm32` | `0.35.5` |
| `node_modules/@img/sharp-win32-arm64` | `0.35.5` |
| `node_modules/@img/sharp-win32-ia32` | `0.35.5` |
| `node_modules/@img/sharp-win32-x64` | `0.35.5` |
| `node_modules/@jridgewell/resolve-uri` | `3.1.2` |
| `node_modules/@jridgewell/sourcemap-codec` | `1.6.0` |
| `node_modules/@jridgewell/trace-mapping` | `0.3.9` |
| `node_modules/@poppinss/colors` | `4.1.6` |
| `node_modules/@poppinss/dumper` | `0.6.5` |
| `node_modules/@poppinss/exception` | `1.2.3` |
| `node_modules/@sindresorhus/is` | `7.2.0` |
| `node_modules/@speed-highlight/core` | `1.2.24` |
| `node_modules/@types/node` | `26.6.5` |
| `node_modules/@typescript/typescript-aix-ppc64` | `7.0.2` |
| `node_modules/@typescript/typescript-darwin-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-darwin-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-freebsd-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-freebsd-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-arm` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-loong64` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-mips64el` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-ppc64` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-riscv64` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-s390x` | `7.0.2` |
| `node_modules/@typescript/typescript-linux-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-netbsd-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-netbsd-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-openbsd-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-openbsd-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-sunos-x64` | `7.0.2` |
| `node_modules/@typescript/typescript-win32-arm64` | `7.0.2` |
| `node_modules/@typescript/typescript-win32-x64` | `7.0.2` |
| `node_modules/blake3-wasm` | `2.1.5` |
| `node_modules/cookie` | `1.1.1` |
| `node_modules/detect-libc` | `2.1.2` |
| `node_modules/error-stack-parser-es` | `1.0.5` |
| `node_modules/esbuild` | `0.28.2` |
| `node_modules/fsevents` | `2.3.3` |
| `node_modules/kleur` | `4.1.5` |
| `node_modules/miniflare` | `5.20261006.1-alpha` |
| `node_modules/path-to-regexp` | `6.3.0` |
| `node_modules/pathe` | `2.0.3` |
| `node_modules/semver` | `7.8.5` |
| `node_modules/sharp` | `0.35.5` |
| `node_modules/supports-color` | `10.2.2` |
| `node_modules/tslib` | `2.8.1` |
| `node_modules/typescript` | `7.0.2` |
| `node_modules/undici` | `7.29.1` |
| `node_modules/undici-types` | `8.9.0` |
| `node_modules/unenv` | `2.0.0-rc.24` |
| `node_modules/workerd` | `1.20261006.1` |
| `node_modules/wrangler` | `4.149.0` |
| `node_modules/ws` | `8.21.0` |
| `node_modules/youch` | `4.1.0-beta.10` |
| `node_modules/youch-core` | `0.3.3` |
