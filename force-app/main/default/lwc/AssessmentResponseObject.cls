public class AssessmentResponseObject {
    
    @AuraEnabled
    public List<AssessmentQuestionResponseObject> responses;
    @AuraEnabled
    public String assessmentId;
    @AuraEnabled
    public String assessmentResponseId;
    @AuraEnabled
    public String assessmentName;
    @AuraEnabled
    public String subjectCode;
	@AuraEnabled
    public String studentName;
    @AuraEnabled
    public String studentNumber;
    
   //mapAssessmentResponseToAssessmentResponseObject
   public static AssessmentResponseObject mapAssessmentResponseToAssessmentResponseObject(Student_Assessment_Response__c record){
        AssessmentResponseObject results = new AssessmentResponseObject();
        results.assessmentResponseId = record.Id;
        results.assessmentId = record.Assessment__c;
        results.assessmentName = record.Name;
        results.subjectCode = record.Subject_Code__c;
        results.studentName = record.Student_Name__c;
        results.studentNumber = record.Student_Number__c;
        return results;
    }
    
    //mapAssessmentResponseObjectToAssessmentResponse
    
    public static Student_Assessment_Response__c mapAssessmentResponseObjectToAssessmentResponse(AssessmentResponseObject record){
        Student_Assessment_Response__c results = new Student_Assessment_Response__c();
        results.Id = record.assessmentResponseId;
        results.Assessment__c = record.assessmentId;
        results.Name = record.assessmentName;
        results.Subject_Code__c = record.subjectCode;
        results.Student_Name__c = record.studentName;
        results.Student_Number__c = record.studentNumber;
        return results;
    }
}