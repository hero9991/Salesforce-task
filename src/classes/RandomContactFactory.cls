public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numOfContacts, String lastNameOfContact) {
        List <Contact> c = new List<Contact>();
        for (Integer i = 0; i < numOfContacts; i++) {
			c.add(new Contact(FirstName = 'Test' + i, LastName = lastNameOfContact));         
        }
        return c;
    }
}