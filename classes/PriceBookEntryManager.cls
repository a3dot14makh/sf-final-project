public with sharing class PriceBookEntryManager {
    
    public static List<PriceBookEntry> getByName(Set<String> names) {
        if (names == null || names.isEmpty()) {
            return new List<PriceBookEntry>();
        }
        return [
            SELECT Name, 
            UnitPrice 
            FROM PriceBookEntry 
            WHERE Name IN :names 
            ORDER BY Name
        ];
    }
}
