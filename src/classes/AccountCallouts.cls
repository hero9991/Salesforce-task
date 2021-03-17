/**
 * Created by a000 on 17.03.2021.
 */

public with sharing class AccountCallouts {
    public static final String CONSUMER_KEY = '3MVG9SOw8KERNN09KEzvibqx5UFurOdO2DUdoWfJ6bnpc1DvE457hnx3KQsrIcu0acUkap.D9yoJsGazPbgcQ';
    public static final String CONSUMER_SECRET = 'F71AEDFD35A70C0031834B6D1C607132B38EACD973ABE97350942C7E8938BFE3';
    public static final String USERNAME = 'vanyakubarin@resourceful-fox-3wuq1e.com';
    public static final String PASSWORD = 'vuth9191iUUSvPghu0JxiIfTnQD83JUuv';

    public static AccessTokenWrapper generateToken() {
        String requestBody = 'grant_type=password&client_id=' + CONSUMER_KEY + '&client_secret=' + CONSUMER_SECRET +
                '&username=' + USERNAME + '&password=' + PASSWORD;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HttpResponse response = http.send(request);
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
        if (response.getStatusCode() == 200) {
            return (AccessTokenWrapper) System.JSON.deserialize(response.getBody(), AccessTokenWrapper.class);
        } else {
            return null;
        }
    }
    public class AccessTokenWrapper {
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
    public static HttpResponse prepareRequest (String requestType, String accountId, String body){
        AccessTokenWrapper atw = generateToken();
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        accountId = accountId == null ? '' : '/'+accountId;
        request.setEndpoint('https://resourceful-fox-3wuq1e-dev-ed.my.salesforce.com/services/apexrest/Accounts' + accountId);
        System.debug(request.getEndpoint());
        request.setMethod(requestType);
        if (body != null) {
            request.setBody(body);
        }
        request.setHeader('Authorization', 'Bearer ' + atw.access_token);
        request.setHeader('content-type', 'application/json');
        request.setHeader('accept', 'application/json');
        HttpResponse response = http.send(request);
        return response;
    }

    // Callouts
    public static HttpResponse makeGetCallout(String accountId) {
        HttpResponse response = AccountCallouts.prepareRequest('GET', accountId, null);
        System.debug(response.getStatusCode());
        if (response.getStatusCode() == 200) {
            Object results = JSON.deserialize(response.getBody(), Account.class);
            System.debug(results);
        }
        return response;
    }
    public static HttpResponse makePostCallout() {
        String body = '{"name":"mighty moose1"}';
        HttpResponse response = AccountCallouts.prepareRequest('POST', null, body);

        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makeDeleteCallout(String accountId) {
        HttpResponse response = AccountCallouts.prepareRequest('DELETE', accountId, null);
        System.debug(response.getStatusCode());
        if (response.getStatusCode() == 200) {
            System.debug('deleted');
        }
        return response;
    }
    public static HttpResponse makePutCallout() {
        String body = '{"name":"mighty moose1"}';
        HttpResponse response = AccountCallouts.prepareRequest('PUT', null, body);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
    public static HttpResponse makePatchCallout(String accountId) {
        String body = '{"name":"sometest", "phone":"123123"}';
        HttpResponse response = AccountCallouts.prepareRequest('PATCH', null, body);
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
        return response;
    }
}