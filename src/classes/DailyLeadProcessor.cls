public class DailyLeadProcessor implements Schedulable{
	public void execute(SchedulableContext ctx) {
    	List<Lead> lstLead = [SELECT LeadSource FROM Lead WHERE LeadSource = ''];
        List<Lead> lstUpdateLead = new List<Lead>();
        for (Lead l : lstLead) {
            l.LeadSource = 'Dreamforce';
            lstUpdateLead.add(l);
        }
        update lstUpdateLead;
    }
}