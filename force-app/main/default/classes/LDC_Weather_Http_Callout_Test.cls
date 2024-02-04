@isTest
private class LDC_Weather_Http_Callout_Test {

    @isTest
    static void onCalloutSuccess_Test() {
        LDC_Weather_Http_Callout callout = new LDC_Weather_Http_Callout();
        LDC_HttpResponseMock responseMock = new LDC_HttpResponseMock();
        String endpoint = '';
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint(endpoint);
        response = responseMock.respond(request);
        Map<String, Object> body = (Map<String, Object>) callout.onCalloutSuccess(endpoint, request, response);
        System.assertEquals(body.containsKey('weatherObservation'), true, 'Body contains weatherObservation');
    }
    static void onCalloutSuccessNull_Test() {
        LDC_Weather_Http_Callout callout = new LDC_Weather_Http_Callout();
        LDC_HttpResponseMock responseMock = new LDC_HttpResponseMock();
        String endpoint = '';
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint(endpoint);
        response = responseMock.respond(request);
        response.setBody(null);
        Map<String, Object> body = (Map<String, Object>) callout.onCalloutSuccess(endpoint, request, response);
        System.assertEquals(body, null, 'Body is null');
    }
    static void onCalloutSuccessStatus_Test() {
        LDC_Weather_Http_Callout callout = new LDC_Weather_Http_Callout();
        LDC_HttpResponseMock responseMock = new LDC_HttpResponseMock();
        String endpoint = '';
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint(endpoint);
        response = responseMock.respond(request);
        response.setBody('{"status":{"elevation":459,"lng":-1.6166666666666667,"observation":"LEPP 031530Z VRB01KT CAVOK 15/07 Q1031","ICAO":"LEPP","clouds":"clouds and visibility OK","dewPoint":"7","cloudsCode":"CAVOK","datetime":"2024-02-03 15:30:00","countryCode":"ES","temperature":"15","humidity":58,"stationName":"Pamplona / Noain","weatherCondition":"n/a","hectoPascAltimeter":1031,"windSpeed":"01","lat":42.766666666666666}}');
        Map<String, Object> body = (Map<String, Object>) callout.onCalloutSuccess(endpoint, request, response);
        System.assertEquals(body, null, 'Body is null');
    }
    static void onCalloutSuccess400_Test() {
        LDC_Weather_Http_Callout callout = new LDC_Weather_Http_Callout();
        LDC_HttpResponseMock responseMock = new LDC_HttpResponseMock();
        String endpoint = '';
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint(endpoint);
        response = responseMock.respond(request);
        response.setStatusCode(400);
        Map<String, Object> body = (Map<String, Object>) callout.onCalloutSuccess(endpoint, request, response);
        System.assertEquals(body, null, 'Body is null');
    }
}