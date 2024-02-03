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
        System.assert(report.latitude == 48.85341);
    }
    @isTest
    static void getCityWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report = LDC_WeatherServiceController.getWeatherResponse('City', '48.85341,2.3488');
        System.assert(report.latitude == 48.85341);
    }
    @isTest
    static void getAccountWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        report = LDC_WeatherServiceController.getWeatherResponse('Account', (String) testAccount.Id);
        // 48.85341, 2.3488
        System.assert(report.latitude == 48.85341);
    }
    @isTest
    static void saveWeatherReport_Test() {
        LDC_WRP001_WeatherReport report = LDC_TestDataFactory.createTestWrapper();
        String result;

        result = LDC_WeatherServiceController.saveWeatherReport(report);
        System.assert(result == 'Success');
    }
}