// Second class for creating the case
public class CaseCreationService {
    @InvocableMethod(label='Create Case' description='Creates a new case with specified fields')
    public static List<Case> createCase(List<CaseRequest> requests) {
        List<Case> createdCases = new List<Case>();
        
        for (CaseRequest req : requests) {
            Case newCase = new Case(
                Subject = req.subject,
                Description = req.description,
                Reason = req.caseReason,
                ContactId = req.caseReceiverId
            );
            
            createdCases.add(newCase);
        }
        
        if (!createdCases.isEmpty()) {
            try {
                insert createdCases;
            } catch (DmlException e) {
                System.debug('Error creating case: ' + e.getMessage());
            }
        }
        
        return createdCases;
    }
    
    public class CaseRequest {
        @InvocableVariable(required=true label='Subject')
        public String subject;
        
        @InvocableVariable(required=true label='Description')
        public String description;
        
        @InvocableVariable(required=true label='Case Reason')
        public String caseReason;
        
        @InvocableVariable(required=true label='Case Receiver Id')
        public Id caseReceiverId;
    }
}