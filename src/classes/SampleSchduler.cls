global class SampleSchduler implements Schedulable{
   global void execute(SchedulableContext sc) {
      helloworld hw = new helloworld(); 
      SampleBatchClass b = new SampleBatchClass('Select Id From Account','Schedule Account Job');
      database.executebatch(b);
   }
}