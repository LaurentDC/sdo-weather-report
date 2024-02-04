Weather Report Widget
Salesforce Development Project
Author : Laurent Dibo-Cohen
Date : 04/02/2024
Context
Project requirements
Create a component that takes as input a city name or a Lat/Long coordinates.
This component should call an external WebService that provides Weather info
(http://www.geonames.org/export/JSON-webservices.html#Weather).

For each location must show the following :
Wind Speed
Temperature
Humidity
Current weather condition icon (snow, rain, cloudy, sunny ...)

This component must run correctly in :
Salesforce as standalone component in the homepage (using the current user location)
In Account layout that has a location

Add a button to send the weather report to the org users or the related contacts of an
account (depends on where the component is) and track when the last report has been
sent.
Limitations
The required API often returns “Limits Exceeded” message which makes the development complicated, I had to create a response mock generator to avoid this problem.
The API doesn’t expose any endpoint to retrieve weather data from a city, this part has been skipped.
The language is en_US and translations have not been taken into account for the project.
Architecture
Components
Abstract Class Diagram


This diagram shows the different components developed for the project and the links between them.
Components Description
lDC_NewWeatherReportComponent
Lightning Web Component representing the UI and containing the logic for sending the parameters to the Apex Controller depending on the type of Object it is rendered
Account Id if it is rendered on the account page
User location if it is rendered on the home page
LDC_WRP001_WeatherReport
Wrapper representing the Weather Report to be displayed on the LWC
LDC_WeatherServiceController
This Apex class is called by the LWC to retrieve weather data from sent parameters. It returns an instance of the Weather Report Wrapper Object. It calls the Location Service to get latitude and longitude parameter depending on the type of parameters received).
It is also called by the LWC to save the Weather Report Object (LDC_Weather_Report__c) in Salesforce.
LDC_Weather_WebService
This Apex class is called by the Controller and it is in charge of preparing the request to be sent to the LDC_Weather_Http_Callout class. It is responsible for preparing the response to the Controller.
LDC_Http_Callout
Virtual class that is used to create an abstraction layer that can be called for many APIs depending on the security and parameters expected.
LDC_Weather_Http_Callout
This class extends LDC_Http_Callout to send the request and receive the response from the web service. It is also in charge of checking if the API has exceeded its limits and if so, it is responsible for calling the mock generator.
LDC_LocationService
This class is in charge of returning lat and lng parameters depending in the type of parameters received when instantiated: 
Object Id
String, String
String
LDC_ResponseMockGenerator
This class is called to create mock responses with random parameters when the API has exceeded its limits.
LDC_WeaterReportService
This service is responsible for LDC_Weather_Report__c object creation in Salesforce
LDC_WeatherUtils
This class is in charge for retrieving Weather Metadata Types from Salesforce to add Icon Url links to the Wrapper Object and translation labels (To be implemented).
LDC_WRP001_WeatherReport
This class represents the payload returned to the LWC and received for persistence in the Salesforce database. This is the main object shared by the different classes during its lifecycle.
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

LDC_Weather_Report__c
This Custom Object represents the Weather Report in Salesforce. 
Data model : 
LDC_Weather_User__c : User Id if generated from Home Page
LDC_Weather_Account__c : Account Id if generated from Account Page
LDC_Humidity__c : Number
LDC_Temperature__c : Number
LDC_Wind_Speed__c : Number
LDC_Location_Report__Latitude__s : Float
LDC_Location_Report__Longitude__s : Float
LDC_Weather_Condition__c : String
Name : generated with prefix WR_ + datetime
LDC_Weather_Settings__c
This Custom Setting holds the external API parameters to be sent for the request.
Data Model : 
host : String
endpoint : String
username : String
Note : In real life, these parameters should not be held in a custom setting but a Named Credential should be used for security issues.

Weather_Condition__mdt
This Custom Metadata Type holds the weather data to be displayed on the LWC
Data Model : 
Icon_Url__c : URL(255)	
Key__c : Text(50)
Label_EN__c : Text(50)
Label_FR__c : Text(50)

Sequence
Sequence Diagram


This diagram describes the different calls made after receiving the request from the LWC.
At the end of the process, when the instance for the custom object LDC_Weather_Report__c, the flow LDC_Send_Weather_Report_By_Email is triggered to send emails.
LDC_Send_Weather_Report_By_Email
Trigger : When a LDC_Weather_Report__c instance is created
Flow : 
If the record has a LDC_Weather_Account__c ID, all contacts of the account are retrieved and an email with the weather report data is sent to every one of them.
If the record has a LDC_Weather_User__c ID, all users from the Public Group LDC_Weather_Users are retrieved and an email with the weather report data is sent to every one of them.
Deployment and Usage
Deployment
Metadata
The package contains all the required components to be deployed : 
Apex classes with Test classes
Custom Applications
Custom Objects
Custom Tabs
Flows
Groups
Layouts
Lightning Component Bundles
List Views
Permission Sets
Profiles
The developments have been made on a SDO (Simple Demo Org) provided by Salesforce, it could be tricky to deploy this package on a regular org with all the provided bundles.
All Apex classes are provided with their Test classes tested with success but the whole package deployment has not been tested.
Data
Some data has to be imported in order for the component to be deployed and work : 
LDC_Weather_Settings__c
LDC_Weather_Condition__mdt
Usage
Deploy package.xml
Import Data
Create User with profile Admin
Add Permission Sets assignment to non Admin Users
Add Users to Public Group LDC_Weather_Users
Create an Account or use an existing Account (ex. Roseburg Products)
Create Contacts with your email on the Account

Resources
Documentation : Weather Report Widget
Data : Weather Report Data
Github project : https://github.com/LaurentDC/sdo-weather-report

