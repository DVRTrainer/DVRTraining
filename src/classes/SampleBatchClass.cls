global class SampleBatchClass implements Database.Batchable<sObject> {
 
  private String SOQL_Query;
  private String BatchName;
 
  global SampleBatchClass(string SOQL_Query, string BatchName) {
    this.SOQL_Query = SOQL_Query;
    this.BatchName = BatchName;
  }
 
  global Database.QueryLocator start(Database.BatchableContext BC){
     return Database.getQueryLocator(SOQL_Query);   
  }
 
  global void execute(Database.BatchableContext BC, List<sObject> scope){   
    //Just update the records.  That's all!
    update scope;
  }
 
  global void finish(Database.BatchableContext BC){
      System.debug('Batch Process Complete');
      // Get the ID of the AsyncApexJob representing this batch job from Database.BatchableContext. 
      // Query the AsyncApexJob object to retrieve the current job's information. 
         AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, ExtendedStatus, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:BC.getJobId()];
       
       
      // Send an email to the Apex job's submitter notifying of job completion. 
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         list<string> toAddresses = new list<string> {a.CreatedBy.Email};
         mail.setToAddresses(toAddresses);
         mail.setSubject('Salesforce.com ' + BatchName + ' Batch Update:  ' + a.Status);
         mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.');
      //only send email if an error occurs 
         if(a.NumberOfErrors>0){    
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         }  
  }
 
}