public class AssessmentQuestionResponseDataService {
   
    //getStudentAssessmentResponseByName
    public static Student_Assessment_Question_Response__c getStudentAssessmentQuestionResponseByName(String name){
        return [
            Select Id,
                Assessment_Question__c,
                Question_Response__c,
                Name,
                Student_Assessment_Response__c
            From Student_Assessment_Question_Response__c
            Where Name =: name 
            LIMIT 1];
        
    }
    
    public static List<Student_Assessment_Question_Response__c> getStudentAssessmentQuestionResponseByAssessmentResponseId(Id response){
        return [
            Select Id,
                Assessment_Question__c,
                Question_Response__c,
                Name,
                Student_Assessment_Response__c
            From Student_Assessment_Question_Response__c
            Where Student_Assessment_Response__c =: response 
        ];
        
    }
    
    public static Student_Assessment_Question_Response__c getAssessmentQuestionResponseById(Id recordId){
        return 
            [Select Id,
                Assessment_Question__c,
                Question_Response__c,
                Student_Assessment_Response__c,
                Name
             From Student_Assessment_Question_Response__c
             Where Id =: recordId
             LIMIT 1];
    }
    
    public static void updateAssessmentQuestionResponse(Student_Assessment_Question_Response__c record){
        update record;
    }
    
    public static Id insertAssessmentQuestionResponse(Student_Assessment_Question_Response__c record){
        insert record;
        return record.Id;
    }
    
    public static void deleteAssessmentQuestionResponse(Id record){
        delete [
            SELECT Id
            FROM Case
            WHERE Id=: record
        ];
    }


}