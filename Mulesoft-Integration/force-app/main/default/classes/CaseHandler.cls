public with sharing class CaseHandler 
{
    public static void afterInsert(List<Case> newCases) 
{
        String casesJson = JSON.serialize(newCases);
        CaseCallout.sendCases(casesJson);
    }
}