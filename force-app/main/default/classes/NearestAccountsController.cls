public with sharing class NearestAccountsController {

    @AuraEnabled
    public static List<Account> getNearestAccounts(Decimal latitude, Decimal longitude) {
        try {
            return selectAccounts(latitude, longitude);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    private static List<Account> selectAccounts(Decimal latitude, Decimal longitude) {
        return [
            SELECT Id, GPS__c, Name FROM Account
            ORDER BY DISTANCE(GPS__c, GEOLOCATION(:latitude, :longitude), 'km') NULLS LAST
            LIMIT 4
        ];
    }
}
