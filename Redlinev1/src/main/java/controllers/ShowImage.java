package controllers;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.impl.ProductService;


@WebServlet("/ShowImage")
public class ShowImage extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public ShowImage() {
		super();
	}
	
	/**
	 * Handles HTTP GET requests for retrieving product images.
	 * 
	 * @param request  The HttpServletRequest object containing the request parameters.
	 * @param response The HttpServletResponse object for sending the response.
	 * @throws ServletException If a servlet-specific error occurs.
	 * @throws IOException      If an I/O error occurs while processing the request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String prodId = request.getParameter("pid");

		ProductService dao = new ProductService();

		byte[] image = dao.getImage(prodId);

		if (image == null) {
			File fnew = new File(request.getServletContext().getRealPath("img/noimage.jpg"));
			BufferedImage originalImage = ImageIO.read(fnew);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(originalImage, "jpg", baos);
			image = baos.toByteArray();
		}

		ServletOutputStream sos = null;

		sos = response.getOutputStream();

		sos.write(image);

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
