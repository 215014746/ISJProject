public class AssessmentQuestionResponseObject {
    @AuraEnabled
    public List<AssessmentQuestionObject> questions;
    @AuraEnabled
    public String questionResponse;
    @AuraEnabled
    public String assessmentQuestion;
    @AuraEnabled
    public String assessmentResponse;
	@AuraEnabled
    public String name;
    
    //mapAssessmentQuestionResponseToAssessmentQuestionResponseObject
    
   public static AssessmentQuestionResponseObject mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(Student_Assessment_Question_Response__c record){
        AssessmentQuestionResponseObject results = new AssessmentQuestionResponseObject();
        results.questionResponse = record.Question_Response__c;
        results.assessmentQuestion = record.Assessment_Question__c;
        results.assessmentResponse = record.Student_Assessment_Response__c;
        results.name = record.Name;
        return results;
    }
    
    //mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse
    
    public static Student_Assessment_Question_Response__c mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(AssessmentQuestionResponseObject record){
        Student_Assessment_Question_Response__c results = new Student_Assessment_Question_Response__c();
        results.Question_Response__c = record.questionResponse;
        results.Assessment_Question__c = record.assessmentQuestion;
        results.Student_Assessment_Response__c = record.assessmentResponse;
        return results;
    }

}