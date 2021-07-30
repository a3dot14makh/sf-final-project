public with sharing class LeadTriggerHandler {
    public static Boolean wasExecuted = false;

    public static void onAfterUpdate(Map<Id, Lead> newMap) {
        Set<Id> convertedContactIds = new Set<Id>();

        for (Lead lead : newMap.values()) {
            if (lead.convertedContactId != null) {
                convertedContactIds.add(lead.convertedContactId);
            }
        }

        List<Contact> contacts = ContactManager.getById(convertedContactIds);
        TouristService.createTouristsByContacts(contacts);

        List<Tourist__c> tourists = TouristManager.getByContactId(convertedContactIds);
        TouristService.sendEmailTemplate(tourists);
    }
}
