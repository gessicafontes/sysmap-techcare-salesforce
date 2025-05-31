public with sharing class CaseRequestUtility {
    public static void updateClosureTime(List<Case_Request__c> caseList) {
        List<Case_Request__c> toUpdate = new List<Case_Request__c>();

        for (Case_Request__c cs : caseList) {
            if (cs.CreatedDate != null && cs.ClosedDateTime__c != null) {
                Time duration = DateTimeUtility.getTimeDifference(cs.CreatedDate, cs.ClosedDateTime__c);
                toUpdate.add(new Case_Request__c(
                    Id = cs.Id,
                    Resolution_time__c = duration
                ));
            }
        }

        if (!toUpdate.isEmpty()) {
            update toUpdate;
        }
    }
}