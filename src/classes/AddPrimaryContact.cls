public class AddPrimaryContact implements Queueable {
    private String abr;
    private Contact cont;
    public AddPrimaryContact(Contact cont, String abr) {
        this.abr = abr;
       	this.cont = cont;
    }
    public void execute(QueueableContext context) {
   		List<Account> lstAccount = [SELECT Name FROM Account WHERE BillingState = :abr LIMIT 200];
		List<Contact> lstContact = new List<Contact>();
        for (Account acc : lstAccount) {
            Contact clonedContact = cont.clone(false, false, false, false);
            clonedContact.AccountId = acc.Id;
            lstContact.add(clonedContact);
        }
        if (lstContact.size() > 0) {
            insert lstContact;
        }
    }
}