/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private with sharing class LDC_Http_Callout_Test {
    @isTest
    static void test_sendItemMapBody() {
        Map<String, object> body = new Map<String, object>();
        String HttpMethod = 'GET';
        String namedCredential = 'Credential';
        String endpoint = 'test';
        Map<String, String> headers = new Map<String, String>();
        LDC_Http_Callout callout = LDC_Http_Callout.getInstance();
        Object resp;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
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
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
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
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        headers.put('Authorization', 'my_access_token');
        Test.startTest();
            resp = callout.sendItem(body, HttpMethod, fullPath, headers);
        Test.stopTest();
        system.assertEquals(null, resp);
    }
}