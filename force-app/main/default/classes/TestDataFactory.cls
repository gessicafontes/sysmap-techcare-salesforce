public with sharing class TestDataFactory {
    public static List<Case_Request__c> createRequestCases(Integer numRequestCases) {
        List<Case_Request__c> requestCases = new List<Case_Request__c>();

        List<Account> accounts = createAccounts(1);
        List<Contact> contacts = createContacts(1);

        insert accounts;
        insert contacts;

        for (Integer i = 0; i < numRequestCases; i++) {
            Case_Request__c requestCase = new Case_Request__c(
                Priority__c = 'Low', 
                Status__c = 'New', 
                Subject__c = 'Test Case Request' + i, 
                Description__c = 'Test Case Request Description' + i,
                Account__c = accounts[0].Id,
                Contact__c = contacts[0].Id,
                CaseOrigin__c = 'Telefone',
                Type__c = 'Suporte Técnico',
                Product__c = 'Notebook',
                Case_Reason__c = 'Erro de Sistema'
            );

            requestCases.add(requestCase);
        }

        return requestCases;
    }

    public static List<Account> createAccounts(Integer numAccounts) {
        List<Account> accounts = new List<Account>();

        for (Integer i = 0; i < numAccounts; i++) {
            Account acct = new Account(
                Name = 'Test Account' + i, 
                BillingCity = 'Test City',
                BillingCountry = 'Brazil',
                BillingStreet = 'Test Street',
                BillingPostalCode = '123456',
                Phone = '12345678'
            );

            accounts.add(acct);
        }

        return accounts;
    }

    public static List<Contact> createContacts(Integer numContacts) {
        List<Contact> contacts = new List<Contact>();

        for (Integer i = 0; i < numContacts; i++) {
            Contact contact = new Contact(
                FirstName = 'Test',
                LastName = 'Contact ' + i,
                Email = 'testcontact' + i + '@email.com'
            );

            contacts.add(contact);
        }

        return contacts;
    }
}