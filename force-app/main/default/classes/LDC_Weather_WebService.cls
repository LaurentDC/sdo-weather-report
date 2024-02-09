/**
 * @description: this class is called by the LDC_WRP001_WeatherController class to retreive weather data from the Weather API with latlng
 * @author: Laurent Dibo-Cohen
 * @created: 2024-01-30
 * @version: 1.0.0
 */
public with sharing class LDC_Weather_WebService {
    private static final String STATUS_SUCCESS = 'SUCCESS';
    private static final String STATUS_LIMIT = 'LIMIT_EXCEEDED';
    private static final String STATUS_ERROR = 'ERROR';

    /**
     * @description: this method is called by the LDC_WRP001_WeatherController class to retreive weather data from the Weather API with latlng
     * @author: Laurent Dibo-Cohen
     * @created: 2024-01-30
     * @version: 1.0.0
     * @param lat : the latitude of the location
     * @param lng : the longitude of the location
     * @return: LDC_WRP001_WeatherPayload: the weather data for the record formatted as a LDC_WRP001_WeatherPayload object
     */

    public static LDC_WRP001_WeatherReport getWeatherResponse(String lat, String lng) {

        LDC_WRP001_WeatherReport wrapper = new LDC_WRP001_WeatherReport();
        LDC_Weather_Settings__c ws = LDC_Weather_Settings__c.getOrgDefaults();

        String host = ws.host__c;
        String endpoint = ws.endpoint__c;
        String username = ws.username__c;

        String fullPath = host + '/' + endpoint + '?lat=' + lat + '&lng=' + lng + '&username=' + username;
        System.debug('LDC fullPath:'+ fullPath);
        Map<String,Object> result = new Map<String,Object>();
        try {
            if (!Test.isRunningTest()) {
                LDC_Http_Callout getWeather = LDC_Weather_Http_Callout.getInstance();
                result = (Map<String,Object>)getWeather.sendItem(
                    '', 
                    'GET',
                    fullPath,
                    new Map<String, String>{
                        'Content-Type' => 'application/json'
                    }
                );
            } else {
                LDC_HttpResponseMock mockResponse = new LDC_HttpResponseMock();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(fullPath);
                HttpResponse response = mockResponse.respond(request);
                if (lng == '123') {
                    result = null;
                } else {
                    result = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
                }
                
            }

            System.debug('LDC result:'+ result);
            Map<String,String> payload = new Map<String,String>();
            if (result.containsKey('weatherObservation')) {
                Map<String, Object> weatherObservation = (Map<String,Object>)result.get('weatherObservation');
                wrapper.temperature = Double.valueOf(weatherObservation.get('temperature'));
                wrapper.humidity = Double.valueOf(weatherObservation.get('humidity'));
                wrapper.windSpeed = Double.valueOf(weatherObservation.get('windSpeed'));
                wrapper.weatherConditionLabel = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionLabel');
                wrapper.conditionIconUrl = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionIcon');
                wrapper.conditionKey = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionKey');
                wrapper.status = STATUS_SUCCESS;
            }
        } catch (Exception e) {
            // LDC : Send error to LWC component
            wrapper.status = STATUS_ERROR;
            wrapper.message = e.getMessage();
            // Create log object
            Map<String, String> logError = new Map<String, String>();
            logError.put('function', 'LDC_Weather_WebService.getWeatherResponse');
            logError.put('message', e.getMessage());
            LDC_LogObjectService logger = new LDC_LogObjectService();
            logger.insertLogObject(logError);
            System.debug('LDC wrapper ERROR : ' + wrapper);
            if (!Test.isRunningTest()) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        return wrapper;
    }
}