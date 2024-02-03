/**
 * @description: this class is exposed to the LWC lDC_NewWeatherReportComponent to retreive weather data for a User, an Account or by City
 * @author: Laurent Dibo-Cohen
 * @created: 2024-01-30
 * @version: 1.0.0
 * @param: recordApiName: the API name of the record to retreive weather data for (User, Account or City)
 * @param: idOrLatLngOrCity: the Id of the Account, the User current position or the City to retreive weather data for
 * @return: LDC_WRP001_WeatherPayload: the weather data for the record formatted as a LDC_WRP001_WeatherPayload object
 */

public with sharing class LDC_WeatherServiceController {
    private static final String ACCOUNT = 'Account';
    private static final String CONTACT = 'Contact';
    private static final String USER = 'User';
    private static final String CITY = 'City';
    private static final String SUCCESS = 'Success';
    private static final String ERROR = 'Error';

    @AuraEnabled(Cacheable=true)
    public static LDC_WRP001_WeatherReport getWeatherResponse(String objectType, String parameterValue) {
        System.debug('LDC In getWeatherResponse for objectType: ' + objectType +' and parameterValue: ' + parameterValue);
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        Decimal lat;
        Decimal lng;
        if(objectType == USER) {
            lat = decimal.valueOf(parameterValue.split(',')[0]);
            lng = decimal.valueOf(parameterValue.split(',')[1]);
            
        } else if(objectType == CITY){
            LDC_LocationService locationService = new LDC_LocationService(parameterValue);
            lat = locationService.getLat();
            lng = locationService.getLng();
        }
        else {
            LDC_LocationService locationService = new LDC_LocationService((Id) parameterValue);
            lat = locationService.getLat();
            lng = locationService.getLng();
        }
        if (Test.isRunningTest()) {
            report = LDC_TestDataFactory.createTestWrapper();
        } else {
            report = LDC_Weather_WebService.getWeatherResponse(String.valueOf(lat), String.valueOf(lng));
        }
        return report;
    }

    @AuraEnabled
    public static String saveWeatherReport(LDC_WRP001_WeatherReport weatherReport) {
        System.debug('LDC weatherReport in saveWeatherReport: '+ weatherReport);
        
        String result;
        try {
            if (Test.isRunningTest()) {
                result = SUCCESS;
            } else {
                result = LDC_WeaterReportService.insertWeatherReport(weatherReport);
            }
        } catch (Exception e) {
            result = ERROR;
            throw new AuraHandledException(e.getMessage());
        }
        return result;
    }
}