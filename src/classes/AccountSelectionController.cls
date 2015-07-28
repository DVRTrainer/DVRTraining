public class AccountSelectionController {
    public List<AccountWrapper> listAW{get; set;}
    
    public string sortfield{get; set;}
    public string sortdir{get; set;}
    public integer pagesize{get; set;}
    public integer ot{get; set;}
    public boolean hasnext{get; set;}
    public boolean hasprevious{get; set;}
    
    public AccountSelectionController(){
        //Int and add the elements to Account wrapper
        listAW = new List<AccountWrapper>();
        for(Account a : [Select Id, Name, phone From Account]){
            AccountWrapper aw = new AccountWrapper(a,false);            
            listAW.add(aw);
        }
        pagesize = 5;
        ot = 0;
        sortfield = 'Name';
        sortDir = 'Asc';
        searchAccounts();
    }
    
    public void searchAccounts(){
        listAW.clear();
        List<Account> temActList = new List<Account>();
		String SOQLQuery = 'Select Id, Name, Phone From Account Order By '+sortfield+' ' + sortDir+' Limit ' + pagesize + 'Offset '+ot;
        temActList = database.query(SOQLQuery);
        if(temActList.size() > 0){
            for(Account a : temActList){
                listAW.add(new AccountWrapper(a,false));
            }
        }
       
    }
    
    public void next(){
        ot = ot+pagesize;
        searchAccounts();
    }
    
    public void previous(){
        ot = ot - pagesize;
        if(ot>=0)
        searchAccounts();
        else{
            ot = 0;
            searchAccounts();
        }
        
    }
    
    public void chnageSortDir(){
        sortDir = sortdir.equals('asc') ? 'desc' : 'asc';
        ot = 0;
        searchAccounts();
    }
    public void save(){
        List<Account> listAcct = new List<Account>();
        for(AccountWrapper aw : listAW){
            if(aw.isSelected){
                listAcct.add(aw.acct);
                
            }
        }
        if(listAcct.size() > 0){
            update listAcct;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,listAcct.size()+' records have been saved'));

        }
        else{
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select at least one record'));

        }
    }
    
    public class AccountWrapper{
        public AccountWrapper(Account At, boolean isS){
            this.Acct = at;
            this.isSelected = isS; 
        }
        public Account acct{get; set;}
        public boolean isSelected{get; set;}
    }
}