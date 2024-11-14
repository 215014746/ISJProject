public with sharing class CheckCaseStatusBot {
    
    public class CaseOutput {
        @InvocableVariable(required=true)
        public String caseStatus; 
    }

    public class CaseInput {
        @InvocableVariable(required=true )
        public String caseNumber;
    }

    @InvocableMethod(label='Get Case Status')
    public static List<CaseOutput> getCaseStatus(List<CaseInput> caseInputs){
        Set<String> caseNumbers = new Set<String>();

        for (CaseInput caseIn : caseInputs) {
            caseNumbers.add(caseIn.caseNumber);  
        }

        List<Case> cases = [SELECT Id, CaseNumber, Status FROM Case WHERE CaseNumber IN: caseNumbers];

        Map<String,String> mapNameStatus = new Map<String,String>();
        if (cases.size() > 0) {
            for (case varCase : cases) {
                mapNameStatus.put(varCase.CaseNumber, varCase.Status);
            }
        }

        List<CaseOutput> caseOutputs = new List<CaseOutput>();
        for (CaseInput caseInput : caseInputs) {
            CaseOutput caseOutput = new CaseOutput();

            if (mapNameStatus.containsKey(caseInput.caseNumber)) {
                caseOutput.caseStatus = mapNameStatus.get(caseInput.caseNumber);
            } else {
                caseOutput.caseStatus = 'No Case found';
            }
            caseOutputs.add(caseOutput);
        }

        return caseOutputs;
    }


}