public with sharing class CaseController 
{
    
    @AuraEnabled
    public static Id createCase(String caseData)
    {
        try{
            CaseObject newCase = (CaseObject) JSON.deserialize(caseData, CaseObject.class);
            Id caseId = CaseDataService.insertCase(CaseObject.mapCaseObjectToCase(newCase));
            return caseId;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static List<CaseObject> getCasesByOwnerId(String ownerId)
    {
        try{
            return mapMultipleCasesToCaseObjects(CaseDataService.getCasesByOwnerId(ownerId));
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static List<CaseObject> getCasesByCaseReceiverId(String caseReceiverId)
    {
        try{
            return mapMultipleCasesToCaseObjects(CaseDataService.getCasesByCaseReceiverId(caseReceiverId)); 
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static CaseObject getCaseId(String caseReceiverId)
    {
        try{
        Case caseRecord = CaseDataService.getCaseById(caseReceiverId);
        return CaseObject.mapCaseToCaseObject(caseRecord);     
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    @AuraEnabled
    public static void updateCase(String caseData)
    {
        try {
            
            CaseObject updatedCase = (CaseObject) JSON.deserialize(caseData, CaseObject.class);
            CaseDataService.updateCase(CaseObject.mapCaseObjectToCase(updatedCase));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
  
      @AuraEnabled
    public static void deleteCase(String caseId)
    {
        try{
            CaseDataService.deleteCase(caseId);  
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    } 
    
    //HELPER METHODS
    private static List<CaseObject> mapMultipleCasesToCaseObjects(List<Case> cases){
        
        List<CaseObject> results = new List<CaseObject>();
        
        for(Case record: cases){
            results.add(CaseObject.mapCaseToCaseObject(record));
        }
        
        return results;
    }

}