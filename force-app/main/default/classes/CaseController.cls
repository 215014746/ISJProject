public with sharing class CaseController{
    // Creates a new Case record from a JSON string, returns the Case ID
    @AuraEnabled
    public static Id createCase(String caseData){
        // Deserialize the JSON data to a CaseObject instance
        try{
            CaseObject newCase = (CaseObject)JSON.deserialize(caseData, CaseObject.class);
            // Insert the Case record and return its ID
            Id caseId = CaseDataService.insertCase(CaseObject.mapCaseObjectToCase(newCase));
            return caseId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves a list of cases by owner ID, mapped to CaseObjects
    @AuraEnabled
    public static List<CaseObject> getCasesByOwnerId(String ownerId){
        try{
            return mapMultipleCasesToCaseObjects(CaseDataService.getCasesByOwnerId(ownerId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves a list of cases where the logged-in user is the case receiver
    @AuraEnabled(cacheable = true)
    public static List<CaseObject> getCasesByCaseReceiverId(){
        try{
            return mapMultipleCasesToCaseObjects(CaseDataService.getCasesByCaseReceiverId(CommunityUserDataService.getLoggedInUserContactId()));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves a single case by its ID and maps it to a CaseObject
    @AuraEnabled
    public static CaseObject getCaseId(String caseReceiverId){
        try{
            Case caseRecord = CaseDataService.getCaseById(caseReceiverId);
            return CaseObject.mapCaseToCaseObject(caseRecord);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Updates an existing case with the data provided in JSON format
    @AuraEnabled
    public static void updateCase(String caseData){
        try{

            CaseObject updatedCase = (CaseObject)JSON.deserialize(caseData, CaseObject.class);
            CaseDataService.updateCase(CaseObject.mapCaseObjectToCase(updatedCase));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Deletes a case by its ID
    @AuraEnabled
    public static void deleteCase(String caseId){
        try{
            CaseDataService.deleteCase(caseId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Helper method to map a list of Case records to CaseObjects
    private static List<CaseObject> mapMultipleCasesToCaseObjects(List<Case> cases){

        List<CaseObject> results = new List<CaseObject>();

        for (Case record : cases){
            results.add(CaseObject.mapCaseToCaseObject(record));
        }

        return results;
    }

    @AuraEnabled
    public static String createBotCase(String caseDataJson){
        try{
            // Parse the incoming JSON data
            Map<String, Object> caseData = (Map<String, Object>)JSON.deserializeUntyped(caseDataJson);

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
        } catch (Exception e){
            // Handle any exceptions and return an error message
            throw new AuraHandledException('Error creating case: ' + e.getMessage());
        }
    }

}