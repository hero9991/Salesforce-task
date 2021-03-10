/**
 * Created by a000 on 10.03.2021.
 */

public with sharing class AccountQueueableHelper implements Queueable{
    List<Account> lstOldAccount;
    List<Account> lstAccount;
    AccountQueueableHelper(List<Account> lstOldAccount, List<Account> lstAccount) {
        this.lstOldAccount = lstOldAccount;
        this.lstAccount = lstAccount;
    }
    public void execute(System.QueueableContext context) {
        Set<Id> IdsOfChangedAccount = new Set<Id>();
        for (Account oldAcc : lstOldAccount) {
            for (Account acc : lstAccount) {
                if (oldAcc.Id == acc.Id && oldAcc.BillingAddress != acc.BillingAddress) {
                    IdsOfChangedAccount.add(acc.Id);
                }
            }
        }
        List<Contact> lstRelatedContacts = [SELECT Id FROM Contact
        WHERE Contact.AccountId IN :IdsOfChangedAccount];
        for (Contact c : lstRelatedContacts) {
            c.Is_Synced__c = false;
            c.Processed_By_Queue__c = true;
        }
        update lstRelatedContacts;
    }
}