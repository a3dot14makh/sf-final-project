@IsTest
global class SingleRequestMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseStatus;
    private String responseBody;

    global SingleRequestMock(Integer statusCode, String responseStatus, String responseBody) {
        this.statusCode = statusCode;
        this.responseStatus = responseStatus;
        this.responseBody = responseBody;
    }

    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();

        res.setHeader('Content-Type', 'application/json');
        res.setBody(responseBody);
        res.setStatusCode(statusCode);
        res.setStatus(responseStatus);

        return res;
    }
}