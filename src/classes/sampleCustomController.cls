public class sampleCustomController {
    
    public Account Acct{get; set;}
    public boolean displayAccountSection{get; set;}

    public sampleCustomController(){
       Acct = [Select Id, Name From Account Where Id= '001G000000qHviN'];
       displayAccountSection = false;
    }
    
    public void displayControl(){
        if(displayAccountSection == true)
            displayAccountSection = false;
        else
            displayAccountSection = true;
    }
}