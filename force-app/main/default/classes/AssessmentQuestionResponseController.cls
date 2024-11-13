public class AssessmentQuestionResponseController{
    // Method to create a new Assessment Question Response record from JSON data
    @AuraEnabled
    public static Id createAssessmentQuestionResponse(String assessmentQResponseData){
        try{
            // Deserialize JSON data into AssessmentQuestionResponseObject
            AssessmentQuestionResponseObject newAssessmentQResponse = (AssessmentQuestionResponseObject)JSON.deserialize(assessmentQResponseData, AssessmentQuestionResponseObject.class);
            // Map and insert the new response into the database, returning the new record Id
            Id assessmentQResponseId = AssessmentQuestionResponseDataService.insertAssessmentQuestionResponse(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(newAssessmentQResponse));
            return assessmentQResponseId;
        } catch (Exception e){
            // Throw an exception with the error message
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to create Assessment Question Responses for a given assessment and response Id
    @AuraEnabled
    public static void createAssessmentQuestionResponses(String assessmentId, String assessmentResponseId){
        try{
            List<Student_Assessment_Question_Response__c> questionResponses = new List<Student_Assessment_Question_Response__c>();
            // Loop through all questions associated with the assessment and create response records
            for (AssessmentQuestionObject question : AssessmentQuestionController.getAllAssessmentQuestionsByAssessmentId(assessmentId)){
                AssessmentQuestionResponseObject qR = new AssessmentQuestionResponseObject();
                qR.assessmentQuestion = question.assessmentQuestionId;
                qR.assessmentResponse = assessmentResponseId;
                qR.questionText = question.questionText;

                // Map and add each response to the list
                questionResponses.add(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(qR));
            }

            // Insert all created responses into the database
            AssessmentQuestionResponseDataService.insertAssessmentQuestionResponses(questionResponses);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to update a list of Assessment Question Responses from JSON data
    @AuraEnabled
    public static void saveAssessmentQuestionResponses(String data){
        Object val;
        try{
            List<Student_Assessment_Question_Response__c> questionResponses = new List<Student_Assessment_Question_Response__c>();
            AssessmentResponsesDTO rData = (AssessmentResponsesDTO)JSON.deserialize(data, AssessmentResponsesDTO.class);
            val = rData;
            // Map each response in DTO to a response record
            for (AssessmentQuestionResponseObject qR : rData.responses){
                questionResponses.add(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(qR));
            }

            // Update responses in the database
            AssessmentQuestionResponseDataService.updateAssessmentQuestionResponses(questionResponses);
        } catch (Exception e){
            // Handle errors and include serialized object data for debugging
            throw new AuraHandledException(e.getMessage() + JSON.serializePretty(val) + ' ----' + e.getStackTraceString());
        }
    }

    // Method to retrieve an Assessment Question Response by its name
    @AuraEnabled
    public static AssessmentQuestionResponseObject getStudentAssessmentQuestionResponseByName(String name){
        try{
            // Get the response record by name and map it to the response object
            Student_Assessment_Question_Response__c assessmentQuestionResponseRecord = AssessmentQuestionResponseDataService.getStudentAssessmentQuestionResponseByName(name);
            return AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(assessmentQuestionResponseRecord);
        } catch (Exception e){
            // Handle and throw any errors encountered
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to retrieve an Assessment Question Response by its Id
    @AuraEnabled
    public static AssessmentQuestionResponseObject getAssessmentResponseById(String assessmentQuestionResponseId){
        try{
            // Get the response record by Id and map it to the response object
            Student_Assessment_Question_Response__c assessmentQuestionResponseRecord = AssessmentQuestionResponseDataService.getAssessmentQuestionResponseById(assessmentQuestionResponseId);
            return AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(assessmentQuestionResponseRecord);
        } catch (Exception e){
            // Handle and throw any errors encountered
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to retrieve Assessment and Questions by Assessment Id
    @AuraEnabled
    public static AssessmentQuestionResponseObject getAssessmentAndQuestionsByAssessmentId(String assessmentQuestionResponseId){
        try{
            // Retrieve the assessment response and map it to the response object
            AssessmentQuestionResponseObject res = AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(AssessmentQuestionResponseDataService.getAssessmentQuestionResponseById(assessmentQuestionResponseId));
            return res;
        } catch (Exception e){
            // Handle and throw any errors encountered
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to retrieve Assessment Question Responses by Assessment Response Id
    @AuraEnabled
    public static List<AssessmentQuestionResponseObject> getAssessmentQuestionResponsesByAssessmentResponseId(String assessmentResponseId){
        try{
            // Retrieve responses and map each to the response object
            List<AssessmentQuestionResponseObject> res = mapMultipleAssessmentQuestionsResponseToAssessmentQuestionResponseObjects(AssessmentQuestionResponseDataService.getStudentAssessmentQuestionResponseByAssessmentResponseId(assessmentResponseId));
            return res;
        } catch (Exception e){
            // Handle and throw any errors encountered
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to update an existing Assessment Question Response
    @AuraEnabled
    public static void updateQuestionResponseAssessment(String assessmentQuestionResponseData){
        try{
            // Deserialize JSON data into AssessmentQuestionResponseObject
            AssessmentQuestionResponseObject updatedAssessmentQuestionResponse = (AssessmentQuestionResponseObject)JSON.deserialize(assessmentQuestionResponseData, AssessmentQuestionResponseObject.class);
            // Update the response in the database
            AssessmentQuestionResponseDataService.updateAssessmentQuestionResponse(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseObjectToAssessmentQuestionResponse(updatedAssessmentQuestionResponse));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Method to delete an Assessment Question Response by Id
    @AuraEnabled
    public static void deleteAssessmentResponse(String assessmentQuestionResponseId){
        try{
            // Delete the specified response from the database
            AssessmentQuestionResponseDataService.deleteAssessmentQuestionResponse(assessmentQuestionResponseId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Helper method to map multiple response records to response objects
    private static List<AssessmentQuestionResponseObject> mapMultipleAssessmentQuestionsResponseToAssessmentQuestionResponseObjects(List<Student_Assessment_Question_Response__c> assessmentQuestionResponses){
        List<AssessmentQuestionResponseObject> results = new List<AssessmentQuestionResponseObject>();

        // Map each record to the response object and add it to the results list
        for (Student_Assessment_Question_Response__c record : assessmentQuestionResponses){
            results.add(AssessmentQuestionResponseObject.mapAssessmentQuestionResponseToAssessmentQuestionResponseObject(record));
        }

        return results;
    }

    // DTO class to hold a list of responses for batch processing
    public class AssessmentResponsesDTO{
        List<AssessmentQuestionResponseObject> responses;

    }

}