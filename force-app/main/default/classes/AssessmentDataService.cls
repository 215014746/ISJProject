public with sharing class AssessmentDataService{
    //Retrieves a list of Assessment__c records based on a specific subject ID
    public static List<Assessment__c> getAssessmentBySubject(Id subject){
        return [SELECT Id, Description__c, Subject__c, Title__c, Assessment_Status__c, Due_Date__c, Subject_Code__c
                FROM Assessment__c
                WHERE Subject__c = :subject];
    }

    //Retrieves a list of Assessment__c records based on a list of subject IDs
    public static List<Assessment__c> getAssessmentsBySubjects(List<Id> subjects){
        return [SELECT Id, Description__c, Subject__c, Title__c, Assessment_Status__c, Due_Date__c, Subject_Code__c
                FROM Assessment__c
                WHERE Subject__c IN:subjects];
    }

    //Retrieves an Assessment__c record based on its unique ID
    public static Assessment__c getAssessmentById(Id assessmentId){
        return [SELECT Id, Description__c, Subject__c, Title__c, Assessment_Status__c, Due_Date__c, Subject_Code__c
                FROM Assessment__c
                WHERE Id = :assessmentId
                LIMIT 1];
    }

    //Create a new Assessment__c record into the database
    public static Id insertAssessment(Assessment__c record){
        insert record;
        return record.Id;
    }

    //Updates an existing Assessment__c record in the database
    public static void updateAssessment(Assessment__c record){
        update record;
    }

    //Deletes an Assessment__c record from the database based on its unique ID
    public static void deleteAssessment(Id recordId){
        delete [SELECT Id
                FROM Assessment__c
                WHERE Id = :recordId];
    }

}