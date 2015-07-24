public class AccountExtension {

    public Account Acct{get; set;}
    public List<Opportunity> listOpps{get; set;}
    public String OppName{get; set;}
    public date OppDate{get; set;}
    
    public AccountExtension(ApexPages.StandardController stdCtrl){
        List<string> fields = new list<String>();
        fields.add('phone');
        stdCtrl.addfields(fields);
        Acct = (Account)stdCtrl.getRecord();
        listOpps = [Select Id, Name, StageName From Opportunity Where AccountId =: Acct.id];
        oppName = Acct.Phone;

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