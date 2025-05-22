package controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import services.impl.OrderService;
import services.impl.UserService;
import utils.MailMessage;


@WebServlet("/ShipmentServlet")
public class ShipmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ShipmentServlet() {
		super();
	}

	/**
	 * Handles HTTP GET requests for shipping orders.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("usertype");
		if (userType == null) {

			response.sendRedirect("login.jsp?message=Access Denied, Login Again!!");
			return;
		}

		String orderId = request.getParameter("orderid");
		String prodId = request.getParameter("prodid");
		String userName = request.getParameter("userid");
		Double amount = Double.parseDouble(request.getParameter("amount"));
		String status = new OrderService().shipNow(orderId, prodId);
		String pagename = "shippedItems.jsp";
		if ("FAILURE".equalsIgnoreCase(status)) {
			pagename = "unShippedItems.jsp";
		} else {
			MailMessage.orderShipped(userName, new UserService().getFName(userName), orderId, amount);
		}
		PrintWriter pw = response.getWriter();
		response.setContentType("text/html");

		RequestDispatcher rd = request.getRequestDispatcher(pagename);

		rd.include(request, response);

		pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
	}

	/**
	 * Handles HTTP POST requests by delegating to the doGet method for processing.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}
