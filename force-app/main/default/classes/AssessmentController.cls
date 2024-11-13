public with sharing class AssessmentController{
    //Creates a new Assessment record.
    @AuraEnabled
    public static Id createAssessment(String assessmentData){
        try{
            AssessmentObject newAssessment = (AssessmentObject)JSON.deserialize(assessmentData, AssessmentObject.class);
            Id assessmentId = AssessmentDataService.insertAssessment(AssessmentObject.mapAssessmentObjectToAssessment(newAssessment));
            return assessmentId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves all assessments for a given subject
    @AuraEnabled(cacheable = true)
    public static List<AssessmentObject> getAllBySubject(String subject){
        try{
            return mapMultipleAssessmentsToAssessmentObjects(AssessmentDataService.getAssessmentBySubject(subject));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves all assessments for the currently enrolled student's subjects
    @AuraEnabled(cacheable = true)
    public static List<AssessmentObject> getAllStudentsAssessments(){
        try{
            CourseObject sCourse = CourseController.getStudentCourse();
            List<SubjectObject> subjects = SubjectController.getSubjectsByCourseId(sCourse.courseId);

            List<String> subjectIds = new List<String>();

            for (SubjectObject subject : subjects){
                subjectIds.add(subject.subjectId);
            }

            return mapMultipleAssessmentsToAssessmentObjects(AssessmentDataService.getAssessmentsBySubjects(subjectIds));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves an assessment by its unique ID
    @AuraEnabled(cacheable = true)
    public static AssessmentObject getAssessmentById(String assessmentId){
        try{
            Assessment__c assessmentRecord = AssessmentDataService.getAssessmentById(assessmentId);
            return AssessmentObject.mapAssessmentToAssessmentObject(assessmentRecord);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves an assessment and its related questions by the assessment ID
    @AuraEnabled(cacheable = true)
    public static AssessmentObject getAssessmentAndQuestionsByAssessmentId(String assessmentId){
        try{
            AssessmentObject res = AssessmentObject.mapAssessmentToAssessmentObject(AssessmentDataService.getAssessmentById(assessmentId));

            if (res == null){
                throw new AuraHandledException('No assessment found for the given ID.');
            }
            res.questions = AssessmentQuestionController.getAllAssessmentQuestionsByAssessmentId(assessmentId);

            return res;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Updates an existing assessment record
    @AuraEnabled
    public static void updateAssessment(String assessmentData){
        try{

            AssessmentObject updatedAssessment = (AssessmentObject)JSON.deserialize(assessmentData, AssessmentObject.class);
            AssessmentDataService.updateAssessment(AssessmentObject.mapAssessmentObjectToAssessment(updatedAssessment));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Deletes an assessment record by its ID
    @AuraEnabled
    public static void deleteAssessment(String assessmentId){
        try{
            AssessmentDataService.deleteAssessment(assessmentId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Helper method to convert a list of Assessment__c records into AssessmentObject instances
    private static List<AssessmentObject> mapMultipleAssessmentsToAssessmentObjects(List<Assessment__c> assessments){

        List<AssessmentObject> results = new List<AssessmentObject>();

        for (Assessment__c record : assessments){
            results.add(AssessmentObject.mapAssessmentToAssessmentObject(record));
        }

        return results;
    }
}