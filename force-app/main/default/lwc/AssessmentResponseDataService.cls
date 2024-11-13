public class AssessmentResponseDataService {
    
    public static Student_Assessment_Response__c getAssessmentByStudentNumber(String studentNumber){
        return [SELECT Id,
            	Assessment__c,
                Name,
                Student_Name__c,
                Student_Number__c,
                Subject_Code__c
            FROM Student_Assessment_Response__c
            WHERE Student_Number__c =: studentNumber
            LIMIT 1
        ];
    }
  
    public static Student_Assessment_Response__c getAssessmentResponseById(Id assessmentResponseId){
        return [
            SELECT Id,
            	Assessment__c,
                Name,
                Student_Name__c,
                Student_Number__c,
                Subject_Code__c
            FROM Student_Assessment_Response__c
            WHERE Id =: assessmentResponseId
            LIMIT 1
        ];
    }

    public static List<Student_Assessment_Response__c> getAssessmentResponseByAssessmentIdAndOwnerId(Id assessmentId){
        return [
            SELECT Id,
            	Assessment__c,
                Name,
                Student_Name__c,
                Student_Number__c,
                Subject_Code__c
            FROM Student_Assessment_Response__c
            WHERE Assessment__c =: assessmentId
            AND CreatedById =: UserInfo.getUserId()
            
        ];
    }
    
    public static Id insertAssessmentResponse(Student_Assessment_Response__c record){
        try{insert record;}catch(Exception e){ System.debug(e.getMessage());}
        
        return record.Id;
    }
    
    public static void updateAssessmentResponse(Student_Assessment_Response__c record){
        update record;
    }
    
    public static void deleteAssessmentResponse(Id recordId){
        delete [
            SELECT Id
            FROM Student_Assessment_Response__c
            WHERE Id =: recordId
        ];
    }

}