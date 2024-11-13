public with sharing class CourseDataService {

    public static Course__c getCourseById(Id courseId){
        return [Select Id,
                Name,
                Description__c
                FROM Course__c
                WHERE Id =: courseId
                LIMIT 1
        ];
    }

    public static List<Course__c> getAllCourses(){
        return [Select Id,
                Name,
                Description__c
                FROM Course__c
        ];
    }
   
}