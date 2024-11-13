@IsTest(seeAllData=False)
public class AssessmentIntegrationTest 
{
	@TestSetup
    static void setup()
    {
        Department__c department = TestDataFactory.generateDepartment('SETUP DETAPRTMENT');
        insert department;
        
        Course__c course = TestDataFactory.generateCourse('SETUP COURSE', department.Id);
        insert course;
        
        Subject__c subject = TestDataFactory.generateSubject('SETUP SUBJECT', course.Id);
        insert subject;
        
        Assessment__c assessment = TestDataFactory.generateAssessment('SETUP ASSESSMENT', subject.Id);
        insert assessment;
        
        List<String> questions = new List<String>{
            'What is your name ?',
            'What is your surname ?',
            'What is your course ?'
        };
            
        List<Assessment_Question__c> assessmentQuestions = new List<Assessment_Question__c>();
            
        for(String question: questions) {
            assessmentQuestions.add(TestDataFactory.generateAssessmentQuestion(question,assessment.Id));
        }
        
        insert assessmentQuestions;
        
        insert TestDataFactory.generateAssessmentResponse('TestStudent', '123456', assessment.Id, 'assessmentName');
    }
    
    @IsTest
    static void testCreateAssessment(){
        
        AssessmentObject assessmentObj = new AssessmentObject();
        assessmentObj.description = 'Description';
        assessmentObj.subject = [SELECT Id FROM Subject__c LIMIT 1].Id ;
        assessmentObj.title = 'Title';
        assessmentObj.assessmentStatus = 'Not Started';
        assessmentObj.dueDate = System.now();
        
        String assessmentData = JSON.serialize(assessmentObj);
        
        Id assessmentId = AssessmentController.createAssessment(assessmentData);
        System.assert(assessmentId != null, 'Method failed Id is null');
    }
    
    @IsTest
    static void testGetAssessmentsBySubject(){
        Id subjectId = [SELECT Id FROM Subject__c LIMIT 1].Id;
        List<AssessmentObject> results = AssessmentController.getAllBySubject(subjectId);

        System.assert(results.size() >= 1, 'Method failed assessments must be greater than zero or equal to 1');
    }
    
    @IsTest
    static void testGetAssessmentById(){
        Assessment__c assessment = [SELECT Id,Title__c FROM Assessment__c WHERE Title__c = 'SETUP ASSESSMENT' LIMIT 1];
        AssessmentObject results = AssessmentController.getAssessmentById(assessment.Id);

        System.assert(results.title == assessment.Title__c, 'Method failed Title name doesn\'t match');
    }
    
    @IsTest
    static void testGetAssessmentAndQuestionsByAssessmentId(){
        Id assessmentId = [SELECT Id FROM Assessment__c WHERE Title__c = 'SETUP ASSESSMENT' LIMIT 1].Id;
        AssessmentObject results = AssessmentController.getAssessmentAndQuestionsByAssessmentId(assessmentId);

        System.assert(results != null, 'Method failed assessment not found');
        System.assert(results.questions.size() > 0, 'Method failed questions must be greater than zero');
    }
    
    @IsTest
    static void testUpdateAssessment(){
        Assessment__c assessment = [SELECT Id,Title__c,Description__c FROM Assessment__c WHERE Title__c = 'SETUP ASSESSMENT' LIMIT 1];
        AssessmentObject results = AssessmentController.getAssessmentById(assessment.Id);
        results.title = 'Updated Title';
        
        AssessmentController.updateAssessment(JSON.serialize(results));
        
        Assessment__c assessment2 = [SELECT Id,Title__c,Description__c FROM Assessment__c WHERE Title__c = 'Updated Title' LIMIT 1];

        System.assert(results.title == assessment2.Title__c, 'Method failed to update, Title name doesn\'t match.');
    }
    
    @IsTest
    static void testDeleteAssessment(){
        Assessment__c assessment = [SELECT Id,Title__c,Description__c FROM Assessment__c WHERE Title__c = 'SETUP ASSESSMENT' LIMIT 1];
        AssessmentController.deleteAssessment(assessment.Id);
        Boolean foundException = false;
        try {
            Assessment__c assessment2 = [SELECT Id,Title__c,Description__c FROM Assessment__c WHERE Title__c = 'SETUP ASSESSMENT' LIMIT 1];
        }
        catch(Exception e){
            foundException = true;
        }
        
        System.assert(foundException == True, 'Method failed to delete, Assessment was found after deleting.');
    }
    
    //----------------------------RESPONSE
    
    @IsTest
    static void testCreateAssessmentResponse(){
        
        AssessmentResponseObject assessmentResponseObj = new AssessmentResponseObject();
        assessmentResponseObj.assessmentId = [SELECT Id FROM Assessment__c LIMIT 1].Id;
        assessmentResponseObj.subjectCode = 'SMT-123';
        assessmentResponseObj.assessmentName = 'Title';
        assessmentResponseObj.studentName = 'StudentTest';
        assessmentResponseObj.studentNumber = '123456';
        
        String assessmentResponseData = JSON.serialize(assessmentResponseObj);
        
        Id assessmentResponseId = AssessmentResponseController.createAssessmentResponse(assessmentResponseData);
        
        AssessmentQuestionResponseObject questionResponse1 = new AssessmentQuestionResponseObject();
        questionResponse1.questionResponse = 'Response';
        questionResponse1.assessmentResponse = assessmentResponseId;
        questionResponse1.assessmentQuestion = [SELECT Id FROM Assessment_Question__c LIMIT 1].Id;
        
        Id questionResponse1Id = AssessmentQuestionResponseController.createAssessmentQuestionResponse(JSON.serialize(questionResponse1));
        
        AssessmentResponseObject responseAndQuestionResponses = AssessmentResponseController.getResponeAndQuestionResponseByAssessmentResponseId(assessmentResponseId);
        
        System.assert(assessmentResponseId != null, 'Method failed Response Id is null');
        System.assert(questionResponse1Id != null, 'Method failed Question Response Id is null');
        System.assert(responseAndQuestionResponses.studentNumber == '123456', 'Method failed Student number do not match');
        System.assert(responseAndQuestionResponses.responses.size() >0, 'Method failed must have atleast one response');
        System.debug(JSON.serializePretty(responseAndQuestionResponses));
    }
    
    @IsTest
    static void testCreateAssessmentResponseAndQuestionResponses(){
        
        AssessmentResponseObject assessmentResponseObj = new AssessmentResponseObject();
        assessmentResponseObj.assessmentId = [SELECT Id FROM Assessment__c LIMIT 1].Id;
        assessmentResponseObj.subjectCode = 'SMT-123';
        assessmentResponseObj.assessmentName = 'Title';
        assessmentResponseObj.studentName = 'StudentTest';
        assessmentResponseObj.studentNumber = '123456';
        
        String assessmentResponseData = JSON.serialize(assessmentResponseObj);
        
        Id assessmentResponseId = AssessmentResponseController.createAssessmentResponse(assessmentResponseData);
        
        
        System.assert(assessmentResponseId != null, 'Method failed Id is null');
    }
    
    @IsTest
    static void testGetAssessmentResponseByStudentNumber(){
        String studentNumber = [SELECT Id,Student_Number__c FROM Student_Assessment_Response__c LIMIT 1].Student_Number__c;
        AssessmentResponseObject results = AssessmentResponseController.getAssessmentResponseByStudentNumber(studentNumber);

        System.assert(results != null, 'Method failed assessment response must not be null');
    }
    
    @IsTest
    static void testGetAssessmentResponseById(){
        String responseId = [SELECT Id,Student_Number__c FROM Student_Assessment_Response__c LIMIT 1].Id;
        AssessmentResponseObject results = AssessmentResponseController.getAssessmentResponseById(responseId);

        System.assert(results != null, 'Method failed assessment response must not be null');
    }
}