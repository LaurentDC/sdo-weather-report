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

        Test.startTest();
        result = LDC_WeaterReportService.insertWeatherReport(report); 
        Test.stopTest();
        System.assertEquals(result, 'Success');
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
        Test.startTest();
        result = LDC_WeaterReportService.insertWeatherReport(report); 
        Test.stopTest();
        System.assertEquals(result, 'Success');
    }
}