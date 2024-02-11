/**
 * @description : this call extends the LDC_Http_Callout class to handle the weather api call
 * @author : Laurent Dibo-Cohen
 * @version : 1.0
 * @date : 2024-01-30
 */
public with sharing class LDC_Weather_Http_Callout extends LDC_Http_Callout{
    public static LDC_Weather_Http_Callout instance = null;

    public static LDC_Weather_Http_Callout getInstance() {
        if(instance == null) {
            instance = new LDC_Weather_Http_Callout();
        }
        return instance;
    }
    
    public override Object onCalloutSuccess(String endpoint, HttpRequest req, HttpResponse resp){
        Map<String, Object> body;
        if (resp.getStatusCode() == 200) {
            if (resp.getBody() != null) {
                body = (Map<String, Object>)JSON.deserializeUntyped(resp.getBody());
                if (body.containsKey('status')) {
                    //if the geonames webservice has exceed its call limit, return a mock response from the mock generator
                    System.debug('LDC limit exceeded : ' + body.get('status'));
                    body = LDC_ResponseMockGenerator.generateMock();
                }
            }
        } else {
            // Create log object
            Map<String, String> logError = new Map<String, String>();
            logError.put('function', 'LDC_Weather_Http_Callout.onCalloutSuccess');
            logError.put('message', 'Error calling endpoint '+ endpoint +' with status code '+ resp.getStatusCode());
            LDC_LogObjectService logger = new LDC_LogObjectService();
            logger.insertLogObject(logError);
            throw new LDC_CalloutException('Error calling endpoint '+ endpoint +' with status code '+ resp.getStatusCode());
        }
        return body;
    }
}