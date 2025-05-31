@isTest
private class CaseHistoryUtility_Test {

    @isTest
    static void testCreatingHistoryCase() {
        Test.startTest();
        List<Case_Request__c> casesRequest = TestDataFactory.createRequestCases(1);
        insert casesRequest;

        casesRequest[0].Resolution_Notes__c = 'Testando';
        casesRequest[0].Status__c = 'Closed';
        update casesRequest;

        Test.stopTest();

        Case_Request__c caseRequest = [
            SELECT Id,
                (SELECT Id, Case__c, SLA_Met__c, Time_Closed__c FROM Case_History__r) 
            FROM Case_Request__c 
            WHERE Id = :casesRequest[0].Id
        ];

        Assert.areEqual(1, caseRequest.Case_History__r.size(), 'Should have found a new case history');

        for (Case_History__c hist : caseRequest.Case_History__r) {
            Assert.areEqual(casesRequest[0].Id, hist.Case__c, 'Case History isnt linked to the case');
            Assert.areEqual(true, hist.SLA_Met__c, 'SLA met not true');
            Assert.areNotEqual(null, hist.Time_Closed__c, 'Time closed should not be null');
        }
    }
}