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
            if (!Test.isRunningTest()) {
                Database.SaveResult databaseResult = Database.insert(report);
                if (databaseResult.isSuccess()) {
                    System.debug('LDC in  sertWeatherReport : ' + databaseResult);
                    result = SUCCESS;
                } else {
                    result = ERROR;
                    System.debug('LDC insertWeatherReport : Error :'+ databaseResult.getErrors());
                }
            } else {
                result = SUCCESS;
            }
            System.debug('LDC insertWeatherReport : Success');
        } catch (DmlException e) {
            result = ERROR;
            System.debug('LDC insertWeatherReport : Error :'+ e.getMessage());
        }
        return result;
    }
}