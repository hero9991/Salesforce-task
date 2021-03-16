/*
 * Created by a000 on 10.03.2021.
 */

public with sharing class AccountQueueableHelper implements Queueable{
    Map<Id, Account> oldMapAccount;
    Map<Id, Account> newMapAccount;
    public AccountQueueableHelper(Map<Id, Account> oldMapAccount, Map<Id, Account> newMapAccount) {
        this.oldMapAccount = oldMapAccount;
        this.newMapAccount = newMapAccount;
    }
    public void execute(System.QueueableContext context) {
        Set<Id> IdsOfChangedAccount = new Set<Id>();
        for (Account acc : newMapAccount.values()) {
            Account oldAcc = oldMapAccount.get(acc.Id);
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
            c.Processed_By_Queue__c = true;
        }
        if (!lstRelatedContacts.isEmpty()){
            update lstRelatedContacts;
        }
    }
}