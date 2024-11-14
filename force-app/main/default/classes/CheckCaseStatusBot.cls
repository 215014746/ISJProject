public with sharing class CheckCaseStatusBot {
    
    // Class to define the output structure with case status
    public class CaseOutput {
        @InvocableVariable(required = true)
        public String caseStatus; // Status of the case
    }

    // Class to define the input structure with case number
    public class CaseInput {
        @InvocableVariable(required = true)
        public String caseNumber; // Case number to look up
    }

    // Invocable method to retrieve case statuses based on input case numbers
    @InvocableMethod(label = 'Get Case Status')
    public static List<CaseOutput> getCaseStatus(List<CaseInput> caseInputs) {
        
        // Collect all case numbers from input
        Set<String> caseNumbers = new Set<String>();
        for (CaseInput caseIn : caseInputs) {
            caseNumbers.add(caseIn.caseNumber);
        }

        // Query to fetch cases with matching case numbers
        List<Case> cases = [SELECT Id, CaseNumber, Status
                            FROM Case
                            WHERE CaseNumber IN :caseNumbers];

        // Map to store case number and corresponding status
        Map<String, String> mapNameStatus = new Map<String, String>();
        for (Case varCase : cases) {
            mapNameStatus.put(varCase.CaseNumber, varCase.Status);
        }

        // Prepare output list with case statuses
        List<CaseOutput> caseOutputs = new List<CaseOutput>();
        for (CaseInput caseInput : caseInputs) {
            CaseOutput caseOutput = new CaseOutput();
            // Set status if found, otherwise "No Case found"
            caseOutput.caseStatus = mapNameStatus.containsKey(caseInput.caseNumber)
                                    ? mapNameStatus.get(caseInput.caseNumber)
                                    : 'No Case found';
            caseOutputs.add(caseOutput);
        }

        return caseOutputs; // Return the list of case statuses
    }
}