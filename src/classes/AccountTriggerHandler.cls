/**
 * Created by a000 on 10.03.2021.
 */

public with sharing class AccountTriggerHandler {
    @Future
    public static void billingAddressChanged(List<Id> lstOldAccountIds, List<Id> lstAccountIds) {
        List<Account> lstOldAccount = [SELECT Id, BillingAddress FROM Account WHERE Id IN :lstOldAccountIds];
        List<Account> lstAccount = [SELECT Id, BillingAddress FROM Account WHERE Id IN :lstAccountIds];
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
            c.Processed_By_Future__c = true;
        }
        update lstRelatedContacts;
    }
    public static void queueableBillingAddressChanged (List<Account> lstOldAccount, List<Account> lstAccount){
        System.enqueueJob(new AccountQueueableHelper(lstOldAccount, lstAccount));
    }
}