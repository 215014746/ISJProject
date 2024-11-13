public with sharing class CaseDataService{
    //Retrieves a list of Case records based on the Owner's Id
    public static List<Case> getCasesByOwnerId(Id ownerId){

        return [Select Id, Reason, Description, Subject, Status, OwnerId, caseReceiver__c, caseOwnerName__c, caseReceiverName__c, CaseNumber, CreatedDate, LecturerComments__c
                From Case
                Where OwnerId = :ownerId];
    }

    //Retrieves a list of Case records based on the case receiver's Id
    public static List<Case> getCasesByCaseReceiverId(Id caseReceiverId){

        return [Select Id, Reason, Description, Subject, Status, OwnerId, caseReceiver__c, caseOwnerName__c, caseReceiverName__c, CaseNumber, CreatedDate, LecturerComments__c
                From Case
                Where caseReceiver__c = :caseReceiverId];
    }

    // Retrieves a single Case record based on its Id
    public static Case getCaseById(Id recordId){
        return [Select Id, Reason, Description, Subject, Status, OwnerId, caseReceiver__c, caseOwnerName__c, caseReceiverName__c, CaseNumber, CreatedDate, LecturerComments__c
                From Case
                Where Id = :recordId
                LIMIT 1];
    }

    //Updates an existing Case record in the database
    public static void updateCase(Case caseRecord){
        update caseRecord;
    }

    //Create a new Case record into the database
    public static Id insertCase(Case caseRecord){
        insert caseRecord;
        return caseRecord.Id;
    }

    //Deletes an existing Case record from the database based on its Id
    public static void deleteCase(Id caseId){
        delete [SELECT Id
                FROM Case
                WHERE Id = :caseId];
    }

}