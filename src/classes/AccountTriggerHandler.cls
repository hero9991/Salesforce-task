/**
 * Created by a000 on 10.03.2021.
 */

public with sharing class AccountTriggerHandler {
    @Future
    public static void createTask(Set<Id> setIds) {
        List<Account> lstAccounts = [SELECT Name, Id FROM Account WHERE Id IN :setIds];
        List<Task> lstTask = new List<Task>();
        for(Account acc : lstAccounts) {
            Task newTask = new Task(Subject = 'Negotiations with' + acc.Name,
                    WhatId = acc.Id, Is_Synced__c = false);
            lstTask.add(newTask);
        }
        insert lstTask;
    }
    @Future
    public static void billingAddressChanged(String strOldAccountIds, String strAccountIds) {
        Map<Id, Account> oldMap = (Map<Id, Account>) JSON.deserialize(strOldAccountIds, Map<Id, Account>.class);
        Map<Id, Account> newMap = (Map<Id, Account>) JSON.deserialize(strAccountIds, Map<Id, Account>.class);
        Set<Id> IdsOfChangedAccount = new Set<Id>();
        for (Account acc : newMap.values()) {
            Account oldAcc = oldMap.get(acc.Id);
            if (oldAcc.BillingCity != acc.BillingCity
                    || oldAcc.BillingCountry != acc.BillingCountry
                    || oldAcc.BillingState != acc.BillingState
                    || oldAcc.BillingStreet != acc.BillingStreet
                    || oldAcc.BillingPostalCode != acc.BillingPostalCode) {
                IdsOfChangedAccount.add(acc.Id);
            }
        }
        List<Contact> lstRelatedContacts = [SELECT Id FROM Contact
        WHERE Contact.AccountId IN :IdsOfChangedAccount];
        for (Contact c : lstRelatedContacts) {
            c.Is_Synced__c = false;
            c.Processed_By_Future__c = true;
        }
        if (!lstRelatedContacts.isEmpty()) {
            update lstRelatedContacts;
        }
    }
    public static void queueableBillingAddressChanged (Map<Id, Account> oldMapAccount, Map<Id, Account> newMapAccount){
        Id JobId = System.enqueueJob(new AccountQueueableHelper(oldMapAccount, newMapAccount));
    }
    public static void batchTask () {
        Database.executeBatch(new TasksBatchHandler(), 200);
    }
    public static void batchContact () {
        Database.executeBatch(new ContactBatchHandler(), 200);
    }
}