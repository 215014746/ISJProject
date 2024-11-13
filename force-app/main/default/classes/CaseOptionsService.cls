public with sharing class CaseOptionsService {
    @AuraEnabled
    public static String createCase(String caseDataJson) {
        try {
            // Parse the incoming JSON data
            Map<String, Object> caseData = (Map<String, Object>) JSON.deserializeUntyped(caseDataJson);
            
            // Create a new Case record
            Case newCase = new Case();
            newCase.Subject = (String) caseData.get('subject');
            newCase.Status = (String) caseData.get('status');
            newCase.Reason = (String) caseData.get('caseReason');
            newCase.Description = (String) caseData.get('description');
            newCase.OwnerId = (String) caseData.get('caseOwner');
            
            // Insert the Case record
            insert newCase;
            
            // Return the ID of the newly created case
            return newCase.Id;
        } catch (Exception e) {
            // Handle any exceptions and return an error message
            throw new AuraHandledException('Error creating case: ' + e.getMessage());
        }
    }
}