@isTest
private class LDC_LocationService_Test {
    @TestSetup
    static void setup(){
        Account account = new Account(
            Name = 'Test Account',
            BillingLatitude = 48.85341,
            BillingLongitude = 2.3488
        );
        insert account;
        Contact contact = new Contact(
           FirstName = 'Test',
           LastName = 'Contact',
            MailingLatitude = 48.85341,
            MailingLongitude = 2.3488
        );
        insert contact;
    }

    @isTest
    static void LDC_LocationService_Test() {
        LDC_LocationService location = new LDC_LocationService('40.7127837', '-74.0059413');
        System.assertEquals(location.getLat(), 40.7127837);
        System.assertEquals(location.getLng(), -74.0059413);
    }
    @isTest
    static void LDC_LocationServiceCity_Test() {
        LDC_LocationService location = new LDC_LocationService('Paris');
        System.assertEquals(location.getLat(), 40.7127837);
        System.assertEquals(location.getLng(), -74.0059413);
    }
    @isTest
    static void LDC_LocationServiceAccount_Test() {
        Account testAccount = [SELECT Id FROM Account WHERE Name='Test Account' LIMIT 1];
        LDC_LocationService location = new LDC_LocationService(testAccount.Id);
        // 48.85341, 2.3488
        System.assertEquals(location.getLat(), 48.85341);
        System.assertEquals(location.getLng(), 2.3488);
    }
    @isTest
    static void LDC_LocationServiceContact_Test() {
        Contact testContact = [SELECT Id FROM Contact WHERE Name='Test Contact' LIMIT 1];
        LDC_LocationService location = new LDC_LocationService(testContact.Id);
        // 48.85341, 2.3488
        System.assertEquals(location.getLat(), 48.85341);
        System.assertEquals(location.getLng(), 2.3488);
    }
}