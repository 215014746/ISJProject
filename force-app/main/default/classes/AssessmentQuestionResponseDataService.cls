public class AssessmentQuestionResponseDataService{
    // Retrieves a single Student Assessment Question Response by Name
    public static Student_Assessment_Question_Response__c getStudentAssessmentQuestionResponseByName(String name){
        return [SELECT Id, Assessment_Question__c, Question_Response__c, Name, Number__c, Question_Text__c, Student_Assessment_Response__c, Marks__c, editable__c
                FROM Student_Assessment_Question_Response__c
                WHERE Name = :name
                LIMIT 1];
    }

    // Retrieves all Student Assessment Question Responses associated with a specific Assessment Response Id
    public static List<Student_Assessment_Question_Response__c> getStudentAssessmentQuestionResponseByAssessmentResponseId(Id response){
        return [SELECT Id, Assessment_Question__c, Question_Response__c, Name, Number__c, Question_Text__c, Student_Assessment_Response__c, Marks__c, editable__c
                FROM Student_Assessment_Question_Response__c
                WHERE Student_Assessment_Response__c = :response];
    }

    // Retrieves a single Student Assessment Question Response by its Id
    public static Student_Assessment_Question_Response__c getAssessmentQuestionResponseById(Id recordId){
        return [SELECT Id, Assessment_Question__c, Question_Response__c, Student_Assessment_Response__c, Name, Number__c, Question_Text__c, Marks__c, editable__c
                FROM Student_Assessment_Question_Response__c
                WHERE Id = :recordId
                LIMIT 1];
    }

    // Updates an existing Assessment Question Response record in the database
    public static void updateAssessmentQuestionResponse(Student_Assessment_Question_Response__c record){
        update record;
    }

    // Inserts a new Assessment Question Response record into the database and returns the new record's Id
    public static Id insertAssessmentQuestionResponse(Student_Assessment_Question_Response__c record){
        insert record;
        return record.Id;
    }

    // Inserts multiple Assessment Question Response records into the database
    public static void insertAssessmentQuestionResponses(List<Student_Assessment_Question_Response__c> records){
        insert records;
    }

    // Updates multiple Assessment Question Response records in the database
    public static void updateAssessmentQuestionResponses(List<Student_Assessment_Question_Response__c> records){
        update records;
    }

    // Deletes a specific Assessment Question Response record by its Id
    public static void deleteAssessmentQuestionResponse(Id record){
        delete [SELECT Id
                FROM Student_Assessment_Question_Response__c
                WHERE Id = :record];
    }

}