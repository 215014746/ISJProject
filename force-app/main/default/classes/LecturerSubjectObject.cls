public with sharing class LecturerSubjectObject{
    @AuraEnabled
    public String contactId;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String subject;
    // Maps a LecturerSubject__c record to a LecturerSubjectObject instance
    public static LecturerSubjectObject mapLecturerSubjectToLecturerSubjectObject(LecturerSubject__c record){
        LecturerSubjectObject results = new LecturerSubjectObject();
        results.contactId = record.Contact__c;
        results.name = record.Name;
        results.subject = record.Subject__c;

        return results;
    }

    //Maps a LecturerSubjectObject instance back to a LecturerSubject__c record for database operations
    public static LecturerSubject__c mapLecturerSubjectObjectToLecturerSubject(LecturerSubjectObject record){
        LecturerSubject__c results = new LecturerSubject__c();

        results.Contact__c = record.contactId;
        results.Name = record.name;
        results.Subject__c = record.subject;

        return results;
    }

}