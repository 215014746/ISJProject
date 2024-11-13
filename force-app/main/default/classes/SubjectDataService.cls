public with sharing class SubjectDataService{
    // Retrieves a list of Subject__c records associated with a given Course ID
    public static List<Subject__c> getSubjectsByCourseId(Id courseId){
        return [SELECT Id, Name, Description__c, Subject_Code__c, Course__c
                FROM Subject__c
                WHERE Course__c = :courseId];
    }

    // Retrieves a single Subject__c record based on a unique Subject Code
    public static Subject__c getSubjectBySubjectCode(String subjectCode){
        return [SELECT Id, Name, Description__c, Subject_Code__c, Course__c
                FROM Subject__c
                WHERE Subject_Code__c = :subjectCode
                LIMIT 1];
    }

    // Retrieves a single Subject__c record based on its unique Subject ID
    public static Subject__c getSubjectBySubjectId(String subjectId){
        return [SELECT Id, Name, Description__c, Subject_Code__c, Course__c
                FROM Subject__c
                WHERE Id = :subjectId
                LIMIT 1];
    }

}