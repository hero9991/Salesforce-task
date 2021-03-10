@isTest
public class AccountProcessorTest {
    @isTest(SeeAllData=true) static void testCountOfContacts() {
        Account testOne = [SELECT id FROM Account WHERE Name = 'test Sales Admin' LIMIT 1];
        Account testTwo = [SELECT id FROM Account WHERE Name = 'Smith Enterprises' LIMIT 1];
        List<id> testIds = new List<id> {testTwo.Id, testOne.Id};        
        Test.startTest();
            AccountProcessor.countContacts(testIds);
        Test.stopTest();    
        
        List<Account> testItems = [SELECT Number_of_Contacts__c, Name FROM Account WHERE id IN :testIds];
        System.assertEquals( testItems[0].Name, 'Smith Enterprises');
        System.assertEquals( testItems[1].Number_of_Contacts__c, 0);
    }
}