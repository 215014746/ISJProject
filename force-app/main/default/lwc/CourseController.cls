public with sharing class CourseController {
    
    @AuraEnabled
    public static CourseObject getCourseById(String courseId){
        try {
           return CourseObject.mapCourseToCourseObject(CourseDataService.getCourseById(courseId));
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static CourseObject getCourseByIdAndSubjects(String courseId){
        try {
            CourseObject course = CourseObject.mapCourseToCourseObject(CourseDataService.getCourseById(courseId));
            course.subjects = SubjectController.getSubjectsByCourseId(courseId);
            return course;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<CourseObject> getAllCourses(){
        try {
           return CourseObject.mapCoursesToCourseObjects(CourseDataService.getAllCourses());
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}