@isTest
private class LDC_WRP001_WeatherReport_Test {

    @isTest
    static void getSampleWeatherData_Test() {
        String jsonInput = '[{"temperature": 20,"humidity": 50,"windSpeed": 10,"weatherConditionLabel": "Sunny","conditionIconUrl": "https://www.google.com/images/icons/product/cloud-48.png","conditionKey": "01d","status": "Success","message": "Weather Data Retrieved Successfully","recordId": "1234567890","recordType": "Account","latitude": 1234567890,"longitude": 1234567890}]';
        List<LDC_WRP001_WeatherReport> reports = LDC_WRP001_WeatherReport.getSampleWeatherData(jsonInput);
        System.assert(reports.size() > 0, 'Weather Reports found');
    }
    @isTest
    static void unitWeatherData_Test() {
        LDC_WRP001_WeatherReport report = LDC_TestDataFactory.createTestWrapper();
        System.assert(report.temperature == 20, 'Temperature is 20');
    }
}