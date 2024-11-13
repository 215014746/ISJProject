public with sharing class AssessmentResponseDataService{
    // Retrieves a single Assessment Response by Student Number
    public static Student_Assessment_Response__c getAssessmentByStudentNumber(String studentNumber){
        return [SELECT Id, Assessment__c, Name, Student_Name__c, Student_Number__c, Subject_Code__c, Marks__c
                FROM Student_Assessment_Response__c
                WHERE Student_Number__c = :studentNumber
                LIMIT 1];
    }
    // Retrieves an Assessment Response by its Id
    public static Student_Assessment_Response__c getAssessmentResponseById(Id assessmentResponseId){
        return [SELECT Id, Assessment__c, Name, Student_Name__c, Student_Number__c, Subject_Code__c, Marks__c
                FROM Student_Assessment_Response__c
                WHERE Id = :assessmentResponseId
                LIMIT 1];
    }
    // Retrieves all Assessment Responses associated with a given Assessment Id
    public static List<Student_Assessment_Response__c> getAssessmentResponseByAssessmentId(Id assessmentId){
        return [SELECT Id, Assessment__c, Name, Student_Name__c, Student_Number__c, Subject_Code__c, Marks__c
                FROM Student_Assessment_Response__c
                WHERE Assessment__c = :assessmentId];
    }
    // Retrieves all Assessment Responses for a given Assessment Id that were created by the current user
    public static List<Student_Assessment_Response__c> getAssessmentResponseByAssessmentIdAndOwnerId(Id assessmentId){
        return [SELECT Id, Assessment__c, Name, Student_Name__c, Student_Number__c, Subject_Code__c, Marks__c
                FROM Student_Assessment_Response__c
                WHERE Assessment__c = :assessmentId AND CreatedById = :UserInfo.getUserId()];
    }
    //Create a new Assessment Response record and returns its Id
    public static Id insertAssessmentResponse(Student_Assessment_Response__c record){
        try{
            insert record;
        } catch (Exception e){
            System.debug(e.getMessage());
        }

        return record.Id;
    }
    // Updates an existing Assessment Response record
    public static void updateAssessmentResponse(Student_Assessment_Response__c record){
        update record;
    }
    // Deletes an Assessment Response record by Id
    public static void deleteAssessmentResponse(Id recordId){
        delete [SELECT Id
                FROM Student_Assessment_Response__c
                WHERE Id = :recordId];
    }

}