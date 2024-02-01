/**
 * @description: LDC_WRP001_WeatherPayload represents the payload for the LDC_WRP001_Weather component.
 * @version: 1.0
 * @date: 2024-01-30
 * @author: Laurent Dibo-Cohen
 */
public class LDC_WRP001_WeatherPayload {
    @AuraEnabled
    public String temperature;
    @AuraEnabled
    public String humidity;
    @AuraEnabled
    public String windSpeed;
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
    public String accountId;
    @AuraEnabled
    public String latitude;
    @AuraEnabled
    public String longitude;
}