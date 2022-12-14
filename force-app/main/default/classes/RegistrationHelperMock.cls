/**
 * class to mock the the External System http response when requested during tests
 */
@isTest
global class RegistrationHelperMock implements HttpCalloutMock {

    private Integer statusCode ;

    public RegistrationHelperMock(Integer statusCode) {
        this.statusCode = statusCode;
    }
    
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(this.statusCode);
        return response; 
    }
}