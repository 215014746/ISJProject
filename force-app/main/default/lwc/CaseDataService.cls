public with sharing class CaseDataService {
    
    public static List<Case> getCasesByOwnerId(Id ownerId){
        
        return [Select Id,
            Reason,
            Description,
            Subject,
            Status,
            OwnerId,
            caseReceiver__c,
            caseOwnerName__c,
            caseReceiverName__c,
            CaseNumber,
            CreatedDate,        
            LecturerComments__c 
         From Case 
         Where OwnerId =: ownerId
       ];
        
    }
    
    public static List<Case> getCasesByCaseReceiverId(Id caseReceiverId){
        
        return [Select Id,
            Reason,
            Description,
            Subject,
            Status,
            OwnerId,
            caseReceiver__c,
            caseOwnerName__c,
            caseReceiverName__c,
            CaseNumber,
            CreatedDate,
            LecturerComments__c 
         From Case 
         Where caseReceiver__c =: caseReceiverId
       ];
        
    }
    
    public static Case getCaseById(Id recordId){
        return [Select Id,
            Reason,
            Description,
            Subject,
            Status,
            OwnerId,
            caseReceiver__c,
            caseOwnerName__c,
            caseReceiverName__c,
            CaseNumber,
            CreatedDate,
            LecturerComments__c 
         From Case 
         Where Id =: recordId
         LIMIT 1];
    }
    
    public static void updateCase(Case caseRecord){
        update caseRecord;
    }
    
    public static Id insertCase(Case caseRecord){
        insert caseRecord;
        return caseRecord.Id;
    }
    
    public static void deleteCase(Id caseId){
        delete [
            SELECT Id
            FROM Case
            WHERE Id=: caseId
        ];
    }

}