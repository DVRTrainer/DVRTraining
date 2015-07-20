Public with Sharing class NearbyRecords{
        private transient List<SelectOption> transientYesNo;
        private transient List<SelectOption> transientObject;
        
        public String ObjectType{get; set;}
        public double ZipCode{get; set;}
        
public List<SelectOption> ObjOptions {
        get {
            if (transientObject == null) {
                transientObject = new List<SelectOption>();
                transientObject.add(new SelectOption('Account', 'Account'));
                transientObject.add(new SelectOption('Contact', 'Contact'));
            }
            return transientObject;   
        }
    }
    
public NearbyRecords(){
    
    
}

public string userId = userInfo.getUserId();

@RemoteAction
public Static List<sObject> getContacts(Double Lat, Double Lon, String ObjectName){
List<sObject> recList = new List<sObject>();
try{
    //ObjectType = transientObject[0];
    String SoqlQuery = 'Select Id, Name, Location__Longitude__s, Location__Latitude__s, Account.Name, Phone, Email From '+ObjectName+' Where Distance(Location__c, GEOLOCATION('+Lat+','+Lon+'),\'mi\') < 200 Order By Distance(Location__c, GEOLOCATION('+Lat+' , '+Lon+' ), \'mi\')'+ 
                                   'Limit 10';


    System.debug(SoqlQuery);
    recList = database.query(SoqlQuery);
    System.debug(recList);
}
Catch(Exception e)
{
    System.debug('@@@@@@@@@'+e);
}
    
    return recList;
}

@RemoteAction
public Static List<recordWrapper> sObjectsByZip(String Zip, String ObjectName){
    String SoqlQuery;
    String ZipCode = Zip;
    List<sObject> recList =new List<sObject>();
    List<recordWrapper> ListRW = new List<recordWrapper>();
    
    try{
        if(ObjectName == 'Contact')
            SoqlQuery = 'Select Id, Name, MailingStreet, MailingCity, MailingState, MailingCountry, MailingPostalCode, Phone, Email From '+ObjectName+' Where MailingPostalCode =: ZipCode LIMIT 10';
        
        else if(ObjectName == 'Account')
              SoqlQuery = 'Select Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry, BillingPostalCode, Phone, Email__c From '+ObjectName+' Where BillingPostalCode =: ZipCode LIMIT 10';
        
        
        System.debug(SoqlQuery);
        recList = database.query(SoqlQuery);
        System.debug(recList);
    }
    
    Catch(Exception e)
    {
        System.debug('@@@@@@@@@'+e);
    }
    
    
    if(recList.size()>0)
    {
        for(sObject s: recList)
        {   
            //check if Object is a contact and if so populate the Wrapper class.
            if(ObjectName == 'Contact'){
            Contact convertedCon = (Contact)s;
            
            recordWrapper tempRW = new recordWrapper();
            tempRW.ObjectID = convertedCon.Id; 
            tempRW.recName = convertedCon.Name;
            tempRW.address = convertedCon.MailingStreet+','+convertedCon.MailingCity+','+convertedCon.MailingState+','+convertedCon.MailingPostalCode;
            tempRW.address = tempRW.address.replaceAll(',,',',');            
            tempRW.Phone = convertedCon.Phone;
            tempRW.Email = convertedCon.Email;
            //tempRW.Latitude = convertedCon.M;
            
            ListRW.add(tempRW);
            }
            
            if(ObjectName == 'Account'){
            Account convertedAcct = (Account)s;
            
            recordWrapper tempRW = new recordWrapper();
            tempRW.ObjectID = convertedAcct.Id; 
            tempRW.recName = convertedAcct.Name;
            tempRW.address = convertedAcct.BillingStreet+','+convertedAcct.BillingCity+','+convertedAcct.BillingState+','+convertedAcct.BillingPostalCode;
            tempRW.address = tempRW.address.replaceAll(',,',',');
            tempRW.Phone = convertedAcct.Phone;
            tempRW.Email = convertedAcct.Email__c;
            //tempRW.Latitude = convertedCon.M;
            
            ListRW.add(tempRW);
            }
        }
    }

    return ListRW;
}

public List<SelectOption> soYesNo {
        get {
            if (transientYesNo == null) {
                transientYesNo = new List<SelectOption>();
                transientYesNo.add(new SelectOption('false', 'false'));
                transientYesNo.add(new SelectOption('true', 'true'));
            }
            return transientYesNo;   
        }
    }
 
 //Method to direct the page to New Visual Force Page   
 public PageReference ZipSearch(){
    
    
    return null;
    
 }
 
  //Method to direct the page to New Visual Force Page   
 public PageReference LocationSearch(){
    
    return null;    
 }
 
 //Wrapper Class to Hold the Record Details
 public class recordWrapper{
        
    String ObjectId;
    String recName;
    String Phone;
    String Email;
    String Address;
    double Latitude;
    
    
 }
 
 
}