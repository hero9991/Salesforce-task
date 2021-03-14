/**
 * Created by a000 on 15.03.2021.
 */

public with sharing class ContactBatchHandler  implements Database.Batchable<SObject>{
    public final Account acc;
    public ContactBatchHandler(Account acc){
        this.acc = acc;
    }
    public Iterable<SObject> start(Database.BatchableContext BC){
        List<Contact> lstContact = [SELECT Id FROM Contact WHERE Is_Synced__c = FALSE];
        return lstContact;
    }
    public void execute(Database.BatchableContext BC, List<Contact> lstContact){
        for (Contact c : lstContact) {
            c.MailingCity = acc.BillingCity;
            c.MailingCountry = acc.BillingCountry;
            c.MailingState = acc.BillingState;
            c.MailingPostalCode = acc.BillingPostalCode;
            c.MailingStreet = acc.BillingStreet;
            c.Is_Synced__c = true;
        }
        if (!lstContact.isEmpty()) {
            update lstContact;
        }
    }
    public void finish(Database.BatchableContext BC){
        System.debug('done');
    }
}