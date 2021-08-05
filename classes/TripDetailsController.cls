public inherited sharing class TripDetailsController {
    
    @AuraEnabled(Cacheable=true)
    public static Weather_Daily_Forecast__c getCurrentTemperature(Id spacePointId) {
        if (spacePointId == null) {
            throw new AuraHandledException(Constants.COMMUNITY_ERROR_MSG_GENERAL);
        }

        Set<Id> ids = new Set<Id>{ spacePointId };
        Weather_Daily_Forecast__c weatherForToday = WeatherForecastManager.getBySpacePointIdForToday(ids)[0];
        return weatherForToday;
    }

    @AuraEnabled
    public static void createFlights(Id tripId, List<Id> touristsId) {
        if (tripId == null || touristsId.isEmpty()) {
            throw new AuraHandledException(Constants.COMMUNITY_ERROR_MSG_GENERAL);
        }

        try {
            TripService.assignTourists(
                tripId,
                new Set<Id>(touristsId),
                Constants.OBJECT_FIELD_VALUE_FLIGHT_STATUS_REQUESTED
            );
        } catch (Exception ex) {
            throw new AuraHandledException(Constants.COMMUNITY_ERROR_MSG_GENERAL);
        }
    }
}
