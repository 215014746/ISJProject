public with sharing class CaseDashboardController{
    //Retrieves a summary of cases by status (New, InProgress, Closed) for the current user
    @AuraEnabled(cacheable = true)
    public static Map<String, Integer> getCasesSummary(){
        // Initialize case summary map with default counts for each status
        Map<String, Integer> caseSummary = new Map<String, Integer>{ 'New' => 0, 'InProgress' => 0, 'Closed' => 0 };
        // Aggregate query to get the count of cases by status for the current user.
        List<AggregateResult> caseData = [SELECT Status, COUNT(Id)caseCount
                                          FROM Case
                                          WHERE OwnerId = :UserInfo.getUserId()
                                          GROUP BY Status];
        // Populate the case summary map with the counts from the aggregate query.
        for (AggregateResult result : caseData){
            String status = (String) result.get('Status');
            Integer count = (Integer) result.get('caseCount');
            if (caseSummary.containsKey(status)){
                caseSummary.put(status, count);
            }
        }

        return caseSummary;
    }

    //Retrieves a summary of cases by status (New, InProgress, Closed) for cases where the logged-in user is the case receiver.
    @AuraEnabled(cacheable = true)
    public static Map<String, Integer> getCaseSummaryCaseReceiver(){
        // Initialize case summary map with default counts for each statu
        Map<String, Integer> caseSummary = new Map<String, Integer>{ 'New' => 0, 'InProgress' => 0, 'Closed' => 0 };
        // Aggregate query to get the count of cases by status where the logged-in user is the case receiver
        List<AggregateResult> caseData = [SELECT Status, COUNT(Id)caseCount
                                          FROM Case
                                          WHERE caseReceiver__c = :CommunityUserDataService.getLoggedInUserContactId()
                                          GROUP BY Status];
        // Populate the case summary map with the counts from the aggregate query
        for (AggregateResult result : caseData){
            String status = (String) result.get('Status');
            Integer count = (Integer) result.get('caseCount');
            if (caseSummary.containsKey(status)){
                caseSummary.put(status, count);
            }
        }

        return caseSummary;
    }

}