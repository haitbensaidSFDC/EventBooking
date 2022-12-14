public with sharing class RegistrationHelper {

    /**
     * create a registration http request to the external system
     * @param attendee attendee to be registered
     * @return  `HttpResponse`
     */
    public static HttpResponse createRegistration(Contact attendee) {
        // prepare request body
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('name', 'static' );
        gen.writeEndObject();

        // send registration request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        // TODO: callout:registration_Endpoint/animals
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(gen.getAsString());

        return http.send(request);
    }
}
