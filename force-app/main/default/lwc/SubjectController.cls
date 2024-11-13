public with sharing class SubjectController {
    @AuraEnabled
    public static List<SubjectObject> getSubjectsByCourseId(String courseId){
        try {
            return SubjectObject.mapSubjectsToSubjectObjects(SubjectDataService.getSubjectsByCourseId(courseId));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static SubjectObject getSubjectBySubjectCode(String subjectCode){
        try {
            return SubjectObject.mapSubjectToSubjectObject(SubjectDataService.getSubjectBySubjectCode(subjectCode));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static SubjectObject getSubjectBySubjectId(String subjectId){
        try {
            return SubjectObject.mapSubjectToSubjectObject(SubjectDataService.getSubjectBySubjectId(subjectId));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}