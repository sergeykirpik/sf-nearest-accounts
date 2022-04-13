@IsTest
private class NearestAccountsControllerTest {

    @IsTest
    private static void testGetNearestAccounts() {
        createTestData();
        List<Account> accounts;
        Test.startTest();
        {
            accounts = NearestAccountsController.getNearestAccounts(0.0, 0.0);
        }
        Test.stopTest();
        System.assertEquals(NearestAccountsController.ACCOUNTS_LIMIT, accounts.size(), 'Should return correct number of accounts');
        System.assertEquals('TEST 1', accounts[0].Name, 'Should be the nearest');
        System.assertEquals('TEST 4', accounts[3].Name, 'Should be the fartherst');
    }

    private static void createTestData() {
        insert new List<Account>{
            new Account(Name = 'TEST 1', GPS__latitude__s = 10.0, GPS__longitude__s = 10.0),
            new Account(Name = 'TEST 2', GPS__latitude__s = 20.0, GPS__longitude__s = 20.0),
            new Account(Name = 'TEST 3', GPS__latitude__s = 30.0, GPS__longitude__s = 30.0),
            new Account(Name = 'TEST 4', GPS__latitude__s = 40.0, GPS__longitude__s = 40.0),
            new Account(Name = 'TEST 5', GPS__latitude__s = 50.0, GPS__longitude__s = 50.0)
        };
    }

}

