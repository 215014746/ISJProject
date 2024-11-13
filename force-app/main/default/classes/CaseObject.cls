public with sharing class CaseObject{
    @AuraEnabled
    public String caseReason;
    @AuraEnabled
    public String caseID;
    @AuraEnabled
    public String caseNumber;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String subject;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public String caseOwner;
    @AuraEnabled
    public String caseReceiver;
    @AuraEnabled
    public String caseOwnerName;
    @AuraEnabled
    public String caseReceiverName;
    @AuraEnabled
    public String comment;
    @AuraEnabled
    public Datetime createdDate;
    //Converts the CaseObject to the Case Database Entity
    public static CaseObject mapCaseToCaseObject(Case record){
        CaseObject results = new CaseObject();
        results.caseID = record.Id;
        results.caseReason = record.Reason;
        results.description = record.Description;
        results.subject = record.Subject;
        results.status = record.Status;
        results.caseOwner = record.OwnerId;
        results.caseReceiver = record.caseReceiver__c;
        results.caseReceiverName = record.caseReceiverName__c;
        results.caseOwnerName = record.caseOwnerName__c;
        results.caseNumber = record.CaseNumber;
        results.createdDate = record.CreatedDate;
        results.comment = record.LecturerComments__c;

        return results;
    }

    //Converts the CaseObject to the Case Database Entity
    public static Case mapCaseObjectToCase(CaseObject record){
        Case results = new Case();
        results.Id = record.caseID;
        results.Reason = record.caseReason;
        results.Description = record.description;
        results.subject = record.Subject;
        results.status = record.Status;
        results.caseReceiver__c = record.caseReceiver;
        results.LecturerComments__c = record.comment;

        return results;
    }

}