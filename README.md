# msbc-vendors

Small Business Central extension that captures Vendor master-data changes,
processes the captured entries in batches, and exposes them through a read-only
API page. Processing is simulated: successful entries are marked `Sent`; no
HTTP calls are made.

## Setup from a clean install

1. Publish the supplied `msbc-vendors` `.app` file to the target Business
	 Central sandbox.
2. Assign the **Vendor Watch** permission set to the user who will configure
	 and operate the extension. The permission set includes the Vendor Watch
	 tables, pages, processor, event subscriber, install codeunit, and required
	 Job Queue Entry access.
3. Search for **Vendor Watch Setup** and open it. The install codeunit creates
	 the setup row automatically for each company. The initial values are:
	 **Enabled** = false, **Batch Size** = 115, **Max Attempts** = 5, and blank
	 **Failure Vendor No.**.
4. Set **Enabled** to true. Keep **Batch Size** and **Max Attempts** positive.
	 Leave **Failure Vendor No.** blank for normal processing.
5. Search for **Vendor Watch Entries**. Keep this page open while testing.
6. Create a vendor, modify one of its meaningful fields, or delete it. A
	 `Pending` entry should appear. Meaningful modification fields are Name,
	 Address, City, Phone No., E-Mail, VAT Registration No., and Blocked.
7. The install codeunit creates a recurring Job Queue Entry for codeunit
	 `71002`, scheduled every five minutes. To process immediately, open **Job
	 Queue Entries**, select **Vendor Watch Processor**, and choose **Run once**.
	 The pending entry should become `Sent` and receive a processed date/time.
8. To demonstrate failure and retry, set **Failure Vendor No.** to the vendor
	 number of a pending entry. Run the processor once per batch interval, or
	 use **Run once** repeatedly. Each failure increments **Attempts** and stores
	 the error. When Attempts reaches **Max Attempts**, the entry becomes
	 `Failed`. Clear **Failure Vendor No.** afterward.

## API

The API page uses publisher `interview`, group `api`, and version `v1.0`.
The entity set is `vendorWatchEntries` and is read-only.

```text
https://api.businesscentral.dynamics.com/v2.0/{environment}/api/interview/api/v1.0/companies({company-id})/vendorWatchEntries
```

Use the company ID without curly braces. The standard API `companies` endpoint
can be used to find it:

```text
https://api.businesscentral.dynamics.com/v2.0/{environment}/api/v2.0/companies
```

### API authentication and permissions

The API caller must authenticate to the same Business Central tenant and
environment. Assign the **Vendor Watch** permission set to the identity that
the API uses. The extension permission set includes read access to Vendor
Watch Entry and the API page.

For an interactive user sign-in:

1. Assign **Vendor Watch** to the Business Central user who signs in.
2. Request a new access token after changing permissions.
3. Call the endpoint using that user's bearer token.

For an Entra application using client credentials:

1. Register the integration in **Microsoft Entra ID** and note its Application
	(client) ID.
2. Grant the application the required Business Central API application
	permission and admin consent in Entra ID.
3. In Business Central, open **Microsoft Entra Applications** and add the same
	Application (client) ID.
4. Assign the **Vendor Watch** permission set to that Microsoft Entra
	application. Assign it for the target company, or leave Company blank when
	the permission should apply to all companies.
5. Request a new access token and use it as `Authorization: Bearer {token}`.

The permission must be assigned to the identity represented by the token. A
permission assigned to your personal Business Central user does not grant
access to an Entra application token.

The API exposes `id`, `entryNo`, `vendorNo`, `vendorName`, `operationType`,
`status`, `attempts`, `capturedDateTime`, `processedDateTime`, `errorMessage`,
and `userId`. Consumers can filter by status and captured date, for example:

```text
?$filter=status eq 'Pending'
?$filter=capturedDateTime ge 2026-09-21T00:00:00Z
```

## Testing and verification

- The AL project was build-checked after the cleanup; the compiler reported no
	source errors or warnings. The editor may still show AL Object ID Ninja
	notices for these assigned IDs; those IDs are intentionally within the
	required 71000-71099 range.
- The required code paths are implemented for insert, meaningful modify,
	delete, batch processing, retry, maximum attempts, setup initialization,
	permissions, and API exposure.
- The clean-install walkthrough, job queue execution, retry demonstration,
	and API request must be exercised in the target sandbox before submission.
- No automated test codeunit is included in this delivery. Test-library
	dependencies are intentionally not added because the extension must keep
	`dependencies` empty.

## Decisions and trade-offs

- The install codeunit owns setup and job queue initialization. It checks for
	existing records before inserting, so installation does not duplicate them.
- A meaningful modification is limited to fields a finance user would normally
	care about: Name, Address, City, Phone No., E-Mail, VAT Registration No., or
	Blocked. Administrative changes are ignored.
- `FindSet(true)` locks the selected pending entries during processing, which
	prevents concurrent processor runs from selecting the same rows.
- The failure-vendor setting provides deterministic retry testing without an
	external service.
- If an insert event contains a blank vendor name, the later modification event
	fills the latest pending insert entry when the name is available.

## Left out

Upgrade codeunit, bound API reset action, telemetry, automated test codeunit,
and real outbound HTTP processing are not included. They are optional follow-up
work and were left out to keep this delivery within the required scope plus the
install codeunit.

The compiled `.app` file should be supplied separately and not committed to the
repository.