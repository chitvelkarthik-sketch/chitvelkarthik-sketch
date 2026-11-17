# Salesforce Apex & SOQL Practice

Small learning exercises added to this portfolio to demonstrate ongoing Salesforce platform learning. These are sample exercises, not claims of production deployment or work completed for an employer.

## Apex: Contact follow-up task service

- `ContactFollowUpService.cls` — bulk-oriented example that creates one follow-up Task for each Contact Id supplied.
- `ContactFollowUpServiceTest.cls` — illustrative unit tests for multiple contacts and empty input.

### Concepts demonstrated

- Apex class and static method
- Set and List collections
- SOQL query with a bind variable
- Bulk processing (one query and one insert outside loops)
- Standard Contact and Task objects
- Apex unit tests and assertions

### Try it in a Salesforce Developer org

1. Open **Setup → Developer Console** or use Salesforce Extensions for VS Code.
2. Create the Apex class and test class using the supplied files.
3. Run the test class from **Test → New Run** or the Apex Tests panel.
4. Review the test results and debug any org-specific validation or automation that affects Task creation.

The example uses standard Salesforce objects and picklist values. A Salesforce org may have validation rules, required custom fields, or automation that needs to be considered before running it.

## SOQL query cookbook

Run these queries in Developer Console → Query Editor or the VS Code Salesforce CLI query tools.

### 1. Retrieve contacts

```sql
SELECT Id, FirstName, LastName, Email
FROM Contact
ORDER BY LastName
LIMIT 50
```

### 2. Filter by last name

```sql
SELECT Id, Name, Email
FROM Contact
WHERE LastName = 'Sharma'
```

### 3. Search by partial name

```sql
SELECT Id, Name
FROM Contact
WHERE LastName LIKE 'Kar%'
```

### 4. Query related account information

```sql
SELECT Id, Name, Account.Name
FROM Contact
WHERE AccountId != null
LIMIT 50
```

### 5. Count records

```sql
SELECT COUNT()
FROM Contact
```

### 6. Group contacts by account

```sql
SELECT AccountId, COUNT(Id)
FROM Contact
WHERE AccountId != null
GROUP BY AccountId
```

### 7. Retrieve recently created tasks

```sql
SELECT Id, Subject, Status, ActivityDate, WhoId
FROM Task
WHERE CreatedDate = LAST_N_DAYS:30
ORDER BY CreatedDate DESC
LIMIT 100
```

### 8. Query contacts created this month

```sql
SELECT Id, Name, CreatedDate
FROM Contact
WHERE CreatedDate = THIS_MONTH
ORDER BY CreatedDate DESC
```

## Important notes

- SOQL is Salesforce Object Query Language; it retrieves records from Salesforce objects.
- Use the object and field API names that actually exist in your org.
- These examples use standard objects so they do not assume that a custom Patient object exists.
- Do not place real patient information, credentials, access tokens, or confidential employer data in a public repository.
