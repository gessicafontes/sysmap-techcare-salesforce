@isTest
private class CaseRequestRestResource_Test {

    @isTest
    static void testGetRequestCase() {
        Case_Request__c caseReq = TestDataFactory.createRequestCases(1)[0];
        insert caseReq;

        RestRequest req = new RestRequest();
        req.requestURI = '/CaseRequest/' + caseReq.Id;
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = new RestResponse();

        Test.startTest();
        List<CaseRequestRestResource.CaseResponse> responses = CaseRequestRestResource.getCaseRequest();
        Test.stopTest();
        
        System.assertEquals(1, responses.size(), 'Must return with at least one response');
        System.assertEquals(caseReq.Id, responses[0].caseId, 'ID of the case should be equal the ID insert');
        System.assertEquals(caseReq.Status__c, responses[0].status, 'Status have to be equal the case status');
        System.assertNotEquals(null, responses[0].slaMet, 'SLA cant be null');
    }
}