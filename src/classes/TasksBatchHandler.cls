/**
 * Created by a000 on 14.03.2021.
 */

public with sharing class TasksBatchHandler implements Database.Batchable<SObject>{
    public final Account acc;
    public final String accName;
    public TasksBatchHandler(Account acc, String accName){
        this.acc = acc;
        this.accName = accName;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, Account_Owner__c FROM Task WHERE Is_Synced__c = false');
    }
    public void execute(Database.BatchableContext BC, List<Task> lstTask){
        for(Task t : lstTask){
            t.Account_Owner__c = accName;
            t.Is_Synced__c = true;
        }
        if (!lstTask.isEmpty()) {
            update lstTask;
        }
    }
    public void finish(Database.BatchableContext BC){
        System.debug('done');
    }
}