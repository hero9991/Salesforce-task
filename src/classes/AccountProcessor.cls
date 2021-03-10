public class AccountProcessor {
    @future
    public static void countContacts(List<id> accountIds){
        List<Account> ListOfAccounts = [SELECT id, Number_of_Contacts__c, (SELECT id FROM contacts) 
                                  FROM Account WHERE id in :accountIds];
        for (Account acc: ListOfAccounts){
            if(acc.contacts.size() > 0){
                List<contact> ListOfContacts = acc.contacts;
            	acc.Number_of_Contacts__c = ListOfContacts.size();  
            } else acc.Number_of_Contacts__c = 0;
           
        }
        update ListOfAccounts;
    }
}