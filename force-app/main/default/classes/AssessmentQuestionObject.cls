public class AssessmentQuestionObject{
    @AuraEnabled
    public String assessmentQuestionId;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String assessment;
    @AuraEnabled
    public String questionText;
    @AuraEnabled
    public Decimal questionNumber;
    
    //Maps an Assessment_Question__c Salesforce object to an AssessmentQuestionObject
    public static AssessmentQuestionObject mapAsssessmentQuestionToAssessmentQuestionObject(Assessment_Question__c question){
        AssessmentQuestionObject results = new AssessmentQuestionObject();
        results.assessmentQuestionId = question.Id;
        results.name = question.Name;
        results.assessment = question.Assessment__c;
        results.questionText = question.Question_text__c;
        results.questionNumber = question.Question_number__c;

        return results;
    }

    //Maps an AssessmentQuestionObject to an Assessment_Question__c Salesforce object
    public static Assessment_Question__c mapAssessmentQuestionObjectToAsssessmentQuestion(AssessmentQuestionObject question){
        Assessment_Question__c results = new Assessment_Question__c();
        results.Id = question.assessmentQuestionId;
        results.Assessment__c = question.assessment;
        results.Question_text__c = question.questionText;
        results.Question_number__c = question.questionNumber;
        return results;
    }

}