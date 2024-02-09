@isTest
private class LDC_LogObjectService_Test {

    @isTest
    static void insertLogObject_Test() {                
        Map<String, String> logError = new Map<String, String>();
        logError.put('function', 'LDCTEST');
        logError.put('message', 'This is a test');
        LDC_LogObjectService logger = new LDC_LogObjectService();
        logger.insertLogObject(logError);
        LDC_Log_Object__c logObject = [SELECT Id, LDC_Function__c FROM LDC_Log_Object__c WHERE LDC_Function__c = 'LDCTEST'];
        System.assertEquals(logObject.LDC_Function__c, 'LDCTEST');
    }
}