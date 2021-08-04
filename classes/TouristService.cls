public class TouristService {

    public static Boolean isDuplicate(List<Tourist__c> inputTourists) {
        Set<String> names = new Set<String>();
        Set<Date> birthdays = new Set<Date>();
        Set<String> emails = new Set<String>();
        Set<String> duplicateKeys = new Set<String>();

        for (Tourist__c tourist : inputTourists) {
            names.add(tourist.Name);
            birthdays.add(tourist.Birthday__c);
            emails.add(tourist.Email__c);
        }

        for (Tourist__c tourist : TouristManager.getByNameBirthdayEmail(names, birthdays, emails)) {
            String duplicateKey = tourist.Name + tourist.Birthday__c + tourist.Email__c;
            duplicateKeys.add(duplicateKey);
        }

        for (Tourist__c tourist : inputTourists) {
            String duplicateKey = tourist.Name + tourist.Birthday__c + tourist.Email__c;
            if (duplicateKeys.contains(duplicateKey)) {
                return true;
            }
        }
        return false;
    }

    @future
    public static void markDuplicatesAsync(Set<Id> touristIds) {
        List<Tourist__c> newTouristsList = TouristManager.getById(touristIds);
        //DuplicateKey__c - formula field: Name  + TEXT(Birthday__c) + Email__c
        Set<String> duplicateKeys = new Set<String>();

        for (Tourist__c tourist : newTouristsList) {
            duplicateKeys.add(tourist.DuplicateKey__c);
        }
        Set<String> existingDuplicateKeys = new Set<String>();

        for (Tourist__c tourist : TouristManager.getByDuplicateKeys(duplicateKeys, touristIds)) {
            existingDuplicateKeys.add(tourist.DuplicateKey__c);
        }
        List<Tourist__c> touristToUpdate = new List<Tourist__c>();

        for (Tourist__c tourist : newTouristsList) {
            if (existingDuplicateKeys.contains(tourist.DuplicateKey__c)) {
                tourist.Is_Duplicate__c = true;
                touristToUpdate.add(tourist);
            }
        }
        update touristToUpdate;
    }

    public static void sendEmailTemplate(List<Tourist__c> tourists) {
        for (Tourist__c tourist : tourists) {
            List<String> emailAddress = new List<String>{ tourist.Email__c };

            EmailService.sendEmailTemplate(
                emailAddress,
                Constants.EMAIL_SENDER_DISPLAY_NAME_FOR_TOURIST,
                Constants.EMAIL_TEMPLATE_SUITABLE_TRIPS_LINK,
                tourist.Contact__c,
                tourist.Id
            );
        }
    }

    public static List<Tourist__c> createByLeadsConverted(List<Lead> leads) {
        List<Tourist__c> tourists = new List<Tourist__c>();

        for (Lead lead : leads) {
            if (String.isBlank(lead.Email)) {
                lead.Email.addError(Constants.NEW_TOURIST_BY_LEAD_VALIDATION_ERROR_EMAIL);
            } else if (lead.Birthday_Tourist__c == null) {
                lead.Birthday_Tourist__c.addError(Constants.NEW_TOURIST_BY_LEAD_VALIDATION_ERROR_BIRTHDAY);
            } else {
                Tourist__c tourist = new Tourist__c(
                    Name = lead.LastName,
                    Birthday__c = lead.Birthday_Tourist__c,
                    Email__c = lead.Email,
                    Contact__c = lead.convertedContactId
                );
                tourists.add(tourist);
            }
        }

        if (!tourists.isEmpty()) {
            insert tourists;
        }

        return tourists;
    }
}
