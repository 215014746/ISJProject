public with sharing class SubjectDataService {
    
    public static List<Subject__c> getSubjectsByCourseId(Id courseId){
        return [Select Id,
                Name,
                Description__c,
                Subject_Code__c,
                Course__c
                FROM Subject__c
                WHERE Course__c =: courseId
                ];
            }

     public static Subject__c getSubjectBySubjectCode(String subjectCode){
        return [Select Id,
                Name,
                Description__c,
                Subject_Code__c,
                Course__c
                FROM Subject__c
                WHERE Subject_Code__c =: subjectCode
                LIMIT 1];
     }

     public static Subject__c getSubjectBySubjectId(String subjectId){
        return [Select Id,
                Name,
                Description__c,
                Subject_Code__c,
                Course__c
                FROM Subject__c
                WHERE Id =: subjectId
                LIMIT 1];
     }
}