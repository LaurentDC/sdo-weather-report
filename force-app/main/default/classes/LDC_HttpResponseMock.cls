@isTest
public with sharing class LDC_HttpResponseMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"weatherObservation": {"ICAO": "LEPP","clouds": "clouds and visibility OK","cloudsCode": "CAVOK","countryCode": "ES","datetime": "2024-01-27 15:30:00", "dewPoint": "8", "elevation": 459, "hectoPascAltimeter": 1028, "humidity": 62, "lat": 48.85341, "lng": 2.3488, "observation": "LEPP 271530Z 00000KT CAVOK 15/08 Q1028", "stationName": "Pamplona / Noain", "temperature": "20", "weatherCondition": "rain", "windDirection": 0, "windSpeed": "00"}}');
        return response;
    }
    public HttpResponse respondError(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(400);
        response.setHeader('Content-Type', 'application/json');
        response.setBody('');
        return response;
    }
}