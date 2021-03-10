public class LeadProcessor implements Database.Batchable<sObject>{
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT LeadSource FROM Lead'
        );
    }
    public void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> lstLead = new List<Lead>();
        for (Lead item : records) {
            item.LeadSource = 'Dreamforce';
            lstLead.add(item);
        }
        update lstLead;
    }
    public void finish(Database.BatchableContext bc){
        
    }
}