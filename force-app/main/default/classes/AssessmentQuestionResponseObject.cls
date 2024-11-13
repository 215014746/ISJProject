public class AssessmentQuestionResponseObject{
    // Fields to store assessment question response details, enabled for Aura to be accessible in Lightning components
    @AuraEnabled
    public String responseId;
    @AuraEnabled
    public String questionResponse;
    @AuraEnabled
    public String assessmentQuestion;
    @AuraEnabled
    public String assessmentResponse;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String questionText;
    @AuraEnabled
    public Decimal responseNumber;
    @AuraEnabled
    public Decimal marks;
    @AuraEnabled
    public Boolean editable;
    // Maps a database record to an AssessmentQuestionResponseObject for use in the application
    public static AssessmentQuestionResponseObject mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(Student_Assessment_Question_Response__c record){
        AssessmentQuestionResponseObject results = new AssessmentQuestionResponseObject();

        // Populate fields from the database record
        results.questionResponse = record.Question_Response__c;
        results.assessmentQuestion = record.Assessment_Question__c;
        results.assessmentResponse = record.Student_Assessment_Response__c;
        results.name = record.Name;
        results.questionText = record.Question_Text__c;
        results.responseNumber = record.Number__c;
        results.responseId = record.Id;
        results.marks = record.Marks__c;
        results.editable = record.editable__c;

        return results;  // Returns a fully populated AssessmentQuestionResponseObject
    }

    // Maps an AssessmentQuestionResponseObject back to a Student_Assessment_Question_Response__c database record
    public static Student_Assessment_Question_Response__c mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(AssessmentQuestionResponseObject record){
        Student_Assessment_Question_Response__c results = new Student_Assessment_Question_Response__c();

        // Populate fields from the AssessmentQuestionResponseObject
        results.Id = record.responseId;
        results.Question_Response__c = record.questionResponse;
        results.Assessment_Question__c = record.assessmentQuestion;
        results.Student_Assessment_Response__c = record.assessmentResponse;
        results.Question_Text__c = record.questionText;
        results.Marks__c = record.marks;

        return results;  // Returns a fully populated database record ready for insertion or update
    }

}