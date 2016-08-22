public with sharing class AccountWithFilterAndPaginationController {
    public String selectedValueForBillingCountry {get; set;}
    public String selectedValueForBillingCity {get; set;}
    public String selectedValueForBillingState {get; set;}
    public ApexPages.StandardSetController setCon {get;set;}   
    public List<SelectOption> getAccountListForBillingCity() {
        List<Account> accountListForBillingCity = [select BillingCity from Account];
        List<SelectOption> billingCityList = new List<SelectOption>();
        billingCityList.add(new SelectOption('-' , '-'));
        for(Account acc : accountListForBillingCity) {
            if(acc.BillingCity != null) {
                billingCityList.add(new SelectOption(acc.BillingCity , acc.BillingCity));
            }
            
        }
        return billingCityList;
    }
    
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    
    Public List<Account> getAccounts(){
        if(setCon==null)
            return null;
        return (List<Account>)setCon.getRecords();
        
    }
    //again new test
    public String getQuery() {
        String queryString = 'select Id,Name,BillingCountry,BillingState,BillingCity from Account ';
        Boolean isConditionBlank = false;
        if(!selectedValueForBillingCountry.equalsIgnoreCase('')) {
            isConditionBlank = true;
            queryString +='where BillingCountry Like \'%'+selectedValueForBillingCountry+'%\'';
        }
        if(!selectedValueForBillingState.equalsIgnoreCase('')) {
            if(isConditionBlank == true) {
                queryString +='and BillingState Like \'%'+selectedValueForBillingState+'%\'';
            }
            else {
                isConditionBlank = true;
                queryString +='where BillingState Like \'%'+selectedValueForBillingState+'%\'';
            }
        }
        if(!selectedValueForBillingCity.equalsIgnoreCase('')) {
            if(isConditionBlank == true) {
                queryString +='and BillingCity Like \'%'+selectedValueForBillingCity+'%\'';
            }
            else {
                queryString +='where BillingCity Like \'%'+selectedValueForBillingCity+'%\'';
            }
        }
        queryString +=' limit 100';
        System.debug(queryString);
        return queryString;
    }
    
    public void search() {
        size = 10;
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(getQuery()));
        setCon.setPageSize(size);
        noOfRecords = setCon.getResultSize();
    }
    
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
    
    public void first() {
        setCon.first();
    }
    
    public void last() {
        setCon.last();
    }
    
    public void previous() {
        setCon.previous();
    }
    
    public void next() {
        setCon.next();
    }
}