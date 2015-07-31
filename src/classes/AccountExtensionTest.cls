@isTest
public class AccountExtensionTest {
	
    static testMethod void unitTestMethod() {
    Account a = new Account();
    ApexPages.StandardController sc = new ApexPages.StandardController(a);
    AccountExtension aext = new AccountExtension(sc);
    aext.Acct.OwnerID = userinfo.getuserid();
    aext.Acct.NAme = userinfo.getuserid();
    aext.Acct.phone = userinfo.getuserid();
    
    //blob testFile = new blob();
    //aext.AttachmentBody = testFile;
    aext.AttachmentName = 'kjkjh';
    aext.save();
    

    }
}