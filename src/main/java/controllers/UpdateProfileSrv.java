package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.User;
import services.impl.UserService;

/**
 * Servlet implementation class UpdateProfileSrv
 */
@WebServlet("/UpdateProfileSrv")
public class UpdateProfileSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfileSrv() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    /**
     * Handles HTTP PUT requests for updating user profile information.
     * 
     * @param request  The HttpServletRequest object containing the request parameters.
     * @param response The HttpServletResponse object for sending the response.
     * @throws ServletException If a servlet-specific error occurs.
     * @throws IOException      If an I/O error occurs while processing the request.
     */

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		String userName = request.getParameter("username");
		Long mobileNo = Long.parseLong(request.getParameter("mobile"));
		String emailId = request.getParameter("email");
		String address = request.getParameter("address");
		int pinCode = Integer.parseInt(request.getParameter("pincode"));
		String status = "";
		UserService dao = new UserService();
		User user = new User(userName, mobileNo, emailId, address, pinCode);
		status = dao.updateUser(user);
	

		RequestDispatcher rd = request.getRequestDispatcher("updateProfile.jsp?message=" + status);

		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	/**
	 * Handles HTTP POST requests by delegating to the doPut method for processing user profile updates.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPut(request, response);
	}

}
