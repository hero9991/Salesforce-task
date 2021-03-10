public class AccountHandler {
    public static Account insertNewAccount(String text){
    	Account acc= new Account();
        acc.Name = text;
        try
        {
            insert acc;
            return acc;
        }
        catch(Exception ee)
        {
            return null;
        }
    }
}