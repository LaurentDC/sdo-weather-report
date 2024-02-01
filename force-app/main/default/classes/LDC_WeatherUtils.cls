/**
 * @author Laurent Dibo-Cohen
 * @date 2024-01-30
 * @description : This class is a utility class for the Weather_Condition__mdt Custom Metadata Type.
 */
public with sharing class LDC_WeatherUtils {

    private static final List<String> MOCK_FIELDS = getWeatherConditionLabels();

    public static List<String> getWeatherConditionLabels(){
        List<String> weatherConditionLabels = new List<String>(); 
        for(Weather_Condition__mdt weatherCondition : [SELECT QualifiedApiName FROM Weather_Condition__mdt]){
            weatherConditionLabels.add(weatherCondition.QualifiedApiName);
        }
        return weatherConditionLabels;
    }
    /**
     * @description : This method returns a Map of the Weather Condition values for the given weatherConditionLabel and language.
     * @param weatherConditionLabel : The weather condition label.
     * @param language : The language to get the weather condition values for (to be implemnted).
     * @return : A Map of the Weather Condition values for the given weatherConditionLabel and language.
     * @todo : Implement language parameter to retrieve the weather condition values for the given language.
     */
    public static Map<String, String> getWeatherConditionValues(String weatherConditionLabel, String language){
        Map<String, String> weatherConditionValues = new Map<String, String>();
        String langISO2 = 'EN';
        if (language != null) {
            langISO2 = language?.substring(0, 2).toUpperCase();
        }
        if (!MOCK_FIELDS.contains(weatherConditionLabel)) {
            weatherConditionLabel = 'null';  
        }
        string queryString = 'SELECT QualifiedApiName, Label_' + langISO2 + '__c, Icon_Url__c, Key__c FROM Weather_Condition__mdt WHERE QualifiedApiName = :weatherConditionLabel LIMIT 1';
        List<Weather_Condition__mdt> weatherConditions = Database.query(queryString);
        for (Weather_Condition__mdt condition : weatherConditions) {
            weatherConditionValues.put('weatherConditionLabel', condition.Label_EN__c);
            weatherConditionValues.put('weatherConditionIcon', condition.Icon_Url__c);
            weatherConditionValues.put('weatherConditionKey', condition.Key__c);
        }        
        return weatherConditionValues;
    }
}