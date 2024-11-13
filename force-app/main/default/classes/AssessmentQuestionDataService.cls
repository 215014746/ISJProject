public class AssessmentQuestionDataService{
    //Retrieves an assessment question by its unique ID
    public static Assessment_Question__c getAssessmentQuestionById(Id recordId){
        return [Select Id, Name, Question_text__c, Assessment__c, Question_number__c
                From Assessment_Question__c
                Where Id = :recordId
                LIMIT 1];
    }

    //Retrieves all assessment questions for a specific assessment, ordered by question number
    public static List<Assessment_Question__c> getAssessmentQuestionByAssessmentId(Id assessmentId){
        return [Select Id, Name, Question_text__c, Assessment__c, Question_number__c
                From Assessment_Question__c
                Where Assessment__c = :assessmentId
                Order by Question_number__c];
    }

    //Inserts a new assessment question record
    public static Id insertAssessmentQuestion(Assessment_Question__c question){
        insert question;
        return question.Id;
    }

    //Updates an existing assessment question record
    public static void updateAssessmentQuestion(Assessment_Question__c question){
        update question;
    }

    //Deletes an assessment question record by its ID
    public static void deleteAssessmentQuestion(Id recordId){
        delete [SELECT Id
                FROM Assessment_Question__c
                WHERE Id = :recordId];
    }

}