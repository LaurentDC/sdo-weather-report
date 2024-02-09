@isTest
private class LDC_WeaterReportService_Test {
    @TestSetup
    static void setup(){
        Account account = new Account(
            Name = 'Test Account',
            BillingLatitude = 48.85341,
            BillingLongitude = 2.3488
        );
        insert account;
    }

    @isTest
    static void insertUserWeatherReport_Test() {
        LDC_WeaterReportService service = new LDC_WeaterReportService();
        String result;
        String PREFIX = 'WR';
        Id currentUserId = UserInfo.getUserId();
        LDC_WRP001_WeatherReport report = LDC_TestDataFactory.createTestWrapper();
        report.recordType = 'USER';
        report.recordId = currentUserId;

        result = LDC_WeaterReportService.insertWeatherReport(report);

        LDC_Weather_Report__c validateReport = [SELECT Id, LDC_Weather_User__c FROM LDC_Weather_Report__c WHERE LDC_Weather_User__c = :currentUserId LIMIT 1];
        System.assertEquals(validateReport.LDC_Weather_User__c, currentUserId);
    }
    @isTest
    static void insertAccountWeatherReport_Test() {
        LDC_WeaterReportService service = new LDC_WeaterReportService();
        String result;
        String PREFIX = 'WR';
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        LDC_WRP001_WeatherReport report = LDC_TestDataFactory.createTestWrapper();
        report.recordType = 'Account';
        report.recordId = testAccount.Id;

        result = LDC_WeaterReportService.insertWeatherReport(report); 
        LDC_Weather_Report__c validateReport = [SELECT Id, LDC_Weather_Account__c FROM LDC_Weather_Report__c WHERE LDC_Weather_Account__c = :testAccount.Id LIMIT 1];
        System.assertEquals(validateReport.LDC_Weather_Account__c, testAccount.Id);
    }
}