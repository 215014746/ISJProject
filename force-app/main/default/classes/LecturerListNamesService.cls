public with sharing class LecturerListNamesService {
    @InvocableMethod(label='Get Lecturers' description='Fetches list of Lecturers for Einstein Bot')
    public static List<String> getLecturers() {
        // Fetch Contacts with occupation 'Lecturer'
        List<Contact> lecturers = [SELECT Name FROM Contact WHERE Occupation__c = 'Lecturer' ORDER BY Name LIMIT 1000];

        // Convert the list of Contacts to a list of Strings (Lecturer Names)
        List<String> lecturerNames = new List<String>();
        for(Contact lecturer : lecturers) {
            lecturerNames.add(lecturer.Name);
        }

        return lecturerNames;
    }
}