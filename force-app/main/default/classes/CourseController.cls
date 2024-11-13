public with sharing class CourseController{
    //Retrieves a CourseObject based on the specified Course ID
    @AuraEnabled
    public static CourseObject getCourseById(String courseId){
        // Calls CourseDataService to get the course record by ID and maps it to a CourseObject
        try{
            return CourseObject.mapCourseToCourseObject(CourseDataService.getCourseById(courseId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves a CourseObject based on the specified Course ID, including its associated subjects
    @AuraEnabled
    public static CourseObject getCourseByIdAndSubjects(String courseId){
        try{
            // Retrieves the course by ID and maps it to a CourseObject
            CourseObject course = CourseObject.mapCourseToCourseObject(CourseDataService.getCourseById(courseId));
            // Retrieves and assigns the subjects associated with this course
            course.subjects = SubjectController.getSubjectsByCourseId(courseId);
            return course;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Retrieves the course associated with the currently logged-in student, including its subjects
    @AuraEnabled
    public static CourseObject getStudentCourse(){
        try{
            // Retrieves the logged-in user's contact ID, then retrieves the associated course ID
            String courseId = CommunityUserDataService.getLoggedInUserCourseId(CommunityUserDataService.getLoggedInUserContactId());
            // Retrieves the course by ID and maps it to a CourseObject
            CourseObject course = CourseObject.mapCourseToCourseObject(CourseDataService.getCourseById(courseId));
            // Retrieves and assigns the subjects associated with this course
            course.subjects = SubjectController.getSubjectsByCourseId(courseId);
            return course;
        } catch (Exception e){
            system.debug(e.getStackTraceString());
            throw new AuraHandledException(e.getStackTraceString());
        }
    }

    //Retrieves a list of all courses
    @AuraEnabled
    public static List<CourseObject> getAllCourses(){

        try{
            // Calls CourseDataService to retrieve all courses and maps them to a list of CourseObjects
            return CourseObject.mapCoursesToCourseObjects(CourseDataService.getAllCourses());
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

}