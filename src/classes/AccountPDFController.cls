public class AccountPDFController {
   Student__c student ;
   private Id studentID ;
   private String alreadySet;
   LIST<Attachment> attatchment=new LIST<Attachment>();
   public AccountPDFController(ApexPages.StandardController controller) {
       studentId= System.currentPageReference().getParameters().get('id');
       student = [SELECT First_Name__c,Name,Age__c,Email__c,Married__c,Wife_Name__c,Sex__c FROM Student__c where Student__c.Id =:studentID];
   }
   //its a test procedure......
   public PageReference savePdf() {
       PageReference pdf = Page.PDF;
       pdf.getParameters().put('Id', student.Id);
  	   Attachment attach = new Attachment();   
       attatchment = [SELECT Id,Name FROM Attachment  where ParentId=:studentID];
       if(attatchment.size() > 0) {
           delete attatchment;
       }
       Blob body;
       body = pdf.getContent(); 
       attach.Body = body;
       attach.Name = student.Name;
       attach.ParentId= student.Id;
       insert attach;
       return null;
   }
}