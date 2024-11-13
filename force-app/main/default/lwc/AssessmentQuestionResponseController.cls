public class AssessmentQuestionResponseController{
    
    @AuraEnabled
    public static Id createAssessmentQuestionResponse(String assessmentQResponseData)
    {
        try{
            AssessmentQuestionResponseObject newAssessmentQResponse = (AssessmentQuestionResponseObject) JSON.deserialize(assessmentQResponseData,AssessmentQuestionResponseObject.class);
            Id assessmentQResponseId = AssessmentQuestionResponseDataService.insertAssessmentQuestionResponse(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(newAssessmentQResponse));
            return assessmentQResponseId;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentQuestionResponseObject getStudentAssessmentQuestionResponseByName(String name)
    {
        try{
           Student_Assessment_Question_Response__c assessmentQuestionResponseRecord = AssessmentQuestionResponseDataService.getStudentAssessmentQuestionResponseByName(name);
        return AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(assessmentQuestionResponseRecord);  
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentQuestionResponseObject getAssessmentResponseById(String assessmentQuestionResponseId)
    {
        try{
        Student_Assessment_Question_Response__c assessmentQuestionResponseRecord = AssessmentQuestionResponseDataService.getAssessmentQuestionResponseById(assessmentQuestionResponseId);
        return AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(assessmentQuestionResponseRecord);     
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentQuestionResponseObject getAssessmentAndQuestionsByAssessmentId(String assessmentQuestionResponseId){
       try{
             AssessmentQuestionResponseObject res = AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(
               AssessmentQuestionResponseDataService.getAssessmentQuestionResponseById(assessmentQuestionResponseId));
             res.questions = AssessmentQuestionController.getAllAssessmentQuestionsByAssessmentId(assessmentQuestionResponseId);
             return res;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
     @AuraEnabled
    public static List<AssessmentQuestionResponseObject> getAssessmentQuestionResponsesByAssessmentResponseId(String assessmentResponseId){
       try{
             List<AssessmentQuestionResponseObject> res = mapMultipleAssessmentQuestionsResponseToAssessmentQuestionResponseObjects(
                 AssessmentQuestionResponseDataService.getStudentAssessmentQuestionResponseByAssessmentResponseId(assessmentResponseId));
             return res;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    
    //update assessment response
    
	@AuraEnabled
    public static void updateQuestionResponseAssessment(String assessmentQuestionResponseData)
    {
        try {
            
            AssessmentQuestionResponseObject updatedAssessmentQuestionResponse = (AssessmentQuestionResponseObject) JSON.deserialize(assessmentQuestionResponseData, AssessmentQuestionResponseObject.class);
            AssessmentQuestionResponseDataService.updateAssessmentQuestionResponse(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(updatedAssessmentQuestionResponse));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //delete assessmentResponse
    
      @AuraEnabled
    public static void deleteAssessmentResponse(String assessmentQuestionResponseId)
    {
        try{
            
            AssessmentQuestionResponseDataService.deleteAssessmentQuestionResponse(assessmentQuestionResponseId); 
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    } 
    
     //HELPER METHODS
    private static List<AssessmentQuestionResponseObject> mapMultipleAssessmentQuestionsResponseToAssessmentQuestionResponseObjects(List<Student_Assessment_Question_Response__c> assessmentQuestionResponses){
        
        List<AssessmentQuestionResponseObject> results = new List<AssessmentQuestionResponseObject>();
        
        for(Student_Assessment_Question_Response__c record: assessmentQuestionResponses){
            results.add(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(record));
        }
        
        return results;
    }


}