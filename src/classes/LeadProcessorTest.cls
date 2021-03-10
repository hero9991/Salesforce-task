@isTest
public class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> Leads = new List<Lead>();
       
        for (Integer i=0; i < 200; i++) {
            Leads.add(new Lead(LastName='test '+i, company = 'some'));
        }
        
        insert Leads;
    }
    
    @isTest static void test() {
        Test.startTest();
		LeadProcessor sample = new LeadProcessor();
        Id batchId = Database.executeBatch(sample, 200);
        Test.stopTest();
        for (Lead it : [SELECT LeadSource From Lead]){
        	System.assertEquals('Dreamforce', it.LeadSource);
        }
    }
}