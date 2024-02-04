@isTest
private class LDC_ResponseMockGenerator_Test {

    @isTest
    static void generateResponseMock_Test() {
        Map<String, Object> reponseMock = LDC_ResponseMockGenerator.generateMock();
        System.assert(reponseMock != null, 'reponseMock should not be null');
    }
}