trigger AccountAddressTrigger on Account (before update) {
    if (Trigger.isBefore) {
        if(Trigger.isUpdate) {
//            String jsonOldMap = JSON.serialize(Trigger.oldMap);
//            String jsonNewMap = JSON.serialize(Trigger.newMap);
//            AccountTriggerHandler.billingAddressChanged(jsonOldMap, jsonNewMap);

//            AccountTriggerHandler.queueableBillingAddressChanged(Trigger.oldMap, Trigger.newMap);

//            AccountTriggerHandler.batchTask(Trigger.new[0]);

            AccountTriggerHandler.batchContact(Trigger.new[0]);
        }
    }
}