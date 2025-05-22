package controllers;

import javax.servlet.http.HttpServlet;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.User;
import services.impl.UserService;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	
	/**
	 * Handles HTTP GET requests for user registration.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		String userName = request.getParameter("username");
		Long mobileNo = Long.parseLong(request.getParameter("mobile"));
		String emailId = request.getParameter("email");
		String address = request.getParameter("address");
		int pinCode = Integer.parseInt(request.getParameter("pincode"));
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String status = "";
		if (password != null && password.equals(confirmPassword)) {
			User user = new User(userName, mobileNo, emailId, address, pinCode, password);

			UserService dao = new UserService();

			status = dao.registerUser(user);
		} else {
			status = "Password not matching!";
		}

		RequestDispatcher rd = request.getRequestDispatcher("Register.jsp?message=" + status);

		rd.forward(request, response);
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
