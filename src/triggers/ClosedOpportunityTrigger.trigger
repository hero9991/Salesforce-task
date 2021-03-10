trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    Task [] arr = new List<Task>();
    for (Opportunity a : Trigger.New) {
        if (a.StageName == 'Closed Won') {
            Task t = new Task (subject = 'Follow Up Test Task', WhatId = a.Id);
            arr.add(t);
        }
    }
    if (arr.size() > 0){
    	insert arr;
    }
    
}