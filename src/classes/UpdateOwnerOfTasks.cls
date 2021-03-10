/**
 * Created by a000 on 04.03.2021.
 */
public with sharing class UpdateOwnerOfTasks {
    @InvocableMethod
    public static void createTask(List<Account> lstAccounts) {
        Set<Id> lstAccountsIds = new Set<Id>();
        for (Account acc : lstAccounts){
            lstAccountsIds.add(acc.Id);
        }
        List<Task> lstTask = [SELECT OwnerId, WhatId FROM Task WHERE WhatId IN :lstAccountsIds];
        List<Task> lstUpdatedTask = new List<Task>();
        User activeUser = [SELECT Id FROM User WHERE IsActive = :true LIMIT 1];
        for(Account acc : lstAccounts) {
            List<Task> chunkTasks = new List<Task>();
            for (Task taskItem : lstTask) {
                if (taskItem.WhatId == acc.Id) {
                    chunkTasks.add(taskItem);
                }
            }
            if (chunkTasks.size() > 3) {
                for (Task taskItem : chunkTasks) {
                    lstUpdatedTask.add(new Task(Id = taskItem.Id, OwnerId = activeUser.Id));
                }
            }
        }
        update lstUpdatedTask;
    }
}