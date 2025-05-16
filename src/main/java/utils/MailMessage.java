package utils;

import javax.mail.MessagingException;

public class MailMessage {
	/**
	 * Sends a registration success email to the specified email address with the registration details.
	 *
	 * This method constructs an HTML-formatted email message with a welcome message, promotional information,
	 * and a promo code for new customers. The email is sent to the provided recipient's email address using
	 * JavaMailUtil's sendMail method. If any MessagingException occurs during the email sending process, it
	 * is caught and logged.
	 *
	 * @param emailId The email address of the recipient to whom the registration success email will be sent.
	 * @param name    The name of the recipient, used in the email message's personalized greeting.
	 */
	public static void registrationSuccess(String emailId, String name) {
		String recipient = emailId;
		String subject = "Registration Successfull";
		String htmlTextMessage = "" + "<html>" + "<body>"
				+ "<h2 style='color:green;'>Welcome to Origin Tech</h2>" + "" + "Hi " + name + ","
				+ "<br><br>Thanks for singing up with Origin Tech.<br>"
				+ "We are glad that you choose us. We invite you to check out our latest collection of new electonics appliances."
				+ "<br>We are providing upto 60% OFF on most of the electronic gadgets. So please visit our site and explore the collections."
				+ "<br><br>Our Online electronics is growing in a larger amount these days and we are in high demand so we thanks all of you for "
				+ "making us up to that level. We Deliver Product to your house with no extra delivery charges and we also have collection of most of the"
				+ "branded items.<br><br>As a Welcome gift for our New Customers we are providing additional 10% OFF Upto 500 Rs for the first product purchase. "
				+ "<br>To avail this offer you only have "
				+ "to enter the promo code given below.<br><br><br> PROMO CODE: " + "Origin500<br><br><br>"
				+ "Have a good day!<br>" + "" + "</body>" + "</html>";
		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * Sends a transaction success email to the specified email address with the transaction details.
	 *
	 * This method constructs an HTML-formatted email message with details about the successful transaction,
	 * including the order ID, transaction amount, and a thank you message. The email is sent to the provided
	 * recipient's email address using JavaMailUtil's sendMail method. If any MessagingException occurs during
	 * the email sending process, it is caught and logged.
	 *
	 * @param recipientEmail The email address of the recipient to whom the transaction success email will be sent.
	 * @param name           The name of the recipient, used in the email message's personalized greeting.
	 * @param transId        The transaction ID associated with the successful transaction.
	 * @param transAmount    The amount paid in the transaction, included in the email message for reference.
	 */
	public static void transactionSuccess(String recipientEmail, String name, String transId, double transAmount) {
		String recipient = recipientEmail;
		String subject = "Order Placed at Origin Tech";
		String htmlTextMessage = "<html>" + "  <body>" + "    <p>" + "      Hey " + name + ",<br/><br/>"
				+ "      We are glad that you shop with Origin Tech!" + "      <br/><br/>"
				+ "      Your order has been placed successfully and under process to be shipped."
				+ "<br/><h6>Please Note that this is a demo projet Email and you have not made any real transaction with us till now!</h6>"
				+ "      <br/>" + "      Here is Your Transaction Details:<br/>" + "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Order Id:</font>"
				+ "      <font style=\"color:green;font-weight:bold;\">" + transId + "</font><br/>" + "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Amount Paid:</font> <font style=\"color:green;font-weight:bold;\">"
				+ transAmount + "</font>" + "      <br/><br/>" + "      Thanks for shopping with us!<br/><br/>"
				+ "      Come Shop Again! <br/<br/> <font style=\"color:green;font-weight:bold;\">Origin Tech.</font>"
				+ "    </p>" + "    " + "  </body>" + "</html>";

		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Sends an email notification to the specified recipient that their order has been shipped.
	 *
	 * This method constructs an HTML-formatted email message with details about the shipped order,
	 * including the order ID, transaction amount, and a thank you message. The email is sent to the
	 * provided recipient's email address using JavaMailUtil's sendMail method. If any MessagingException
	 * occurs during the email sending process, it is caught and logged.
	 *
	 * @param recipientEmail The email address of the recipient to whom the order shipped email will be sent.
	 * @param name           The name of the recipient, used in the email message's personalized greeting.
	 * @param transId        The transaction ID associated with the shipped order.
	 * @param transAmount    The amount paid in the transaction, included in the email message for reference.
	 */
	public static void orderShipped(String recipientEmail, String name, String transId, double transAmount) {
		String recipient = recipientEmail;
		String subject = "Hurray!!, Your Order has been Shipped from Origin Tech";
		String htmlTextMessage = "<html>" + "  <body>" + "    <p>" + "      Hey " + name + ",<br/><br/>"
				+ "      We are glad that you shop with Origin Tech!" + "      <br/><br/>"
				+ "      Your order has been shipped successfully and on the way to be delivered."
				+ "<br/><h6>Please Note that this is a demo projet Email and you have not made any real transaction with us till now!</h6>"
				+ "      <br/>" + "      Here is Your Transaction Details:<br/>" + "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Order Id:</font>"
				+ "      <font style=\"color:green;font-weight:bold;\">" + transId + "</font><br/>" + "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Amount Paid:</font> <font style=\"color:green;font-weight:bold;\">"
				+ transAmount + "</font>" + "      <br/><br/>" + "      Thanks for shopping with us!<br/><br/>"
				+ "      Come Shop Again! <br/<br/> <font style=\"color:green;font-weight:bold;\">Origin Tech.</font>"
				+ "    </p>" + "    " + "  </body>" + "</html>";

		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Sends an email notification to the specified recipient that a previously unavailable product is now available for purchase.
	 *
	 * This method constructs an HTML-formatted email message with details about the newly available product,
	 * including its name, ID, and a personalized greeting. The email is sent to the provided recipient's email address
	 * using JavaMailUtil's sendMail method. If any MessagingException occurs during the email sending process, it is caught and logged.
	 *
	 * @param recipientEmail The email address of the recipient to whom the product availability email will be sent.
	 * @param name           The name of the recipient, used in the email message's personalized greeting.
	 * @param prodName       The name of the product that is now available for purchase.
	 * @param prodId         The ID of the product that is now available for purchase.
	 */
	public static void productAvailableNow(String recipientEmail, String name, String prodName, String prodId) {
		String recipient = recipientEmail;
		String subject = "Product " + prodName + " is Now Available at Origin Tech";
		String htmlTextMessage = "<html>" + "  <body>" + "    <p>" + "      Hey " + name + ",<br/><br/>"
				+ "      We are glad that you shop with Origin Tech!" + "      <br/><br/>"
				+ "      As per your recent browsing history, we seen that you were searching for an item that was not available in sufficient amount"
				+ " at that time. <br/><br/>"
				+ "We are glad to say that the product named <font style=\"color:green;font-weight:bold;\">" + prodName
				+ "</font> with " + "product Id <font style=\"color:green;font-weight:bold;\">" + prodId
				+ "</font> is now available to shop in our store!"
				+ "<br/><h6>Please Note that this is a demo projet Email and you have not made any real transaction with us and not ordered anything till now!</h6>"
				+ "      <br/>" + "      Here is The product detail which is now available to shop:<br/>"
				+ "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Product Id: </font><font style=\"color:green;font-weight:bold;\">"
				+ prodId + " " + "      </font><br/>" + "      <br/>"
				+ "      <font style=\"color:red;font-weight:bold;\">Product Name: </font> <font style=\"color:green;font-weight:bold;\">"
				+ prodName + "</font>" + "      <br/><br/>" + "      Thanks for shopping with us!<br/><br/>"
				+ "      Come Shop Again! <br/<br/><br/> <font style=\"color:green;font-weight:bold;\">Origin Tech.</font>"
				+ "    </p>" + "    " + "  </body>" + "</html>";

		try {
			JavaMailUtil.sendMail(recipient, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Sends an email message using JavaMailUtil's sendMail method.
	 * This method is used to send HTML-formatted email messages with a specified subject and content to a recipient's email address.
	 * If the email sending process is successful, it returns "SUCCESS"; otherwise, it catches any MessagingException that occurs,
	 * prints the stack trace, and returns "FAILURE".
	 *
	 * @param toEmailId      The email address of the recipient to whom the email message will be sent.
	 * @param subject        The subject of the email message.
	 * @param htmlTextMessage The HTML-formatted content of the email message.
	 * @return "SUCCESS" if the email is sent successfully, otherwise "FAILURE".
	 */
	public static String sendMessage(String toEmailId, String subject, String htmlTextMessage) {
		try {
			JavaMailUtil.sendMail(toEmailId, subject, htmlTextMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
			return "FAILURE";
		}
		return "SUCCESS";
	}
}
