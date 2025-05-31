trigger CaseRequestTrigger on Case_Request__c (after update) {
    new CaseRequestTriggerHandler().run();
}