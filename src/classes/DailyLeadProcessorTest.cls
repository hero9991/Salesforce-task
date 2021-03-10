@isTest
public class DailyLeadProcessorTest {
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        List<Lead> lstLead = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            lstLead.add(new Lead(LastName = 'test' + i, company = 'some'));
        }
        insert lstLead;
        Test.startTest();
        String jobId = System.schedule('Update LeadSource to DreamForce', CRON_EXP, new DailyLeadProcessor());
        
        Test.stopTest(); 
    }
}