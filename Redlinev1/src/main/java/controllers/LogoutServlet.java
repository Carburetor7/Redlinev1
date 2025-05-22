package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.parser.Cookie;

@WebServlet("/LogoutSrv")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LogoutServlet() {
		super();

	}

	/**
	 * Handles HTTP GET requests for user logout.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");


		
		javax.servlet.http.Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (javax.servlet.http.Cookie cookie : cookies) {
				// Set max age to 0 to effectively delete the cookie
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
		}

		// 2. Invalidate user session (if it exists)
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}

		RequestDispatcher rd = request.getRequestDispatcher("login.jsp?message=Successfully Logged Out!");

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
