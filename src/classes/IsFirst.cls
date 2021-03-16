/**
 * Created by a000 on 16.03.2021.
 */

public with sharing class IsFirst {
    private static Boolean isFirst = true;
    public static Boolean getIsFirst() {
        return isFirst;
    }
    public static void setIsFirst(Boolean bool) {
        isFirst = bool;
    }
}