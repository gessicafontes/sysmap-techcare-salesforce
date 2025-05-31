public with sharing class DateTimeUtility {
    public static Time getTimeDifference(DateTime startTime, DateTime endTime) {
        if (startTime == null || endTime == null) return null;

        Long millis = endTime.getTime() - startTime.getTime();
        Integer totalSeconds = (Integer)(millis / 1000);

        Integer hours = totalSeconds / 3600;
        Integer minutes = Math.mod(totalSeconds, 3600) / 60;
        Integer seconds = Math.mod(totalSeconds, 60);

        return Time.newInstance(hours, minutes, seconds, 0);
    }

    public static Integer getMinutesDifference(DateTime startTime, DateTime endTime) {
        if (startTime == null || endTime == null) return null;
        
        Long diffMillis = endTime.getTime() - startTime.getTime();
        Integer diffMinutes = (diffMillis / (60 * 1000)).intValue();
        return diffMinutes;
    }


}