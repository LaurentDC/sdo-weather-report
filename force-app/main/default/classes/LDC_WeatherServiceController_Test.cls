@isTest
private class LDC_WeatherServiceController_Test {
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
    static void getUserWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report = LDC_WeatherServiceController.getWeatherResponse('User', '48.85341,2.3488');
        System.assert(report.temperature == 20);
    }
    @isTest
    static void getCityWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report = LDC_WeatherServiceController.getWeatherResponse('City', '48.85341,2.3488');
        System.assert(report.temperature == 20);
    }
    @isTest
    static void getAccountWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        report = LDC_WeatherServiceController.getWeatherResponse('Account', (String) testAccount.Id);
        System.assert(report.temperature == 20);
    }
    @isTest
    static void saveWeatherReport_Test() {
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        LDC_WRP001_WeatherReport report = LDC_TestDataFactory.createTestWrapper();
        report.recordId = testAccount.Id;
        report.recordType = 'Account';
        String result;
        result = LDC_WeatherServiceController.saveWeatherReport(report);
        
        LDC_Weather_Report__c validateReport = [SELECT Id, LDC_Weather_Account__c FROM LDC_Weather_Report__c WHERE LDC_Weather_Account__c = :testAccount.Id LIMIT 1];
        System.assertEquals(validateReport.LDC_Weather_Account__c, testAccount.Id);
    }
}