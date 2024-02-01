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

    public static LDC_WRP001_WeatherPayload getWeatherResponse(String lat, String lng) {

        LDC_WRP001_WeatherPayload wrapper = new LDC_WRP001_WeatherPayload();
        LDC_Weather_Settings__c ws = LDC_Weather_Settings__c.getOrgDefaults();
        String host = ws.host__c;
        String endpoint = ws.endpoint__c;
        String username = ws.username__c;
        String fullPath = host + '/' + endpoint + '?lat=' + lat + '&lng=' + lng + '&username=' + username;
        try {
            LDC_Http_Callout getWeather = LDC_Weather_Http_Callout.getInstance();
            Map<String,Object> result = (Map<String,Object>)getWeather.sendItem(
                '', 
                'GET',
                fullPath,
                new Map<String, String>{
                    'Content-Type' => 'application/json'
                }
            );
            System.debug('LDC result:'+ result);
            Map<String,String> payload = new Map<String,String>();
            if (result.containsKey('weatherObservation')) {
                Map<String, Object> weatherObservation = (Map<String,Object>)result.get('weatherObservation');
                wrapper.temperature = String.valueOf(weatherObservation.get('temperature'));
                wrapper.humidity = String.valueOf(weatherObservation.get('humidity'));
                wrapper.windSpeed = String.valueOf(weatherObservation.get('windSpeed'));
                wrapper.weatherConditionLabel = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionLabel');
                wrapper.conditionIconUrl = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionIcon');
                wrapper.conditionKey = LDC_WeatherUtils.getWeatherConditionValues(String.valueOf(weatherObservation.get('weatherCondition')), null).get('weatherConditionKey');
                wrapper.status = STATUS_SUCCESS;
            }
        } catch (Exception e) {
            wrapper.status = STATUS_ERROR;
            wrapper.message = e.getMessage();
            System.debug('LDC wrapper ERROR : ' + wrapper);
            throw new AuraHandledException(e.getMessage());
        }
        return wrapper;
    }
}