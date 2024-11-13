public with sharing class SubjectController{
    // Retrieves a list of SubjectObjects based on a given Course ID
    @AuraEnabled
    public static List<SubjectObject> getSubjectsByCourseId(String courseId){
        try{
            // Maps and returns a list of Subject__c records related to the course
            return SubjectObject.mapSubjectsToSubjectObjects(SubjectDataService.getSubjectsByCourseId(courseId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves a single SubjectObject by a given Subject Code
    @AuraEnabled
    public static SubjectObject getSubjectBySubjectCode(String subjectCode){
        try{
            // Maps and returns a single Subject__c record matching the subject code
            return SubjectObject.mapSubjectToSubjectObject(SubjectDataService.getSubjectBySubjectCode(subjectCode));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static SubjectObject getSubjectBySubjectId(String subjectId){
        try{
            // Maps and returns a single Subject__c record matching the subject ID
            return SubjectObject.mapSubjectToSubjectObject(SubjectDataService.getSubjectBySubjectId(subjectId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}