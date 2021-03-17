/**
 * Created by a000 on 16.03.2021.
 */

public with sharing class ScheduleContactBatches implements Schedulable{
    public void execute (SchedulableContext context) {
        Database.executeBatch(new ContactBatchHandlerLocator(), 200);
        Database.executeBatch(new ContactBatchHandler(), 200);
    }
}