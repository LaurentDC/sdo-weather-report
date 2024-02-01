public with sharing class LDC_WeaterReportService {
    private static final String PREFIX = 'WR';
    private static final String SUCCESS = 'Success';
    private static final String ERROR = 'ERROR';
    public static String insertWeatherReport(Map<String,Object> weatherReport) {
        String result = null;
        LDC_Weather_Report__c report = new LDC_Weather_Report__c();
        if (weatherReport.containsKey('userId')) {
            if (weatherReport.get('userId') != null) {
                report.LDC_Weather_User__c = (Id) weatherReport.get('userId');
            }    
        }
        if (weatherReport.containsKey('accountId')) {
            if (weatherReport.get('accountId') != null) {
                report.LDC_Weather_Account__c = (Id) weatherReport.get('accountId');
            }
        }
        if (weatherReport.containsKey('humidity')) {
            if (weatherReport.get('humidity') != null) {
                report.LDC_Humidity__c = Integer.valueOf(weatherReport.get('humidity'));
            }
        }
        if (weatherReport.containsKey('temperature')) {
            if (weatherReport.get('temperature') != null) {
                report.LDC_Temperature__c = Integer.valueOf(weatherReport.get('temperature'));
            }
        }
        if (weatherReport.containsKey('windSpeed')) {
            if (weatherReport.get('windSpeed') != null) {
                report.LDC_Wind_Speed__c = Integer.valueOf(weatherReport.get('windSpeed'));   
            }
        }
        if (weatherReport.containsKey('latitude')) {
            if (weatherReport.get('latitude') != null) {
                report.LDC_Location_Report__Latitude__s = Double.valueOf(weatherReport.get('latitude'));
            }
        }
        if (weatherReport.containsKey('longitude')) {
            if (weatherReport.get('longitude') != null) {
                report.LDC_Location_Report__Longitude__s = Double.valueOf(weatherReport.get('longitude'));
            }
        }
        if (weatherReport.containsKey('weatherConditionLabel')) {
            if (weatherReport.get('weatherConditionLabel') != null) {
                report.LDC_Weather_Condition__c = (String) weatherReport.get('weatherConditionLabel') ;
            }
        }
        report.Name = PREFIX + '_' + System.currentTimeMillis();
        System.debug('LDC insertWeatherReport : ' + report);
        try {
            insert report;
            result = SUCCESS;
            System.debug('LDC insertWeatherReport : Success');
        } catch (DmlException e) {
            result = ERROR;
            System.debug('LDC insertWeatherReport : Error :'+ e.getMessage());
        }
        return result;
    }
}