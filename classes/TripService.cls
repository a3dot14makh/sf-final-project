public without sharing class TripService {

    public static void assignTourists(Id tripId, Set<Id> touristsId, String status) {
        List<Flight__c> flights = new List<Flight__c>();

        for (Id idTourist : touristsId) {
            Flight__c flight = new Flight__c(Tourist__c = idTourist, Trip__c = tripId, Status__c = status);
            flights.add(flight);
        }
        insert flights;
    }
}