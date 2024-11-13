public class LectureObject{
    //
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String recordId;
    // Maps a single Contact to a LectureObject
    public static LectureObject mapContactToLectureObject(Contact lecture){
        LectureObject r = new LectureObject();
        r.name = lecture.Name;
        r.recordId = lecture.id;

        return r;
    }

    // Maps a list of Contacts to a list of LectureObjects
    public static List<LectureObject> mapMultipleContactsToLectureObjects(List<Contact> lectures){
        List<LectureObject> rs = new List<LectureObject>();

        for (Contact l : lectures){
            rs.add(LectureObject.mapContactToLectureObject(l));
        }

        return rs;
    }

}