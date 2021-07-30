public with sharing class ContactManager {

    public static List<Contact> getById(Set<Id> idSet) {
        if (idSet == null || idSet.isEmpty()) {
            return new List<Contact>();
        }
        return [
            SELECT Id, 
            Name, 
            Email, 
            Description 
            FROM Contact 
            WHERE Id IN :idSet
        ];
    }
}
