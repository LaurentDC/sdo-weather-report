@isTest
public with sharing class LDC_Http_Callout_Test {
    @isTest
    static void test_sendItemMapBody() {
        Map<String, object> body = new Map<String, object>();
        String HttpMethod = 'GET';
        String namedCredential = 'Credential';
        String endpoint = 'test';
        Map<String, String> headers = new Map<String, String>();
        LDC_Http_Callout callout = LDC_Http_Callout.getInstance();
        Object resp;
        
        Test.setMock(HttpCalloutMock.class, new LDC_MockHttpResponseGenerator());
        body.put('test', 'test');
        headers.put('Authorization', 'my_access_token');
        Test.startTest();
            resp = callout.sendItem(body, HttpMethod, namedCredential, endpoint, headers);
        Test.stopTest();
        system.assertEquals(null, resp);
    }

    @isTest
    static void test_sendItemStringBody() {
        String body = '{"test": "test"}';
        String HttpMethod = 'GET';
        String namedCredential = 'Credential';
        String endpoint = 'test';
        Map<String, String> headers = new Map<String, String>();
        LDC_Http_Callout callout = LDC_Http_Callout.getInstance();
        Object resp;
        
        Test.setMock(HttpCalloutMock.class, new LDC_MockHttpResponseGenerator());
        headers.put('Authorization', 'my_access_token');
        Test.startTest();
            resp = callout.sendItem(body, HttpMethod, namedCredential, endpoint, headers);
        Test.stopTest();
        system.assertEquals(null, resp);
    }

    @isTest
    static void test_sendItemSimplePath() {
        String body = '{"test": "test"}';
        String HttpMethod = 'GET';
        String fullPath = 'Credential/test';
        Map<String, String> headers = new Map<String, String>();
        LDC_Http_Callout callout = LDC_Http_Callout.getInstance();
        Object resp;
        
        Test.setMock(HttpCalloutMock.class, new LDC_MockHttpResponseGenerator());
        headers.put('Authorization', 'my_access_token');
        Test.startTest();
            resp = callout.sendItem(body, HttpMethod, fullPath, headers);
        Test.stopTest();
        system.assertEquals(null, resp);
    }
}