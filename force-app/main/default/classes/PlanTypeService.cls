public with sharing class PlanTypeService {
    public static Map<String, String> getPlanTypeToRecordTypeIdMap() { 
        Map<String, String> mapPlan = new Map<String, String>();

        for (PlanConfig__mdt config : [
            SELECT Plan_Type__c, Record_Type_Id__c FROM PlanConfig__mdt
        ]) {
            mapPlan.put(config.Plan_Type__c, config.Record_Type_Id__c);
        }

        return mapPlan;
    }
}