global class CreateLeadFromEmail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(
        Messaging.inboundEmail email,
        Messaging.InboundEnvelope env
    ) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        Map<String, String> params = getParams(email.plainTextBody);

        Lead lead = new Lead(
            Email = email.fromAddress,
            LastName = params.get(Constants.INCOMING_MAIL_PARAMETER_NAME_NAME),
            Company = params.get(Constants.INCOMING_MAIL_PARAMETER_NAME_COMPANY_NAME),
            Birthday_Tourist__c = Date.parse(params.get(Constants.INCOMING_MAIL_PARAMETER_NAME_BIRTHDAY))
        );
        insert lead;

        result.success = true;

        return result;
    }

    private static Map<String, String> getParams(String bodyEmail) {
        final Integer PARAMETER_NAME = 0;
        final Integer PARAMETER_VALUE = 1;

        List<String> rows = bodyEmail.split('\n');
        Map<String, String> params = new Map<String, String>();

        for (String row : rows) {
            List<String> columns = row.split(':');
            params.put(columns[PARAMETER_NAME], columns[PARAMETER_VALUE]);
        }

        return params;
    }
}
