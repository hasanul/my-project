public class AccountTriggerHandler {
    
    public static void updateContactState(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        // Create a list to hold contacts that need to be updated
        List<Contact> contactsToUpdate = new List<Contact>();

        // Iterate through the list of updated accounts
        for (Account acc : newAccounts) {
            // Check if BillingState has changed by comparing with the old map
            if (acc.BillingState != oldAccountMap.get(acc.Id).BillingState) {
                // Query related contacts for this account
                List<Contact> relatedContacts = [SELECT Id, Account_State__c FROM Contact WHERE AccountId = :acc.Id];
                
                // Update the Account_State__c field for each related contact
                for (Contact con : relatedContacts) {
                    con.Account_State__c = acc.BillingState;
                    contactsToUpdate.add(con);
                }
            }
        }
        
        // Update the related contacts only if changes exist
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}
