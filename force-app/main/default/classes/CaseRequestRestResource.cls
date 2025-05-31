@RestResource(urlMapping='/CaseRequest/*')
global with sharing class CaseRequestRestResource {

    global class CaseResponse {
        public Id caseId;
        public String status;
        public Boolean slaMet;
    }

    @HttpGet
    global static List<CaseResponse> getCaseRequest() {
        String caseId = RestContext.request.requestURI.substringAfter('/CaseRequest/');

        Case_Request__c caseRequest = [
            SELECT Id, Status__c, CreatedDate, ClosedDateTime__c, RecordTypeId 
            FROM Case_Request__c 
            WHERE Id = :caseId
            LIMIT 1
        ];

        Boolean slaMet = SLAService.verifySLA(
            caseRequest.CreatedDate, 
            caseRequest.ClosedDateTime__c, 
            caseRequest.RecordTypeId, 
            PlanTypeService.getPlanTypeToRecordTypeIdMap()
        );

        CaseResponse response = new CaseResponse();
        response.caseId = caseRequest.Id;
        response.status = caseRequest.Status__c;
        response.slaMet = slaMet;

        return new List<CaseResponse>{ response };
    }
}