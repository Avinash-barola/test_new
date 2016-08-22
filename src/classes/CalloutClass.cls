public class CalloutClass {
    public static HttpResponse getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://203.129.200.125:8080/UserManagement/rest/user');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res;
        try {
            res = h.send(req);
        }catch(Exception e) {
            System.debug(e.getMessage());
        }
        if(res != null)
        	System.debug(res.getBody());
        return res;
    }
}