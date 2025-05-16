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

import models.Demand;
import models.Product;
import services.impl.CartService;
import services.impl.DemandService;
import services.impl.ProductService;


@WebServlet("/UpdateToCart")
public class UpdateToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateToCart() {
		super();

	}

	/**
	 * Handles HTTP PUT requests for updating product quantity in the cart.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userName = (String) session.getAttribute("username");

		if (userName == null) {

			response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
		}

		// login Check Successfull

		String userId = userName;
		String prodId = request.getParameter("pid");
		int pQty = Integer.parseInt(request.getParameter("pqty"));

		CartService cart = new CartService();

		ProductService productDao = new ProductService();

		Product product = productDao.getProductDetails(prodId);

		int availableQty = product.getProdQuantity();

		PrintWriter pw = response.getWriter();

		response.setContentType("text/html");

		if (availableQty < pQty) {

			String status = cart.updateProductToCart(userId, prodId, availableQty);

			status = "Only " + availableQty + " no of " + product.getProdName()
					+ " are available in the shop! So we are adding only " + availableQty + " products into Your Cart"
					+ "";

			Demand demandBean = new Demand(userName, product.getProdId(), pQty - availableQty);

			DemandService demand = new DemandService();

			boolean flag = demand.addProduct(demandBean);

			if (flag)
				status += "<br/>Later, We Will Mail You when " + product.getProdName()
						+ " will be available into the Store!";

			RequestDispatcher rd = request.getRequestDispatcher("cartDetails.jsp");

			rd.include(request, response);

			pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");

		} else {
			String status = cart.updateProductToCart(userId, prodId, pQty);

			RequestDispatcher rd = request.getRequestDispatcher("cartDetails.jsp");

			rd.include(request, response);

			pw.println("<script>document.getElementById('message').innerHTML='" + status + "'</script>");
		}

	}

	/**
	 * Handles HTTP POST requests by delegating to the doPut method for processing product updates in the cart.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPut(request, response);
	}
	
}
