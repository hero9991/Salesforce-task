@isTest
public class TestRestrictContactByName {
    @isTest static void testRestriction() {
        Contact c = new Contact(FirstName = 'some', LastName = 'INVALIDNAME');
        Contact c1 = new Contact(FirstName = 'some', LastName = 'Petrov');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Database.SaveResult result1 = Database.insert(c1, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result1.isSuccess());
    }
}