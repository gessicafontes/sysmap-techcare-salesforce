public with sharing class SLAService {
    public static Boolean verifySLA(DateTime createdDate, Datetime closedDate, Id caseRecordTypeId, Map<String, String> planTypeToRecordTypeId) { // criar classe
        if (createdDate == null || caseRecordTypeId == null) return false;

        Long diffMinutes = DateTimeUtility.getMinutesDifference(createdDate, closedDate);

        Integer slaStandard = 1440; // 24 horas
        Integer slaPremium = 480; // 8 horas

        String standardId = planTypeToRecordTypeId.get('STANDARD');
        String premiumId = planTypeToRecordTypeId.get('PREMIUM');

        if (standardId != null && caseRecordTypeId == standardId) {
            return diffMinutes <= slaStandard;
        } else if (premiumId != null && caseRecordTypeId == premiumId) {
            return diffMinutes <= slaPremium;
        }

        return false;
    }
}