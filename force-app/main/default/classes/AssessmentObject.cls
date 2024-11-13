public with sharing class AssessmentObject{
    //create variables
    @AuraEnabled
    public List<AssessmentQuestionObject> questions;
    @AuraEnabled
    public String assessmentId;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String subject;
    @AuraEnabled
    public String subjectCode;
    @AuraEnabled
    public String title;
    @AuraEnabled
    public String assessmentStatus;
    @AuraEnabled
    public DateTime dueDate;

    //Maps an Assessment__c record to an AssessmentObject instance
    public static AssessmentObject mapAssessmentToAssessmentObject(Assessment__c record){
        AssessmentObject results = new AssessmentObject();
        results.assessmentId = record.Id;
        results.description = record.Description__c;
        results.subject = record.Subject__c;
        results.title = record.Title__c;
        results.assessmentStatus = record.Assessment_Status__c;
        results.dueDate = record.Due_Date__c;
        results.subjectCode = record.Subject_Code__c;

        return results;
    }

    //Maps an AssessmentObject instance to an Assessment__c record
    public static Assessment__c mapAssessmentObjectToAssessment(AssessmentObject record){
        Assessment__c results = new Assessment__c();
        results.Id = record.assessmentId;
        results.Description__c = record.description;
        results.Subject__c = record.subject;
        results.Title__c = record.title;
        results.Assessment_Status__c = record.assessmentStatus;
        results.Due_Date__c = record.dueDate;

        return results;
    }
}