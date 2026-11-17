@IsTest
private class ContactFollowUpServiceTest {
    @IsTest
    static void createsOneTaskForEachContact() {
        List<Contact> contacts = new List<Contact>{
            new Contact(LastName = 'Patient One'),
            new Contact(LastName = 'Patient Two')
        };
        insert contacts;

        Set<Id> contactIds = new Map<Id, Contact>(contacts).keySet();

        Test.startTest();
        ContactFollowUpService.createFollowUpTasks(contactIds);
        Test.stopTest();

        List<Task> createdTasks = [
            SELECT Id, WhoId, Subject, Status, Priority, ActivityDate
            FROM Task
            WHERE WhoId IN :contactIds
        ];

        System.assertEquals(2, createdTasks.size(),
            'A follow-up task should be created for each Contact.');

        for (Task followUp : createdTasks) {
            System.assertEquals('Not Started', followUp.Status);
            System.assertEquals('Normal', followUp.Priority);
            System.assertEquals(Date.today().addDays(7), followUp.ActivityDate);
        }
    }

    @IsTest
    static void safelyHandlesEmptyInput() {
        Test.startTest();
        ContactFollowUpService.createFollowUpTasks(new Set<Id>());
        ContactFollowUpService.createFollowUpTasks(null);
        Test.stopTest();

        System.assertEquals(0, [
            SELECT COUNT()
            FROM Task
            WHERE Subject LIKE 'Follow up with%'
        ]);
    }
}