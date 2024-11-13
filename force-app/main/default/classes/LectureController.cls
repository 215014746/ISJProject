public class LectureController{
    // This method returns a list of ComboBox objects, each representing a Lecturer with a label (name) and value (id)
    @AuraEnabled
    public static List<ComboBox> getCaseRecievers(){
        List<ComboBox> res = new List<ComboBox>();
        // Loop through each Contact record representing a teacher retrieved from the TeacherDataService
        for (Contact c : TeacherDataService.getLectures()){
            // Add each lecturer's name and ID to the ComboBox list
            res.add(new ComboBox(c.Name, c.Id));
        }

        return res;
    }

    // Inner class ComboBox represents a simple data structure for holding a label-value pair
    public class ComboBox{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
        public ComboBox(String label, String value){
            this.label = label;
            this.value = value;
        }

    }

}