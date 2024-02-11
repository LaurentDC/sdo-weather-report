@isTest
private class LDC_Weather_Http_Callout_Test {
    @isTest
    static void getInstance_Test(){
        LDC_Weather_Http_Callout instance = LDC_Weather_Http_Callout.getInstance();
        System.assert(instance != null, 'Instance shouldn t be null');
    }

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
    @isTest
    static void onCalloutSuccess400_Test() {
        LDC_Weather_Http_Callout callout = new LDC_Weather_Http_Callout();
        LDC_HttpResponseMock responseMock = new LDC_HttpResponseMock();
        String endpoint = '';
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        request.setEndpoint(endpoint);
        response = responseMock.respondError(request);
        try {
            Map<String, Object> body = (Map<String, Object>) callout.onCalloutSuccess(endpoint, request, response);
        } catch (Exception e) {
            System.assert(e.getMessage() != null);
        }
    }
}