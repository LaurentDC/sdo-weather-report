/**
 * @author Laurent Dibo-Cohen
 * @version 1.0
 * @date 2024-02-09
 * @description : This class is used to manage the weather report persistence in Salesforce.
 * @return : Success or Error
 */
public with sharing class LDC_WeaterReportService {
    private static final String PREFIX = 'WR';
    private static final String SUCCESS = 'Success';
    private static final String ERROR = 'ERROR';
    
    public static String insertWeatherReport(LDC_WRP001_WeatherReport weatherReport) {
        String result = null;
        LDC_Weather_Report__c report = new LDC_Weather_Report__c();
        if (weatherReport.recordType != null) {
            if (weatherReport.recordType == 'User') {
                report.LDC_Weather_User__c = (Id) weatherReport.recordId;
            } else {
                report.LDC_Weather_Account__c = (Id) weatherReport.recordId;
            }
        }
        if (weatherReport.humidity != null) {
            report.LDC_Humidity__c = weatherReport.humidity;
        }
        if (weatherReport.temperature != null) {
            report.LDC_Temperature__c = weatherReport.temperature;
        }
        if (weatherReport.windSpeed != null) {
            report.LDC_Wind_Speed__c = weatherReport.windSpeed;   
        }    
        if (weatherReport.latitude != null) {
            report.LDC_Location_Report__Latitude__s = weatherReport.latitude;
        }
        if (weatherReport.longitude != null) {
            report.LDC_Location_Report__Longitude__s = weatherReport.longitude;
        }
        if (weatherReport.weatherConditionLabel!= null) {
            report.LDC_Weather_Condition__c = weatherReport.weatherConditionLabel ;
        }
        report.Name = PREFIX + '_' + System.currentTimeMillis();
        System.debug('LDC insertWeatherReport : ' + report);
        try {
            insert report;
            System.debug('LDC insertWeatherReport : Success');
        } catch (DmlException e) {
            result = ERROR;
            // Create log object
            Map<String, String> logError = new Map<String, String>();
            logError.put('function', 'LDC_WeaterReportService.insertWeatherReport');
            logError.put('message', e.getMessage());
            LDC_LogObjectService logger = new LDC_LogObjectService();
            logger.insertLogObject(logError);
            System.debug('LDC insertWeatherReport : Error :'+ e.getMessage());
        }
        return result;
    }
}