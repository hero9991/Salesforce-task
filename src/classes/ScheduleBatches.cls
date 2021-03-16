/**
 * Created by a000 on 15.03.2021.
 */

public with sharing class ScheduleBatches implements Schedulable {
    public void execute (SchedulableContext context) {
        Database.executeBatch(new TasksBatchHandler(), 200);
        Database.executeBatch(new ContactBatchHandler(), 200);
    }
}