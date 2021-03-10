public class StringArrayTest {
    public static List<String> generateStringArray (Integer numberOfTest){
        List<String> outString = new List<String>();
        for (Integer i = 0; i < numberOfTest; i++){
            String x = i + '';
            outString.add('Test ' + x);
        }
        return outString;
    }
}