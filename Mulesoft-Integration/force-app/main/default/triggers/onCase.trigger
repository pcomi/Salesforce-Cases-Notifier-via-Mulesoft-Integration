trigger onCase on Case (after insert) 
{
    if(trigger.isAfter && trigger.isInsert) 
    {
        System.debug('After Insert Trigger');
        CaseHandler.afterInsert(Trigger.new);
    }
}