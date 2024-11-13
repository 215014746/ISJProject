public with sharing class AssessmentDataService {
    
    public static List<Assessment__c> getAssessmentBySubject(Id subject){
        return [SELECT Id,
            	Description__c,
            	Subject__c,
            	Title__c,
                Assessment_Status__c,
                Due_Date__c
            FROM Assessment__c
            WHERE Subject__c =: subject
        ];
    }
    
    public static Assessment__c getAssessmentById(Id assessmentId){
        return [
            SELECT Id,
            	Description__c,
            	Subject__c,
            	Title__c,
                Assessment_Status__c,
                Due_Date__c
            FROM Assessment__c
            WHERE Id =: assessmentId
            LIMIT 1
        ];
    }
    
    public static Id insertAssessment(Assessment__c record){
        insert record;
        return record.Id;
    }
    
    public static void updateAssessment(Assessment__c record){
        update record;
    }
    
    public static void deleteAssessment(Id recordId){
        delete [
            SELECT Id
            FROM Assessment__c
            WHERE Id =: recordId
        ];
    }

}