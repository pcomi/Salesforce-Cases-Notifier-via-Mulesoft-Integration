trigger onCase on Case (after insert) 
{
    if(trigger.isAfter && trigger.isInsert) 
    {
        System.debug('After Insert Trigger');
        CaseHandler c = new CaseHandler();
        c.afterInsert(Trigger.new);
    }
}