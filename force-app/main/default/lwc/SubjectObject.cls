public with sharing class SubjectObject {
    
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

    public static SubjectObject mapSubjectToSubjectObject(Subject__c record){
        SubjectObject results = new SubjectObject();
        results.subjectId = record.Id;
        results.name = record.Name;
        results.description = record.Description__c;
        results.subjectCode = record.Subject_Code__c;
        results.courseId = record.Course__c;
        return results;
    }

    public static Subject__c mapSubjectObjectToSubject(SubjectObject record){
        Subject__c results = new Subject__c();
        results.Id = record.subjectId;
        results.Name = record.name;
        results.Description__c = record.description;
        results.Subject_Code__c = record.subjectCode;
        results.Course__c = record.courseId;
        return results;
    }

    public static List<SubjectObject> mapSubjectsToSubjectObjects(List<Subject__c> records){
        List<SubjectObject> results = new List<SubjectObject>();
        for (Subject__c s : records) {
            results.add(SubjectObject.mapSubjectToSubjectObject(s));
        }
        return results;
    }  

}