public class calloutCon {
    public string info {get ;set ;}
    public void callOut() {
        info = CalloutClass.getInfoFromExternalService().getBody() ;
    }
}