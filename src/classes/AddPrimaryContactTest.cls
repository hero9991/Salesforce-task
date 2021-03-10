@isTest
public class AddPrimaryContactTest {
	@testSetup
    static void setup() {
    	List<Account> lstAccount = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            lstAccount.add(new Account(Name = 'testAcc' + i, BillingState = 'NY'));
            lstAccount.add(new Account(Name = 'testAcc' + i, BillingState = 'CA'));
        }
        system.debug(lstAccount.size());
        insert lstAccount;
    }
    static testmethod void testQueueable() {
        AddPrimaryContact instanse = new AddPrimaryContact(new Contact(LastName = 'test'), 'CA');

        Test.startTest();
        System.enqueueJob(instanse);
        Test.stopTest();
        
		Set<Id> lstId = new Set<Id>();
        for(Account acc : [SELECT Id FROM Account WHERE Name LIKE 'testAcc%' AND BillingState = 'CA']) {
			lstId.add(acc.Id);
        }
		List<Contact> lstContact = [SELECT LastName FROM Contact WHERE AccountId IN :lstId];
		
        System.assertEquals(lstContact.size(), 50);


    }
}