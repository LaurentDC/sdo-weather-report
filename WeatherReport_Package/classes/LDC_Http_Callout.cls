/**
 * @author Laurent Dibo-Cohen
 * @date 2024-01-30
 * @description : This class is an interface for HTTP callout, it is used to override the sendItem method.
 * in order to change the way the callout is done depending on the client implementation.
 */
public virtual with sharing class LDC_Http_Callout {
    private static LDC_Http_Callout instance = null;

    public static LDC_Http_Callout getInstance(){
        if(instance == null) instance = new LDC_Http_Callout();
        return instance;
    }

    public object sendItem(Map<String, object> body, String HttpMethod,  String namedCredential, String endpoint, Map<String, String> headers){
        string fullPath = 'callout:' + namedCredential + endpoint;
        return callout(Json.serialize(body), HttpMethod, fullPath, headers);
    }

    public object sendItem(Map<String, object> body, String HttpMethod, String endpoint, Map<String, String> headers){
        return callout(Json.serialize(body), HttpMethod, endpoint, headers);
    }

    public object sendItem(String body, String HttpMethod,  String namedCredential, String endpoint, Map<String, String> headers){
        string fullPath = 'callout:' + namedCredential + endpoint;
        return callout(body, HttpMethod, fullPath, headers);
    }

    public object sendItem(String body, String HttpMethod, String fullPath, Map<String, String> headers){
        return callout(body, HttpMethod, fullPath, headers);
    }
    
    public object  callout(string jsonRequestBody, String httpMethod, String endpoint, Map<String, String> headers){
        HttpRequest request = new HttpRequest();
        request.setTimeout(120000);
        request.setEndpoint(endpoint);
        request.setMethod(httpMethod);
        request.setBody(jsonRequestBody); 

        for(String headerKey: headers.keySet()){
            request.setHeader(headerKey, headers.get(headerKey));
        }
        HttpResponse resp = new Http().send(request);
        return onCalloutSuccess(endpoint, request, resp);  
    }

    public virtual object onCalloutSuccess(String endpoint, HttpRequest req, HttpResponse resp){
        return null;
    }  
}