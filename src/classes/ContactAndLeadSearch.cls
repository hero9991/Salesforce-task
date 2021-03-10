public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String text) {
        List<List<SObject>> some = [FIND 'Smith' IN ALL FIELDS 
            RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];
        return some;
    }
}