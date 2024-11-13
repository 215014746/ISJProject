public class AssessmentQuestionDataService {
    
    public static Assessment_Question__c getAssessmentQuestionById(Id recordId){
       return [Select Id,
               Name,
               Question_text__c,
               Assessment__c,
               Question_number__c
             From Assessment_Question__c 
             Where Id =: recordId
              LIMIT 1];
    }
    
    public static List<Assessment_Question__c> getAssessmentQuestionByAssessmentId(Id assessmentId){
       return [Select Id,
               Name,
               Question_text__c,
               Assessment__c,
               Question_number__c
         From Assessment_Question__c 
         Where Assessment__c =: assessmentId
         Order by Question_number__c
              ];
        
    }
    
    public static Id insertAssessmentQuestion(Assessment_Question__c question){
        insert question;
        return question.Id;
       
    }
    
    public static void updateAssessmentQuestion(Assessment_Question__c question){
        update question;
    }
    
    public static void deleteAssessmentQuestion(Id recordId){
        delete [
            SELECT Id
            FROM Assessment_Question__c
            WHERE Id=: recordId
        ];
    }

}