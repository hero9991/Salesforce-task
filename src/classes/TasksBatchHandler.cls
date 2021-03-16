/**
 * Created by a000 on 14.03.2021.
 */

public with sharing class TasksBatchHandler implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT AccountId, Account_Owner__c FROM Task WHERE Is_Synced__c = false');
    }
    public void execute(Database.BatchableContext BC, List<Task> lstTask){
        Set<Id> setAccountIds = new Set<Id>();
        for (Task t : lstTask) {
            setAccountIds.add(t.AccountId);
        }
        List<Account> lstAccount = [SELECT Id, Name FROM Account WHERE Id IN :setAccountIds];
        for (Account acc : lstAccount) {
            acc.Updated_By_Task__c = true;
        }
        Map<Id, Account> mapAccount = new Map<Id, Account>(lstAccount);
        for(Task t : lstTask){
            System.debug(mapAccount.get(t.AccountId));
            if (mapAccount.get(t.AccountId) != null) {
                t.Account_Owner__c = mapAccount.get(t.AccountId).Name;
            }
            t.Is_Synced__c = true;
        }
        if (!lstTask.isEmpty()) {
            update lstTask;
            update lstAccount;
        }
    }
    public void finish(Database.BatchableContext BC){
        System.debug('done');
    }
}