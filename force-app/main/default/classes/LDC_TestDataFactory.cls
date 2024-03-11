@isTest
public class LDC_TestDataFactory {

    public static LDC_WRP001_WeatherReport createTestWrapper() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report.temperature = 20;
        report.humidity = 50;
        report.windSpeed = 10;
        report.weatherConditionLabel = 'rain';
        report.conditionIconUrl = 'https://www.google.com/images/icons/product/cloud-48.png';
        report.conditionKey = '01d';
        report.status = 'Success';
        report.message = 'Weather Data Retrieved Successfully';
        report.recordId = '1234567890';
        report.recordType = 'Account';
        report.latitude = 48.85341;
        report.longitude = 2.3488;
        return report;
    }
    // test devops
}