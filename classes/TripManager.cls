public with sharing class TripManager {
    public static List<Trip__c> getById(Set<Id> idSet) {
        if (idSet == null || idSet.isEmpty()) {
            return new List<Trip__c>();
        }
        return [
            SELECT Id, 
            Start_Date__c, 
            Minimum_Age__c 
            FROM Trip__c 
            WHERE Id IN :idSet
        ];
    }

    public static List<Trip__c> getTrip() {
        return [
            SELECT
                Id,
                Name,
                Start_Date__c,
                End_Date__c,
                Minimum_Age__c,
                Number_Employed_Seats__c,
                Seats__c,
                Departure_Space_Point__r.City__c
            FROM Trip__c
            ORDER BY Name ASC
        ];
    }
}
