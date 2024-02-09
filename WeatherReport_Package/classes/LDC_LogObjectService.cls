/**
 * @author Laurent Dibo-Cohen
 * @version 1.0
 * @date 2024-02-09
 * @description : This class is used to manage the log objects persistence in Salesforce when an error occurs.
 */
public with sharing class LDC_LogObjectService {
    public void insertLogObject(Map<String, String> logData) {
        LDC_Log_Object__c logObject = new LDC_Log_Object__c();
        logObject = new LDC_Log_Object__c();
        logObject.LDC_Category__c = 'Apex';
        logObject.LDC_Priority__c = 'Medium';
        logObject.LDC_Assigned_To__c = UserInfo.getUserId();
        logObject.LDC_Status__c = 'Open';
        if (logData.get('function')!= null) {
            logObject.LDC_Function__c = logData.get('function');
        }
        if (logData.get('message')!= null) {
            logObject.LDC_Description__c = logData.get('message');
        }
        try {
            insert logObject;
        } catch (Exception e) {
            System.debug('LDC : Error inserting log object : ' + e.getMessage());
        }
    }
}