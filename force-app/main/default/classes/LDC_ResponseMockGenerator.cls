/**
 * @author Laurent Dibo-Cohen
 * @date 2024-01-31
 * @version 1.0.0
 * @description Generates a mock for the LDC_ResponseMockGenerator class, the geonames webservice has usually exceeded call limits
 */

public with sharing class LDC_ResponseMockGenerator {
    // Retrieve mock fields from Custom Metadata Type Weather_Condition__mdt
    private static final List<String> MOCK_FIELDS = LDC_WeatherUtils.getWeatherConditionLabels();
    /**
     * @description Generates a mock for the LDC_ResponseMockGenerator class
     * @return a Map of object with random weatherCondition values from the custom metatype Weather_Condition__mdt
     */
    public static Map<String, Object> generateMock() {
        System.debug('Generating mock for LDC_ResponseMockGenerator');
        String mockResponse = '{"weatherObservation": {"ICAO": "LEPP","clouds": "clouds and visibility OK","cloudsCode": "CAVOK","countryCode": "ES","datetime": "2024-01-27 15:30:00", "dewPoint": "8", "elevation": 459, "hectoPascAltimeter": 1028, "humidity": 62, "lat": 42.766666666666666, "lng": -1.6166666666666667, "observation": "LEPP 271530Z 00000KT CAVOK 15/08 Q1028", "stationName": "Pamplona / Noain", "temperature": "15", "weatherCondition": "n/a", "windDirection": 0, "windSpeed": "00"}}';
        Map<String, Object> mockResponseObject = (Map<String, Object>)JSON.deserializeUntyped(mockResponse);
        Map<String, Object> mockResponseObjectBody = (Map<String, Object>) mockResponseObject.get('weatherObservation');

        System.debug('LDC weatherCondition : ' + mockResponseObjectBody.get('weatherCondition'));
        mockResponseObjectBody.put('weatherCondition', MOCK_FIELDS[generateRandomNumber(MOCK_FIELDS.size())]);
        mockResponseObject.put('weatherObservation', mockResponseObjectBody);
        return mockResponseObject;
    }
    public static Integer generateRandomNumber(Integer size){
        Decimal d = math.random() * size;
        return d.intValue();
    }
}