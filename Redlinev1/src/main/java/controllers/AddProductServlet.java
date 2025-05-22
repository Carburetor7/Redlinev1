package controllers;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import services.impl.ProductService;


@WebServlet("/AddProductSrv")
@MultipartConfig(maxFileSize = 16177215)
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Handles HTTP GET requests for product registration by administrators.
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
		String userName = (String) session.getAttribute("username");

		if (userType == null || !userType.equals("admin")) {

			response.sendRedirect("login.jsp?message=Access Denied!");

		}

		else if (userName == null) {

			response.sendRedirect("login.jsp?message=Session Expired, Login Again to Continue!");
		}

		String status = "Product Registration Failed!";
		String prodName = request.getParameter("name");
		String prodType = request.getParameter("type");
		String prodInfo = request.getParameter("info");
		double prodPrice = Double.parseDouble(request.getParameter("price"));
		int prodQuantity = Integer.parseInt(request.getParameter("quantity"));

		Part part = request.getPart("image");

		InputStream inputStream = part.getInputStream();

		InputStream prodImage = inputStream;

		ProductService product = new ProductService();

		status = product.addProduct(prodName, prodType, prodInfo, prodPrice, prodQuantity, prodImage);

		RequestDispatcher rd = request.getRequestDispatcher("addProduct.jsp?message=" + status);
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
