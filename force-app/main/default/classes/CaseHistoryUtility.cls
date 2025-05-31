public with sharing class CaseHistoryUtility {
    public static void createCaseHistories(List<Case_Request__c> caseList) {
        Map<String, String> planTypeToRecordTypeId = PlanTypeService.getPlanTypeToRecordTypeIdMap();
        List<Case_History__c> historiesToInsert = new List<Case_History__c>();

        for (Case_Request__c cs : caseList) {
            Datetime closedDate = Datetime.now();
            Boolean slaMet;


            if (cs.RecordTypeId != null) {
                slaMet = SLAService.verifySLA(cs.CreatedDate, cs.ClosedDateTime__c, cs.RecordTypeId, planTypeToRecordTypeId);
            } else {
                slaMet = false;
            }

            Case_History__c history = new Case_History__c(
                Case__c = cs.Id,
                Time_Closed__c = DateTimeUtility.getTimeDifference(cs.createdDate, cs.ClosedDateTime__c),
                SLA_Met__c = slaMet
            );
            historiesToInsert.add(history);
        }

        if (!historiesToInsert.isEmpty()) {
            insert historiesToInsert;
        }
    }
}