public class WeatherForecastManager {

    public static List<Weather_Daily_Forecast__c> getAll() {
        return [
            SELECT Name, 
            Space_Point__c 
            FROM Weather_Daily_Forecast__c 
            ORDER BY CreatedDate
        ];
    }

    public static List<Weather_Daily_Forecast__c> getBySpacePointIdForToday(Set<Id> idSet) {
        if (idSet == null || idSet.isEmpty()) {
            return new List<Weather_Daily_Forecast__c>();
        }
        return [
            SELECT Average_Temperature__c
            FROM Weather_Daily_Forecast__c
            WHERE Date__c = TODAY AND Space_Point__c = :idSet
        ];
    }
}
