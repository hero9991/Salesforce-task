/**
 * Created by a000 on 15.03.2021.
 */

public with sharing class ContactBatchHandlerLocator implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT AccountId FROM Contact WHERE Is_Synced__c = false');
    }
    public void execute(Database.BatchableContext BC, List<Contact> lstContact){
        Set<Id> setAccountIds = new Set<Id>();
        for (Contact c : lstContact) {
            setAccountIds.add(c.AccountId);
        }
        List<Account> lstAccount = [SELECT BillingCity, BillingCountry, BillingState,
                BillingPostalCode, BillingStreet FROM Account WHERE Id IN :setAccountIds];
        for (Account acc : lstAccount) {
            acc.Updated_By_Contact__c = true;
        }
        Map<Id, Account> mapAccount = new Map<Id, Account>(lstAccount);
        for (Contact c : lstContact) {
            if (mapAccount.get(c.AccountId) != null) {
                c.MailingCity = mapAccount.get(c.AccountId).BillingCity;
                c.MailingCountry = mapAccount.get(c.AccountId).BillingCountry;
                c.MailingState = mapAccount.get(c.AccountId).BillingState;
                c.MailingPostalCode = mapAccount.get(c.AccountId).BillingPostalCode;
                c.MailingStreet = mapAccount.get(c.AccountId).BillingStreet;
            }
            c.Is_Synced__c = true;
        }
        if (!lstContact.isEmpty()) {
            update lstContact;
            update lstAccount;
        }
    }
    public void finish(Database.BatchableContext BC){
        System.debug('done');
    }
}