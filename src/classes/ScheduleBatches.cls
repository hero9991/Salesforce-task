/**
 * Created by a000 on 15.03.2021.
 */

public with sharing class ScheduleBatches implements Schedulable {
    public void execute (SchedulableContext context) {
        Account acc = [SELECT Id, OwnerId, BillingStreet, BillingPostalCode, BillingState,
                BillingCountry, BillingCity FROM Account LIMIT 1];

        acc.Updated_By_Task__c = true;
        List<User> accOwnerName = [SELECT Name FROM User WHERE Id = :acc.OwnerId];
        Database.executeBatch(new TasksBatchHandler(acc, accOwnerName[0].Name), 200);

        acc.Updated_By_Contact__c = true;
        Database.executeBatch(new ContactBatchHandler(acc), 200);

        update acc;
    }
}