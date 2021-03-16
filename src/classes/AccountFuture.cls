/**
 * Created by a000 on 15.03.2021.
 */

public with sharing class AccountFuture {
    @Future
    public static void futureMethod () {
        List<Account> lstAccount = [SELECT BillingCity, BillingCountry, BillingState,
                BillingPostalCode, BillingStreet, (SELECT Is_Synced__c FROM Contacts) FROM Account WHERE
                BillingStreet != NULL OR BillingPostalCode != NULL OR BillingState != NULL
                OR BillingCountry != NULL OR BillingCity != NULL LIMIT 150];
        for(Account acc : lstAccount) {
            if(!acc.Contacts.isEmpty()) {
                List<Contact> lstContact = acc.Contacts;
                for(Contact c : lstContact) {
                    c.Is_Synced__c = false;
                    c.Processed_By_Future__c = true;
                }
                update lstContact;
            }
        }
    }
}