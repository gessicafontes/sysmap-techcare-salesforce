public with sharing class CaseRequestTriggerHandler extends TriggerHandler {
    public override void afterUpdate() {
        List<Case_Request__c> closedCases = new List<Case_Request__c>();

        for (Case_Request__c cs : (List<Case_Request__c>) Trigger.new) {
            Case_Request__c oldCs = (Case_Request__c) Trigger.oldMap.get(cs.Id);

            if (cs.Status__c == 'Closed' 
                && oldCs.Status__c != 'Closed') {
                
                closedCases.add(cs);
            }
        }

        if (!closedCases.isEmpty()) {
            CaseHistoryUtility.createCaseHistories(closedCases);
            CaseRequestUtility.updateClosureTime(closedCases);
        }
    }
}