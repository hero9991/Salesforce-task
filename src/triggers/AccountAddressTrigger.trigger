trigger AccountAddressTrigger on Account (before update) {
    if (Trigger.isBefore) {
        if(Trigger.isUpdate) {
            if(IsFirst.getIsFirst()) {
                IsFirst.setIsFirst(false);
                String jsonOldMap = JSON.serialize(Trigger.oldMap);
                String jsonNewMap = JSON.serialize(Trigger.newMap);
                AccountTriggerHandler.billingAddressChanged(jsonOldMap, jsonNewMap);

//            AccountTriggerHandler.queueableBillingAddressChanged(Trigger.oldMap, Trigger.newMap);

            }

        }
    }
}