public with sharing class Constants {
    // Error messages
    public static final String ERROR_NO_ACCOUNT_ATTACHED = 'You cannot create a request without attaching an account';
    public static final String ERROR_NO_CONTACTS_FOR_ACCOUNT = 'You cannot create a request for accounts without contacts';
    public static final String ERROR_TOO_MANY_ATTENDEES_FOR_WEB = 'Web request are only allowed to have one attendee';
    public static final String ERROR_TOO_MANY_ATTENDEES_FOR_PHONE = 'Phone request are only allowed to have three attendee';

    // Request origin limits
    public static final Integer LIMIT_WEB_ATTENDEES = 1;
    public static final Integer LIMIT_PHONE_ATTENDEES = 3;

    // Request status values
    public static final String STATUS_CLOSED = 'Closed';

    // Request origines
    public static final String WEB_ORGIN = 'web';
    public static final String PHONE_ORGIN = 'phone';


    // Email messages
    public static final String EMAIL_ERROR_MESSAGE = 'The email failed to send: ';
    public static final String EMAIL_SUCCESS_MESSAGE = 'notify success';

}