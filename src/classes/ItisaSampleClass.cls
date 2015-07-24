Public class ItisaSampleClass{

    public Account Acct{get; set;}
    public boolean displayAccountSection{get; set;}
private static String s1;
private static String s2;

    public ItisaSampleClass(){
       Acct = new Account(); 
       displayAccountSection = false;
    }
    
public ItisaSampleClass(String ss, String sd){
    s1 = ss;
    s2 = sd;
}
	
    public static string classname = 'ItisaSampleClass';
    
    public void displayDebuglog(){
        system.debug('S1 = '+s1+ 'S2 = '+s2);
    }
    
    public static boolean areTheVariablesSet(){
        if(s1 != ''){
            return false;
        }
        else if(s2 != 'sss'){
            return true;
        }
        else
            return true; 
    }
    
    public ItisaSampleClass returnContact(){
     	ItisaSampleClass i = new ItisaSampleClass ();
        return i;
        
    }
    
    @future 
    public static void updateOpportunities(List<String> AccountIds){
        List<Opportunity> listOpp = [Select Id From Opportunity Where AccountId IN: AccountIds];
            for(Opportunity opp : listOpp){
                opp.amount = 2323;
            }
        update listOpp;
    }
    
    public static string samplegetset{
        get { return samplegetset; }
        set { if(value == 'Redd') samplegetset='Diff'; else samplegetset = value;}
    }
    
    public class sampleWrapper{
        string s;
    }
    
    public void samplepg(){
      Acct = [Select Id, Name From Account Where Id= '001G000000qHviN'];
        
    }
}