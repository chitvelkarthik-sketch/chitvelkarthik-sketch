/**
 * Learning example: creates a follow-up task for each supplied Contact.
 * Uses the standard Contact and Task objects.
 *
 * This is a portfolio practice exercise, not a deployed production feature.
 */
public with sharing class ContactFollowUpService {
    public static void createFollowUpTasks(Set<Id> contactIds) {
        if (contactIds == null || contactIds.isEmpty()) {
            return;
        }

        List<Task> tasksToInsert = new List<Task>();

        for (Contact person : [
            SELECT Id, Name
            FROM Contact
            WHERE Id IN :contactIds
        ]) {
            tasksToInsert.add(new Task(
                WhoId = person.Id,
                Subject = 'Follow up with ' + person.Name,
                ActivityDate = Date.today().addDays(7),
                Status = 'Not Started',
                Priority = 'Normal'
            ));
        }

        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}