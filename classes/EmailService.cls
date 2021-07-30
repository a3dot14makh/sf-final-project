public class EmailService {
    
    public static void sendEmail(
        List<String> emailAddress,
        String senderDisplayName,
        String subject,
        String htmlBody
    ) {
        if (
            emailAddress == null ||
            emailAddress.isEmpty() ||
            String.isBlank(senderDisplayName) ||
            String.isBlank(subject) ||
            String.isBlank(htmlBody)
        ) {
            return;
        }
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emailAddress);
        message.setSenderDisplayName(senderDisplayName);
        message.setSubject(subject);
        message.setHtmlBody(htmlBody);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ message });
    }

    public static void sendEmailTemplate(
        List<String> emailAddress,
        String senderDisplayName,
        String templateName,
        Id targetObjectId,
        Id relatedObjectId
    ) {
        EmailTemplate emailTemplate = [SELECT Id, Name FROM EmailTemplate WHERE Name = :templateName];

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(emailAddress);
        message.setSenderDisplayName(senderDisplayName);
        message.setTemplateID(emailTemplate.Id);
        message.setTargetObjectId(targetObjectId);
        message.setWhatId(relatedObjectId);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ message });
    }
}
