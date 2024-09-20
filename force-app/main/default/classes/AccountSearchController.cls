public with sharing class AccountSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchTerm) {
        if (String.isBlank(searchTerm)) {
            return new List<Account>();
        }
        
        searchTerm = '%' + searchTerm + '%'; // for a LIKE query
        
        return [
            SELECT Id, Name FROM Account 
            WHERE Name LIKE :searchTerm 
            LIMIT 10
        ];
    }
}
