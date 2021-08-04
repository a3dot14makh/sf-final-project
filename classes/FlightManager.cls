public class FlightManager {

    public static List<Flight__c> getById(Set<Id> idSet) {
        return [
            SELECT Tourist__r.Age__c, 
            Trip__r.Start_Date__c, 
            Trip__r.Minimum_Age__c
            FROM Flight__c
            WHERE ID IN :idSet
        ];
    }
}