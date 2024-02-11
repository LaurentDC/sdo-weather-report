@isTest
private class LDC_WeatherAPIService_Test {

    @isTest
    static void getWeatherResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        report = LDC_WeatherAPIService.getWeatherResponse('48.85341', '2.3488');
        System.assertEquals(20, report.temperature);
    }
    @isTest
    static void getWeatherErrorResponse_Test() {
        LDC_WRP001_WeatherReport report = new LDC_WRP001_WeatherReport();
        try {
            report = LDC_WeatherAPIService.getWeatherResponse('48.85341', '123');
        } catch (Exception e) {
            System.assert(e.getMessage() != null, 'An error should be raised');
        }
    }
}