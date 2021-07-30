public inherited sharing class TouristAssignmentController {
    
    @AuraEnabled(Cacheable=true)
    public static List<Trip__c> fetchTrips(Id touristId) {
        Set<Id> ids = new Set<Id>{ touristId };
        Tourist__c tourist = TouristManager.getTouristWithFlightsById(ids)[0];

        List<Trip__c> otputTrips = new List<Trip__c>();

        for (Trip__c trip : TripManager.getTrip()) {
            if (validationTrip(tourist, trip)) {
                otputTrips.add(trip);
            }
        }

        return otputTrips;
    }

    private static Boolean validationTrip(Tourist__c tourist, Trip__c trip) {
        Boolean result = true;
        if (
            (tourist.Age__c < trip.Minimum_Age__c) ||
            (trip.Seats__c == trip.Number_Employed_Seats__c) ||
            (System.today() >= trip.Start_Date__c)
        ) {
            result = false;
        }

        if (result) {
            for (Flight__c flight : tourist.Flights__r) {
                if (flight.Trip__c == trip.Id) {
                    result = false;
                } else if (
                    (flight.Trip__r.Start_Date__c >= trip.Start_Date__c &&
                    flight.Trip__r.Start_Date__c <= trip.End_Date__c) ||
                    (flight.Trip__r.End_Date__c >= trip.Start_Date__c &&
                    flight.Trip__r.End_Date__c <= trip.End_Date__c) ||
                    (flight.Trip__r.Start_Date__c <= trip.Start_Date__c &&
                    flight.Trip__r.End_Date__c >= trip.End_Date__c)
                ) {
                    result = false;
                }
            }
        }

        return result;
    }
}
