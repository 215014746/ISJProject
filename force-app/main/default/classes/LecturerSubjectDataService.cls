public class LecturerSubjectDataService {

    // Retrieves all LecturerSubject records associated with a specific Subject ID
    public static List<LecturerSubject__c> getLecturerBySubject(Id subject) {
        return [SELECT Id, Contact__c, Name, Subject__c
                FROM LecturerSubject__c
                WHERE Subject__c = :subject];
    }

    // Retrieves all LecturerSubject records associated with a specific Contact ID
    public static List<LecturerSubject__c> getLecturerSubjectByContactId(Id contactId) {
        return [SELECT Id, Contact__c, Name, Subject__c
                FROM LecturerSubject__c
                WHERE Contact__c = :contactId];
    }

    // Inserts a new LecturerSubject record and returns the record's ID
    public static Id insertLecturerSubject(LecturerSubject__c record) {
        insert record;
        return record.Id;
    }

    // Updates an existing LecturerSubject record
    public static void updateLecturerSubject(LecturerSubject__c record) {
        update record;
    }

    // Deletes a LecturerSubject record by its ID
    public static void deleteLecturerSubject(Id recordId) {
        delete [SELECT Id
                FROM LecturerSubject__c
                WHERE Id = :recordId];
    }
}
