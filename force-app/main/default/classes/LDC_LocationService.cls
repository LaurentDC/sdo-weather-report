public with sharing class LDC_LocationService {
    @TestVisible private Decimal lat {get; set;}
    @TestVisible private Decimal lng {get; set;}

    public LDC_LocationService(Id sObjectId) {
        if (sObjectId != null) {
            getLatLngFromObject(sObjectId);
        } else {
            //throw new Exception('Invalid object Id');
        }
        System.debug('LDC is ObjectId from LDC_LocationService: ' + this.lat + ',' + this.lng);
    }
    public LDC_LocationService(String lat, String lng) {
        this.lat = decimal.valueOf(lat);
        this.lng = decimal.valueOf(lng);
        System.debug('LDC is lat,lng from LDC_LocationService: ' + this.lat + ',' + this.lng);
    }
    public LDC_LocationService(String city) {
        getLatLngFromCity(city);
        System.debug('LDC is city from LDC_LocationService: ' + this.lat + ',' + this.lng);
    }

    private void getLatLngFromObject(Id sObjectId){
        String sObjectName = null;
        sObjectName = getSObjectType(sObjectId);
        if(sObjectName == 'Account') {
            getLatLngFromAccount(sObjectId);
        } else if(sObjectName == 'Contact') {
            getLatLngFromContact(sObjectId);
        } else {
            //throw new Exception('Invalid object type');
        }
    }
    private String getSObjectType(Id sObjectId) {
        String sObjectName = sObjectId?.getSObjectType().getDescribe().getName();
        System.debug('sObjectName:'+ sObjectName);
        return sObjectName;
    }
    private void getLatLngFromAccount(Id accountId) {
        Account acc = [SELECT BillingLatitude, BillingLongitude FROM Account WHERE Id = :accountId][0];
        this.lat = acc.BillingLatitude;
        this.lng = acc.BillingLongitude;
    }
    private void getLatLngFromContact(Id contactId) {
        Contact contact = [SELECT MailingLatitude, MailingLongitude FROM Contact WHERE Id = :contactId][0];
        this.lat = contact.MailingLatitude;
        this.lng = contact.MailingLongitude;
    }
    private void getLatLngFromCity(String city) {
        System.debug('LDC is city from getLatLngFromCity:'+ city);
        // TODO: Get lat/lng from city with Webservice
        this.lat = decimal.valueOf('40.7127837');
        this.lng = decimal.valueOf('-74.0059413');
    }
    public Decimal getLat(){
        return this.lat;
    }
    public Decimal getLng(){
        return this.lng;
    }
}