public class ContactSearch {
    public static List<Contact> searchForContacts(String first, String second) {
        List<Contact> cts = [SELECT ID, Name FROM Contact 
                 WHERE MailingPostalCode  = :second AND LastName= :first]; 
        return cts;
    }
}