/**
 * Created by a000 on 01.03.2021.
 */
public with sharing class CreateTaskForAccount {
    @InvocableMethod
    public static void createTask(List<Account> lstAccounts) {
        List<Task> lstTask = new List<Task>();
        for(Account acc : lstAccounts) {
            Task newTask = new Task(Subject = 'Negotiations with' + acc.Name,
                    WhatId = acc.Id, Is_Synced__c = false);
            lstTask.add(newTask);
        }
        insert lstTask;
    }
}