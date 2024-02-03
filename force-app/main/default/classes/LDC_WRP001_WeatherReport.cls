/**
 * @description: LDC_WRP001_WeatherReport represents the payload for the LDC_WRP001_Weather component.
 * @version: 1.0
 * @date: 2024-01-30
 * @author: Laurent Dibo-Cohen
 */
public class LDC_WRP001_WeatherReport {
    @AuraEnabled
    public Decimal temperature {get;set;}
    @AuraEnabled
    public Decimal humidity {get;set;}
    @AuraEnabled
    public Decimal windSpeed {get;set;}
    @AuraEnabled
    public String weatherConditionLabel {get;set;}
    @AuraEnabled
    public String conditionIconUrl {get;set;}
    @AuraEnabled
    public String conditionKey {get;set;}
    @AuraEnabled
    public String status {get;set;}
    @AuraEnabled
    public String message {get;set;}
    @AuraEnabled
    public String recordId {get;set;}
    @AuraEnabled
    public String recordType {get;set;}
    @AuraEnabled
    public Double latitude {get;set;}
    @AuraEnabled
    public Double longitude {get;set;}

    public static List<LDC_WRP001_WeatherReport> getSampleWeatherData(String jsonInput) {
        return (List<LDC_WRP001_WeatherReport>) System.JSON.deserialize(jsonInput, List<LDC_WRP001_WeatherReport>.class);
    }
}