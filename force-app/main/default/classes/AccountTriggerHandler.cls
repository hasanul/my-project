<<<<<<< HEAD
/**
 * Handler class for managing Account trigger logic.
 * Developer: Hasanul Banna
 * Description: This class contains the logic to update the Account_State__c field on related Contact records when the BillingState of an Account is changed.
 * Created Date: 2026-04-04
 * Last Modified: 2026-04-04
 */

public with sharing class AccountTriggerHandler {
    public static void updateContactState(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        Set<Id> changedAccountIds = new Set<Id>();
        Map<Id, String> accountIdToState = new Map<Id, String>();

        for (Account acc : newAccounts) {
            if (acc.BillingState != oldAccountMap.get(acc.Id).BillingState) {
                changedAccountIds.add(acc.Id);
                accountIdToState.put(acc.Id, acc.BillingState);
            }
        }

        if (changedAccountIds.isEmpty()) {
            return;
        }

        List<Contact> contactsToUpdate = [
            SELECT Id, AccountId, Account_State__c
            FROM Contact
            WHERE AccountId IN :changedAccountIds
        ];

        for (Contact con : contactsToUpdate) {
            con.Account_State__c = accountIdToState.get(con.AccountId);
        }

=======
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
>>>>>>> 55a90fd6cb1da47832e5eb7f157d5a6755dc8b95
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 55a90fd6cb1da47832e5eb7f157d5a6755dc8b95
