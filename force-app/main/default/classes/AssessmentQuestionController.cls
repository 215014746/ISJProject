public class AssessmentQuestionController{
    //Creates a new AssessmentQuestion record
    @AuraEnabled
    public static Id createAssessmentQuestion(String asseessmentQuestionData){
        try{
            AssessmentQuestionObject newQuestion = (AssessmentQuestionObject)JSON.deserialize(asseessmentQuestionData, AssessmentQuestionObject.class);
            Id questionId = AssessmentQuestionDataService.insertAssessmentQuestion(AssessmentQuestionObject.mapAssessmentQuestionObjectToAsssessmentQuestion(newQuestion));
            return questionId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves the question text of a specific assessment question
    @AuraEnabled
    public static Object getQuestionText(String questionId){
        try{
            AssessmentQuestionObject res = AssessmentQuestionObject.mapAsssessmentQuestionToAssessmentQuestionObject(AssessmentQuestionDataService.getAssessmentQuestionById(questionId));

            return res.questionText;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves all assessment questions for a specific assessment ID
    @AuraEnabled
    public static List<AssessmentQuestionObject> getAllAssessmentQuestionsByAssessmentId(String assessmentId){
        try{
            return mapMultipleAssessmentQuestionsToAssessmentQuestionObjects(AssessmentQuestionDataService.getAssessmentQuestionByAssessmentId(assessmentId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves an assessment question by its unique ID
    @AuraEnabled
    public static AssessmentQuestionObject getById(String assessmentQuestionId){
        try{
            Assessment_Question__c assessmentQuestionRecord = AssessmentQuestionDataService.getAssessmentQuestionById(assessmentQuestionId);
            return AssessmentQuestionObject.mapAsssessmentQuestionToAssessmentQuestionObject(assessmentQuestionRecord);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Updates an existing assessment question record
    @AuraEnabled
    public static void updateAsssessmentQuestion(String assessmentQuestionData){
        try{

            AssessmentQuestionObject updatedAssessmentQuestion = (AssessmentQuestionObject)JSON.deserialize(assessmentQuestionData, AssessmentQuestionObject.class);

            AssessmentQuestionDataService.updateAssessmentQuestion(AssessmentQuestionObject.mapAssessmentQuestionObjectToAsssessmentQuestion(updatedAssessmentQuestion));


        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Deletes an assessment question record by its ID
    @AuraEnabled
    public static void deleteAssessmentQuestion(String assessmentQuestionId){
        try{
            AssessmentQuestionDataService.deleteAssessmentQuestion(assessmentQuestionId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Helper method to convert a list of Assessment_Question__c records into AssessmentQuestionObject instances
    private static List<AssessmentQuestionObject> mapMultipleAssessmentQuestionsToAssessmentQuestionObjects(List<Assessment_Question__c> assessmentQuestions){

        List<AssessmentQuestionObject> results = new List<AssessmentQuestionObject>();

        for (Assessment_Question__c record : assessmentQuestions){
            results.add(AssessmentQuestionObject.mapAsssessmentQuestionToAssessmentQuestionObject(record));
        }

        return results;
    }

}