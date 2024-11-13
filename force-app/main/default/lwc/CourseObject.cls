public with sharing class CourseObject {

    @AuraEnabled
    public String courseId;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public List<SubjectObject> subjects;
    
    
    public static CourseObject mapCourseToCourseObject(Course__c record){
        CourseObject results = new CourseObject();
        results.courseId = record.Id;
        results.name = record.Name;
        results.description = record.Description__c;
        
        return results; 
    }
    
    //Converts the CourseObject to the Course Database Entity
    public static Course__c mapCourseObjectToCourse(CourseObject record){
        Course__c results = new Course__c();
        results.Id = record.courseId;
        results.Name = record.name;
        results.Description__c = record.description;
        return results;   
    }

    public static List<CourseObject> mapCoursesToCourseObjects(List<Course__c> records){
        List<CourseObject> results = new List<CourseObject>();
        for (Course__c c : records) {
          results.add(CourseObject.mapCourseToCourseObject(c));  
        }
        return results; 
    }
}

