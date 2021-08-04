public with sharing class LeadTriggerHandler {
    public static Boolean wasExecuted = false;

    public static void onAfterUpdate(Map<Id, Lead> oldMap, Map<Id, Lead> newMap) {
        List<Lead> leadsConverted = new List<Lead>();

        for (Lead lead : newMap.values()) {
            if (lead.IsConverted == true && oldMap.get(lead.Id).IsConverted == false) {
                leadsConverted.add(lead);
            }
        }

        List<Tourist__c> tourists = TouristService.createByLeadsConverted(leadsConverted);

        if (!tourists.isEmpty()) {
            TouristService.sendEmailTemplate(tourists);
        }
    }
}
