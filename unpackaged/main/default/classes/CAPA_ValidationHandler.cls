public class CAPA_ValidationHandler
{
    //Used for Plan before insert
    public static void beforeInsertValidation(List<CAPA_Plan__c> planList)
    {
        set<id> PlanId = new set<Id>();
        for(CAPA_Plan__c plan : planlist)
        {
            PlanId.add(plan.CAPA__c);
        }
        
        List<CMPL123QMS__CAPA__c> CAPAparent = [select id,CMPL123_WF_Action__c from CMPL123QMS__CAPA__c where id in: planId];
        for(CAPA_Plan__c plan : planList)
        {
            for(CMPL123QMS__CAPA__c CAPA : CAPAparent)
            {
                if(plan.CAPA__c == CAPA.id && CAPA.CMPL123_WF_Action__c == 'Approve')
                {
                    plan.addError('You cannot insert a new record once the CAPA is Approved');
                }
            }
        }
    }
    
    //used for Plan before delete
    public static void deleteInsertValidation(List<CAPA_Plan__c> planList)
    {
        set<id> PlanId = new set<Id>();
        for(CAPA_Plan__c plan : planlist)
        {
            PlanId.add(plan.CAPA__c);
        }
        
        List<CMPL123QMS__CAPA__c> CAPAparent = [select id,CMPL123_WF_Action__c from CMPL123QMS__CAPA__c where id in: planId];
        for(CAPA_Plan__c plan : planList)
        {
            for(CMPL123QMS__CAPA__c CAPA : CAPAparent)
            {
                if(plan.CAPA__c == CAPA.id && CAPA.CMPL123_WF_Action__c == 'Approve')
                {
                    plan.addError('You cannot Delete the record once the CAPA is Approved');
                }
            }
        }
    }
    
    //used for investigation before insert
    public static void beforeInsertValidation_investigation(List<CAPA_Investigation__c> invsgList)
    {
        set<id> invsgId = new set<Id>();
        for(CAPA_Investigation__c inv : invsgList)
        {
            invsgId.add(inv.CAPA__c);
        }
        
        List<CMPL123QMS__CAPA__c> CAPAparent = [select id,CMPL123_WF_Action__c from CMPL123QMS__CAPA__c where id in: invsgId];
        for(CAPA_Investigation__c inv : invsgList)
        {
            for(CMPL123QMS__CAPA__c CAPA : CAPAparent)
            {
                if(CAPA.CMPL123_WF_Action__c != null && CAPA.CMPL123_WF_Action__c != 'Submit for Review - CAPA')
                {
                    inv.addError('You cannot insert a new record');
                }
            }
        }
    }
    
    //used for investigation before delete
    public static void beforeDeleteValidation_investigation(List<CAPA_Investigation__c> invsgList)
    {
        set<id> invsgId = new set<Id>();
        for(CAPA_Investigation__c inv : invsgList)
        {
            invsgId.add(inv.CAPA__c);
        }
        
        List<CMPL123QMS__CAPA__c> CAPAparent = [select id,CMPL123_WF_Action__c from CMPL123QMS__CAPA__c where id in: invsgId];
        for(CAPA_Investigation__c inv : invsgList)
        {
            for(CMPL123QMS__CAPA__c CAPA : CAPAparent)
            {
                if(CAPA.CMPL123_WF_Action__c != 'Submit for Review - CAPA')
                {
                    inv.addError('You cannot delete the existing record');
                }
            }
        }
    }
}