public with sharing class LecturerSubjectController{
    // Creates a new LecturerSubject record from JSON input and returns the new record's Id
    @AuraEnabled
    public static Id createLecturerSubject(String LecturerSubjecData){
        try{
            LecturerSubjectObject newLecturerSubject = (LecturerSubjectObject)JSON.deserialize(LecturerSubjecData, LecturerSubjectObject.class);
            Id lecturerSubjectId = LecturerSubjectDataService.insertLecturerSubject(LecturerSubjectObject.mapLecturerSubjectObjectToLecturerSubject(newLecturerSubject));
            return lecturerSubjectId;
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves all LecturerSubjects related to a specific subject ID, caches the result
    @AuraEnabled(cacheable = true)
    public static List<LecturerSubjectObject> getAllByLecturerSubject(String subjectId){
        try{
            return mapMultipleLecturerSubjectsToLecturerSubjectObject(LecturerSubjectDataService.getLecturerBySubject(subjectId));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Retrieves all LecturerSubjects related to the logged-in user’s contact ID, caches the result
    @AuraEnabled(cacheable = true)
    public static List<LecturerSubjectObject> getLecturerByContactId(){
        try{
            return mapMultipleLecturerSubjectsToLecturerSubjectObject(LecturerSubjectDataService.getLecturerSubjectByContactId(CommunityUserDataService.getLoggedInUserContactId()));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Updates an existing LecturerSubject record from JSON input
    @AuraEnabled
    public static void updateLecturerSubject(String lecturerSubjectData){
        try{
            LecturerSubjectObject updatedLecturerSubject = (LecturerSubjectObject)JSON.deserialize(lecturerSubjectData, LecturerSubjectObject.class);
            LecturerSubjectDataService.updateLecturerSubject(LecturerSubjectObject.mapLecturerSubjectObjectToLecturerSubject(updatedLecturerSubject));
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Deletes a LecturerSubject record by Id
    @AuraEnabled
    public static void deleteLecturerSubject(String lecturerSubjectId){
        try{
            LecturerSubjectDataService.deleteLecturerSubject(lecturerSubjectId);
        } catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    // Helper method to map a list of LecturerSubject__c records to a list of LecturerSubjectObject instances
    private static List<LecturerSubjectObject> mapMultipleLecturerSubjectsToLecturerSubjectObject(List<LecturerSubject__c> lecturerSubjects){
        List<LecturerSubjectObject> results = new List<LecturerSubjectObject>();
        for (LecturerSubject__c record : lecturerSubjects){
            results.add(LecturerSubjectObject.mapLecturerSubjectToLecturerSubjectObject(record));
        }
        return results;
    }

}