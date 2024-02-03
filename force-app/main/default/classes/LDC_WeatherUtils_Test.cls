@isTest
private class LDC_WeatherUtils_Test {
    @isTest
    static void getWeatherConditionLabels_Test() {
        List<String> labels = new List<String>();
        labels = LDC_WeatherUtils.getWeatherConditionLabels();
        System.assertEquals(labels.size(), 11);
    }
    @isTest
    static void getWeatherConditionValues_Test() {
        Map<String, String> weatherConditionValues = new Map<String, String>();
        weatherConditionValues = LDC_WeatherUtils.getWeatherConditionValues('rain', null);
        System.assertEquals(weatherConditionValues.get('weatherConditionKey'), 'RA');
    }
}