public class AssessmentResponseController {
    
    @AuraEnabled
    public static Id createAssessmentResponse(String assessmentResponseData)
    {
        try{
            AssessmentResponseObject newAssessmentResponse = (AssessmentResponseObject) JSON.deserialize(assessmentResponseData, AssessmentResponseObject.class);
            Id assessmentResponseId = AssessmentResponseDataService.insertAssessmentResponse(AssessmentResponseObject.mapAssessmentResponseObjectToAssessmentResponse(newAssessmentResponse));
          	return assessmentResponseId;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseByStudentNumber(String studentNumber)
    {
        try{
           Student_Assessment_Response__c assessmentResponseRecord = AssessmentResponseDataService.getAssessmentByStudentNumber(studentNumber);
        return AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord);  
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseById(String assessmentResponseId)
    {
        try{
        Student_Assessment_Response__c assessmentResponseRecord = AssessmentResponseDataService.getAssessmentResponseById(assessmentResponseId);
        return AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord);     
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }

    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseByAssessmentId(String assessmentId)
    {
        try{
        List<Student_Assessment_Response__c> assessmentResponseRecord = AssessmentResponseDataService.getAssessmentResponseByAssessmentIdAndOwnerId(assessmentId);
        return (assessmentResponseRecord.size() > 0)? AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord[0]):null;     
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    }
    
    @AuraEnabled
    public static AssessmentResponseObject getResponeAndQuestionResponseByAssessmentResponseId(String assessmentResponseId){
       try{
             AssessmentResponseObject res = AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(
                 AssessmentResponseDataService.getAssessmentResponseById(assessmentResponseId));
             res.responses = AssessmentQuestionResponseController.getAssessmentQuestionResponsesByAssessmentResponseId(assessmentResponseId);
           
           return res;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //update assessment response
    
	@AuraEnabled
    public static void updateResponseAssessment(String assessmentResponseData)
    {
        try {
            
            AssessmentResponseObject updatedAssessmentResponse = (AssessmentResponseObject) JSON.deserialize(assessmentResponseData, AssessmentResponseObject.class);
            AssessmentResponseDataService.updateAssessmentResponse(AssessmentResponseObject.mapAssessmentResponseObjectToAssessmentResponse(updatedAssessmentResponse));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //delete assessmentResponse
    
      @AuraEnabled
    public static void deleteAssessmentResponse(String assessmentResponseId)
    {
        try{
            AssessmentResponseDataService.deleteAssessmentResponse(assessmentResponseId); 
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        } 
    } 
    
     //HELPER METHODS
    private static List<AssessmentResponseObject> mapMultipleAssessmentsResponseToAssessmentResponseObjects(List<Student_Assessment_Response__c> assessmentResponses){
        
        List<AssessmentResponseObject> results = new List<AssessmentResponseObject>();
        
        for(Student_Assessment_Response__c record: assessmentResponses){
            results.add(AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(record));
        }
        
        return results;
    }
}