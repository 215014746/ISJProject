public with sharing class CourseDataService{
    //Retrieves a specific course record from the database by its ID
    public static Course__c getCourseById(Id courseId){
        return [Select Id, Name, Description__c
                FROM Course__c
                WHERE Id = :courseId
                LIMIT 1];
    }

    //Retrieves a list of all course records from the database
    public static List<Course__c> getAllCourses(){
        return [Select Id, Name, Description__c
                FROM Course__c];
    }

}