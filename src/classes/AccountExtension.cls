public class AccountExtension {

    
    public Account Acct{get; set;}
    public List<Opportunity> listOpps{get; set;}
    public transient String OppName{get; set;}
    public date OppDate{get; set;}
    public Attachment myAttachment{get; set;}
    public blob AttachmentBody{get; set;}
    public String AttachmentName{get; set;}
    
    public AccountExtension(ApexPages.StandardController stdCtrl){
        List<string> fields = new list<String>();
        fields.add('phone');
        //stdCtrl.addfields(fields);
        Acct = (Account)stdCtrl.getRecord();
        oppName = Acct.Phone;
		myattachment = new Attachment();
        
    }
    
    public pagereference Save(){
        myAttachment.body = AttachmentBody;
        myAttachment.name = AttachmentName;
        if(acct.phone == '' || acct.phone == null){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Please add the phone number'));
            return null;
        }
        insert Acct;
        if(myattachment.body != Null){
            myAttachment.ParentId = Acct.Id;
            insert myAttachment;
        }
        Pagereference pg = new pagereference('/'+Acct.Id);
        return pg;
    }
    public void addOpportunity(){
        
        Opportunity Opp = new Opportunity();
        Opp.AccountId = Acct.Id;
        Opp.Name = OppName;
        Opp.CloseDate = OppDate;
        opp.stageName = 'Prospecting';
        Acct.Name = OppName;
        upsert Opp;
        listOpps = [Select Id, Name, StageName From Opportunity Where AccountId =: Acct.id];

    }
    
}