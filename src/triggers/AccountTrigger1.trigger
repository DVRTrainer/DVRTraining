trigger AccountTrigger1 on Account (before insert, after update, after insert, before update, before delete) {
    if(Label.AccountTrigger == 'False'){
    helloworld.hello();
    List<String> AccountIdList = new List<String>();
    if(trigger.isupdate && trigger.isbefore)
    for(Account a: Trigger.new){
        if(trigger.oldMap.get(a.Id).billingpostalcode != trigger.newmap.get(a.Id).billingpostalcode){
            //a.adderror('Postal Code can\'t be changed');
            trigger.newmap.get(a.Id).billingpostalcode = trigger.oldMap.get(a.Id).billingpostalcode;
            //trigger.oldmap = Map<Id, Account>
            //trigger.newMap = Map<Id, Account> 
            String S = Label.AccountTrigger;
        }
    }
    if(!system.isBatch())
    ItisaSampleClass.updateOpportunities(AccountIdList);
    }
}