public with sharing class AssessmentResponseController{
    // Creates a new Assessment Response record from the provided JSON data
    @AuraEnabled
    public static Id createAssessmentResponse(String assessmentResponseData){
        try{
            // Deserialize JSON data to an AssessmentResponseObject instance
            AssessmentResponseObject newAssessmentResponse = (AssessmentResponseObject)JSON.deserialize(assessmentResponseData, AssessmentResponseObject.class);

            // Insert the Assessment Response record and get the newly created Id
            Id assessmentResponseId = AssessmentResponseDataService.insertAssessmentResponse(AssessmentResponseObject.mapAssessmentResponseObjectToAssessmentResponse(newAssessmentResponse));

            // Create associated Assessment Question Responses for the new Assessment Response
            AssessmentQuestionResponseController.createAssessmentQuestionResponses(newAssessmentResponse.assessmentId, assessmentResponseId);
            return assessmentResponseId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves an Assessment Response by Student Number
    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseByStudentNumber(String studentNumber){
        try{
            Student_Assessment_Response__c assessmentResponseRecord = AssessmentResponseDataService.getAssessmentByStudentNumber(studentNumber);
            return AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves an Assessment Response by Id
    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseById(String assessmentResponseId){
        try{
            Student_Assessment_Response__c assessmentResponseRecord = AssessmentResponseDataService.getAssessmentResponseById(assessmentResponseId);
            return AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves all Student Responses associated with a specific Assessment Id
    @AuraEnabled(cacheable = true)
    public static List<AssessmentResponseObject> getStudentResponses(String assessmentId){
        try{
            List<Student_Assessment_Response__c> assessmentResponses = AssessmentResponseDataService.getAssessmentResponseByAssessmentId(assessmentId);
            return mapMultipleAssessmentsResponseToAssessmentResponseObjects(assessmentResponses);
        } catch (Exception e){
            System.debug('Error fetching student responses: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves an Assessment Response by Assessment Id and the current user as the owner
    @AuraEnabled
    public static AssessmentResponseObject getAssessmentResponseByAssessmentId(String assessmentId){
        try{
            List<Student_Assessment_Response__c> assessmentResponseRecord = AssessmentResponseDataService.getAssessmentResponseByAssessmentIdAndOwnerId(assessmentId);
            return (assessmentResponseRecord.size() > 0) ? AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(assessmentResponseRecord[0]) : null;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves an Assessment Response and its associated Question Responses by Assessment Response Id
    @AuraEnabled
    public static AssessmentResponseObject getResponeAndQuestionResponseByAssessmentResponseId(String assessmentResponseId){
        try{
            // Map the main Assessment Response record
            AssessmentResponseObject res = AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(AssessmentResponseDataService.getAssessmentResponseById(assessmentResponseId));

            // Retrieve and set the associated Question Responses
            res.responses = AssessmentQuestionResponseController.getAssessmentQuestionResponsesByAssessmentResponseId(assessmentResponseId);
            return res;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Updates an existing Assessment Response with new data
    @AuraEnabled
    public static void updateResponseAssessment(String assessmentResponseData){
        try{
            // Deserialize the input JSON data to an AssessmentResponseObject instance
            AssessmentResponseObject updatedAssessmentResponse = (AssessmentResponseObject)JSON.deserialize(assessmentResponseData, AssessmentResponseObject.class);

            // Update the Assessment Response record in the database
            AssessmentResponseDataService.updateAssessmentResponse(AssessmentResponseObject.mapAssessmentResponseObjectToAssessmentResponse(updatedAssessmentResponse));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Deletes a specific Assessment Response by Id
    @AuraEnabled
    public static void deleteAssessmentResponse(String assessmentResponseId){
        try{
            AssessmentResponseDataService.deleteAssessmentResponse(assessmentResponseId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Helper Method: Maps a list of Student Assessment Response records to AssessmentResponseObjects
    private static List<AssessmentResponseObject> mapMultipleAssessmentsResponseToAssessmentResponseObjects(List<Student_Assessment_Response__c> assessmentResponses){
        List<AssessmentResponseObject> results = new List<AssessmentResponseObject>();

        // Iterate through each database record and convert it to an AssessmentResponseObject
        for (Student_Assessment_Response__c record : assessmentResponses){
            results.add(AssessmentResponseObject.mapAssessmentResponseToAssessmentResponseObject(record));
        }

        return results;  // Return the list of AssessmentResponseObjects
    }

}