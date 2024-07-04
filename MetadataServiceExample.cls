public with sharing class MetadataServiceExample {

  public static String getSessionId(){
        Organization org = [SELECT Name, IsSandbox from Organization];

        String username =  Userinfo.getUserName();
        String certificateName = 'SalesforceAuthorization';//enter certificate name
        String hostname = org.IsSandbox?'test.salesforce.com':'login.salesforce.com'; 
        String connectedAppConsumerKey = '3MVG9gtDqcOkH4PKahtmGuvj2H5pRAwGF44uv4zf5ZogG4pwrmZgbfH_d9prW1pCJ_wGo0ALADjK0RcmE6CnA';//enter consumer key from connected app
        
        return SalesforceSelfAuthJWT.getAccessToken(username, certificateName, hostname, connectedAppConsumerKey);
  }
  private static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        //service.SessionHeader.sessionId = UserInfo.getSessionId();
        //service.SessionHeader.sessionId = '{!$Credential.OAuthToken}';
        service.SessionHeader.sessionId = getSessionId();
        
        service.timeout_x = 120000;
        service.CallOptions = new MetadataService.CallOptions_element();
        service.CallOptions.client = 'BoonPlus/EasyPricingforOpportunity/';
        return service;     
    }    
}
