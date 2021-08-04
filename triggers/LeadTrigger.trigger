trigger LeadTrigger on Lead(after update) {
    if (!LeadTriggerHandler.wasExecuted) {
        LeadTriggerHandler.wasExecuted = true;

        switch on Trigger.operationType {
            when AFTER_UPDATE {
                LeadTriggerHandler.onAfterUpdate(Trigger.oldMap, Trigger.newMap);
            }
        }
    }
}
