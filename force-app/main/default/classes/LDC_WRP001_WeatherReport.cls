/**
 * @description: LDC_WRP001_WeatherReport represents the payload for the LDC_WRP001_Weather component.
 * @version: 1.0
 * @date: 2024-01-30
 * @author: Laurent Dibo-Cohen
 */
public class LDC_WRP001_WeatherReport {
    @AuraEnabled
    public Integer temperature;
    @AuraEnabled
    public Integer humidity;
    @AuraEnabled
    public Integer windSpeed;
    @AuraEnabled
    public String weatherConditionLabel;
    @AuraEnabled
    public String conditionIconUrl;
    @AuraEnabled
    public String conditionKey;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public String message;
    @AuraEnabled
    public String recordId;
    @AuraEnabled
    public String recordType;
    @AuraEnabled
    public Double latitude;
    @AuraEnabled
    public Double longitude;
}