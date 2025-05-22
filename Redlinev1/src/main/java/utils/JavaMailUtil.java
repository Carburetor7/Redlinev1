package utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

//import jakarta.mail.Authenticator;
//import jakarta.mail.Message;
//import jakarta.mail.MessagingException;
//import jakarta.mail.PasswordAuthentication;
//import jakarta.mail.Session;
//import jakarta.mail.Transport;
//import jakarta.mail.internet.InternetAddress;
//import jakarta.mail.internet.MimeMessage;


public class JavaMailUtil {

	/**
	 * Sends an email to the specified recipient email address using SMTP protocol.
	 *
	 * This method prepares and sends an email message to the recipient email address using the SMTP protocol.
	 * It configures the SMTP server properties such as host, port, authentication, and TLS encryption.
	 * The email sender's credentials (email ID and password) are retrieved from a ResourceBundle named "application".
	 * The method then creates a Session instance with the configured properties and authenticates the sender using
	 * the specified email ID and password. It prepares the email message using the prepareMessage helper method
	 * and sends it using the Transport class. Finally, it prints a success message upon successful email delivery.
	 *
	 * @param recipientMailId The email address of the recipient to whom the email will be sent.
	 * @throws MessagingException If an error occurs while sending the email.
	 */
	public static void sendMail(String recipientMailId) throws MessagingException {

		System.out.println("Preparing to send Mail");
		Properties properties = new Properties();
		String host = "smtp.gmail.com";
		properties.put("mail.smtp.host", host);
		properties.put("mail.transport.protocol", "smtp");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.port", "587");

		ResourceBundle rb = ResourceBundle.getBundle("application");

		String emailId = rb.getString("mailer.email");
		String passWord = rb.getString("mailer.password");

		properties.put("mail.user", emailId);
		properties.put("mail.password", passWord);

		Session session = Session.getInstance(properties, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(emailId, passWord);
			}

		});

		Message message = prepareMessage(session, emailId, recipientMailId);

		Transport.send(message);

		System.out.println("Message Sent Successfully!");

	}
	

	/**
	 * Prepares an email message to be sent using the provided Session instance, sender email, and recipient email.
	 *
	 * This method creates a MimeMessage object using the given Session instance. It sets the sender's email address,
	 * recipient's email address, subject, and text content of the email message. The subject is set to "Welcome to Ellison Electronics",
	 * and the text content of the email includes a personalized greeting for the recipient based on their email address.
	 * The prepared MimeMessage object is then returned for sending.
	 *
	 * @param session         The Session instance used to create the MimeMessage.
	 * @param myAccountEmail  The sender's email address.
	 * @param recipientEmail  The recipient's email address.
	 * @return                The prepared MimeMessage object ready to be sent.
	 */
	private static Message prepareMessage(Session session, String myAccountEmail, String recipientEmail) {

		try {

			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
			message.setSubject("Welcome to Ellison Electronics");
			message.setText("Hey! " + recipientEmail + ", Thanks  for Signing Up with us!");
			return message;

		} catch (Exception exception) {
			Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, exception);
		}
		return null;

	}

	/**
	 * Sends an email message to the specified recipient with the given subject and HTML text content.
	 *
	 * This method prepares to send an email message using the SMTP protocol and Gmail's SMTP server. It sets up the necessary
	 * properties for the mail session, including the host, authentication, and transport protocol. The email sender's credentials
	 * (email ID and password) are retrieved from the "application" ResourceBundle. The email message is created using the provided
	 * Session instance, sender email, recipient email, subject, and HTML text content. The prepared message is then sent using
	 * the Transport class.
	 *
	 * @param recipient        The recipient's email address to send the email.
	 * @param subject          The subject of the email.
	 * @param htmlTextMessage  The HTML content of the email message.
	 * @throws MessagingException If an error occurs while preparing or sending the email message.
	 */
	protected static void sendMail(String recipient, String subject, String htmlTextMessage) throws MessagingException {

		System.out.println("Preparing to send Mail");
		Properties properties = new Properties();
		String host = "smtp.gmail.com";
		properties.put("mail.smtp.host", host);
		properties.put("mail.transport.protocol", "smtp");
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.port", "587");

		ResourceBundle rb = ResourceBundle.getBundle("application");

		String emailId = rb.getString("mailer.email");
		String passWord = rb.getString("mailer.password");

		properties.put("mail.user", emailId);
		properties.put("mail.password", passWord);

		Session session = Session.getInstance(properties, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(emailId, passWord);
			}

		});

		Message message = prepareMessage(session, emailId, recipient, subject, htmlTextMessage);

		Transport.send(message);

		System.out.println("Message Sent Successfully!");

	}

	/**
	 * Prepares an email message with the specified Session, sender email, recipient email, subject, and HTML text content.
	 *
	 * This method creates a MimeMessage using the provided Session instance and sets up the sender, recipient, subject, and
	 * HTML content of the email message. The message is then returned for further processing or sending.
	 *
	 * @param session         The Session instance for creating the email message.
	 * @param myAccountEmail  The sender's email address.
	 * @param recipientEmail  The recipient's email address.
	 * @param subject         The subject of the email message.
	 * @param htmlTextMessage The HTML content of the email message.
	 * @return The prepared MimeMessage instance.
	 */
	private static Message prepareMessage(Session session, String myAccountEmail, String recipientEmail, String subject,
			String htmlTextMessage) {

		try {

			Message message = new MimeMessage(session);

			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
			message.setSubject(subject);
			message.setContent(htmlTextMessage, "text/html");
			return message;

		} catch (Exception exception) {
			Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, exception);
		}
		return null;

	}
}
