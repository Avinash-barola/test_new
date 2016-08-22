public class AccountWithFilterController {
    public List<Account> accountList {get; set;}
    public String selectedValueForBillingCountry {get; set;}
    public String selectedValueForBillingCity {get; set;}
    public String selectedValueForBillingState {get; set;}
    public PageReference search() {
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
    	accountList = Database.query(queryString);
        return null;
    }
}