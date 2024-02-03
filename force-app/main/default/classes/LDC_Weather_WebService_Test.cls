@isTest
private class LDC_Weather_WebService_Test {

    @isTest
    static void getWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report = LDC_Weather_WebService.getWeatherResponse('48.85341', '2.3488');
        System.assertEquals(20, report.temperature);
    }
}