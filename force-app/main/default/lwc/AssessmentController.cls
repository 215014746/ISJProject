public with sharing class AssessmentController {
    
    
    @AuraEnabled
    public static Id createAssessment(String assessmentData)
    {
        try{
            AssessmentObject newAssessment = (AssessmentObject) JSON.deserialize(assessmentData, AssessmentObject.class);
            Id assessmentId = AssessmentDataService.insertAssessment(AssessmentObject.mapAssessmentObjectToAssessment(newAssessment));
            return assessmentId;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled(cacheable=true)
    public static List<AssessmentObject> getAllBySubject(String subject)
    {
        try{
            return mapMultipleAssessmentsToAssessmentObjects(AssessmentDataService.getAssessmentBySubject(subject));             
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }   
    
    @AuraEnabled(cacheable=true)
    public static AssessmentObject getAssessmentById(String assessmentId)
    {
        try{
        Assessment__c assessmentRecord = AssessmentDataService.getAssessmentById(assessmentId);
        return AssessmentObject.mapAssessmentToAssessmentObject(assessmentRecord);     
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled(cacheable=true)
    public static AssessmentObject getAssessmentAndQuestionsByAssessmentId(String assessmentId){
        try{
             AssessmentObject res = AssessmentObject.mapAssessmentToAssessmentObject(AssessmentDataService.getAssessmentById(assessmentId));
             res.questions = AssessmentQuestionController.getAllAssessmentQuestionsByAssessmentId(assessmentId);
             
             return res;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void updateAssessment(String assessmentData)
    {
        try {
            
            AssessmentObject updatedAssessment = (AssessmentObject) JSON.deserialize(assessmentData, AssessmentObject.class);
            AssessmentDataService.updateAssessment(AssessmentObject.mapAssessmentObjectToAssessment(updatedAssessment));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static void deleteAssessment(String assessmentId)
    {
        try{
            AssessmentDataService.deleteAssessment(assessmentId); 
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    //HELPER METHODS
    private static List<AssessmentObject> mapMultipleAssessmentsToAssessmentObjects(List<Assessment__c> assessments){
        
        List<AssessmentObject> results = new List<AssessmentObject>();
        
        for(Assessment__c record: assessments){
            results.add(AssessmentObject.mapAssessmentToAssessmentObject(record));
        }
        
        return results;
    }
    
}