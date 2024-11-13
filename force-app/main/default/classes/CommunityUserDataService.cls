public class CommunityUserDataService{
    //Retrieves the contact ID of the currently logged-in user
    public static String getLoggedInUserContactId(){
        //Query to get the contact ID associated with the currently logged-in user
        User u = [SELECT contactId
                  FROM User
                  WHERE Id = :userInfo.getUserId()];
        return u.contactId;
    }

    // Retrieves the Course ID associated with a given contact
    public static String getLoggedInUserCourseId(String contactId){
        // Query to get the Course ID from the Contact record using the contact ID
        Contact c = [SELECT Course__c
                     FROM Contact
                     WHERE Id = :contactId];
        return c.Course__c;
    }

    //Retrieves the student number and name of the currently logged-in user
    @AuraEnabled
    public static Map<String, String> getLoggedInUserStudentNumberAndName(){
        // Query to get the Student Number and Name from the Contact record of the logged-in user
        Contact c = [SELECT Student_Number__c, Name
                     FROM Contact
                     WHERE Id = :CommunityUserDataService.getLoggedInUserContactId()];
        // Create a map to store and return the student number and name
        Map<String, String> studentData = new Map<String, String>();
        studentData.put('studentNumber', c.Student_Number__c);
        studentData.put('name', c.Name);
        return studentData;
    }

}