public class sampleCustomController {
    
    public Account AcctRec{get; set;}
    
    public Contact ct{
        get{
            if(ct == Null){
                ct = new contact();
            } 
          return ct;   
        }
        set{
            ct = value;
            displayControl();
        }
    }
    public boolean displayAccountSection{get; set;}

    public sampleCustomController(){
       AcctRec =  new Account();
       List<Account> Acct = [Select Id, Name, Phone, BillingPostalCode From Account];
       displayAccountSection = false;
       contact c = ct;
        ct = c;
       
    }
    
    public void displayControl(){
        if(displayAccountSection == true)
            displayAccountSection = false;
        else
            displayAccountSection = true;
    }
    
    public pagereference actionMethod(){
        Account a = new Account();
        a.name = 'Madan Morusu';
        insert a;
        pagereference pg = new pagereference('/'+a.id);
        return pg;
    }
}