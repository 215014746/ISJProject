public with sharing class SubjectObject{
    @AuraEnabled
    public String subjectId;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String subjectCode;
    @AuraEnabled
    public String courseId;
    // Maps a Subject__c record to a SubjectObject instance
    public static SubjectObject mapSubjectToSubjectObject(Subject__c record){
        SubjectObject results = new SubjectObject();
        results.subjectId = record.Id;
        results.name = record.Name;
        results.description = record.Description__c;
        results.subjectCode = record.Subject_Code__c;
        results.courseId = record.Course__c;
        return results;
    }

    // Maps a SubjectObject instance back to a Subject__c record for database operations
    public static Subject__c mapSubjectObjectToSubject(SubjectObject record){
        Subject__c results = new Subject__c();
        results.Id = record.subjectId;
        results.Name = record.name;
        results.Description__c = record.description;
        results.Subject_Code__c = record.subjectCode;
        results.Course__c = record.courseId;
        return results;
    }

    // Maps a list of Subject__c records to a list of SubjectObject instances
    public static List<SubjectObject> mapSubjectsToSubjectObjects(List<Subject__c> records){
        List<SubjectObject> results = new List<SubjectObject>();
        for (Subject__c s : records){
            results.add(SubjectObject.mapSubjectToSubjectObject(s));
        }
        return results;
    }

}