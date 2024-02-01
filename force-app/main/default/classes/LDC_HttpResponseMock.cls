@isTest
global with sharing class LDC_HttpResponseMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"weatherObservation": {"ICAO": "LEPP","clouds": "clouds and visibility OK","cloudsCode": "CAVOK","countryCode": "ES","datetime": "2024-01-27 15:30:00", "dewPoint": "8", "elevation": 459, "hectoPascAltimeter": 1028, "humidity": 62, "lat": 42.766666666666666, "lng": -1.6166666666666667, "observation": "LEPP 271530Z 00000KT CAVOK 15/08 Q1028", "stationName": "Pamplona / Noain", "temperature": "15", "weatherCondition": "n/a", "windDirection": 0, "windSpeed": "00"}}');
        return response;
    }
}