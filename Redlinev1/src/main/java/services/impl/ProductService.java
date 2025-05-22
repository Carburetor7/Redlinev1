package services.impl;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.DBConnection;
import models.Demand;
import models.Product;
import services.ProductInterface;
import utils.IDUtil;
import utils.MailMessage;

public class ProductService implements ProductInterface {

	/**
	 * Adds a new product to the database.
	 *
	 * This method creates a new product instance with the provided details and generates a unique
	 * product ID using the IDUtil class. It then calls the overloaded addProduct method to insert
	 * the product into the database.
	 *
	 * @param prodName The name of the product.
	 * @param prodType The type or category of the product.
	 * @param prodInfo Additional information or description about the product.
	 * @param prodPrice The price of the product.
	 * @param prodQuantity The quantity of the product available.
	 * @param prodImage An InputStream containing the image data of the product.
	 * @return A status message indicating whether the product was successfully added to the database.
	 */
	@Override
	public String addProduct(String prodName, String prodType, String prodInfo, double prodPrice, int prodQuantity,
			InputStream prodImage) {
		// TODO Auto-generated method stub
		String status = null;
		String prodId = IDUtil.generateId();

		Product product = new Product(prodId, prodName, prodType, prodInfo, prodPrice, prodQuantity, prodImage);

		status = addProduct(product);

		return status;
	}

	/**
	 * Adds a product to the database based on the provided Product object.
	 *
	 * This method inserts a new product into the database using the details specified in the Product
	 * object. If the product ID is not already set in the Product object, a new ID is generated using
	 * the IDUtil class. The product information including ID, name, type, information, price, quantity,
	 * and image are added to the 'product' table in the database.
	 *
	 * @param product The Product object containing details of the product to be added.
	 * @return A status message indicating the result of the product registration process.
	 *         - If the product is added successfully, the message includes the product ID.
	 *         - If an error occurs during registration, an error message is returned.
	 */
	@Override
	public String addProduct(Product product) {
		// TODO Auto-generated method stub
		String status = "Product Registration Failed!";

		if (product.getProdId() == null)
			product.setProdId(IDUtil.generateId());

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("insert into product values(?,?,?,?,?,?,?);");
			ps.setString(1, product.getProdId());
			ps.setString(2, product.getProdName());
			ps.setString(3, product.getProdType());
			ps.setString(4, product.getProdInfo());
			ps.setDouble(5, product.getProdPrice());
			ps.setInt(6, product.getProdQuantity());
			ps.setBlob(7, product.getProdImage());

			int k = ps.executeUpdate();

			if (k > 0) {

				status = "Product Added Successfully with Product Id: " + product.getProdId();

			} else {

				status = "Product Updation Failed!";
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return status;
	}

	/**
	 * Removes a product from the database based on the provided product ID.
	 *
	 * This method deletes a product from the 'product' table in the database using the specified
	 * product ID. Additionally, it removes any references to the product in the 'usercart' table,
	 * ensuring that the product is completely removed from the system.
	 *
	 * @param prodId The ID of the product to be removed.
	 * @return A status message indicating the result of the product removal process.
	 *         - If the product is removed successfully, the message indicates successful removal.
	 *         - If an error occurs during removal, an error message with details is returned.
	 */
	@Override
	public String removeProduct(String prodId) {
		// TODO Auto-generated method stub
		
		String status = "Product Removal Failed!";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;

		try {
			ps = con.prepareStatement("delete from product where pid=?");
			ps.setString(1, prodId);

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "Product Removed Successfully!";

				ps2 = con.prepareStatement("delete from usercart where prodid=?");

				ps2.setString(1, prodId);

				ps2.executeUpdate();

			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(ps2);

		return status;
	}

	/**
	 * Updates an existing product with new information in the database.
	 *
	 * This method updates an existing product's details in the 'product' table of the database
	 * based on the provided previous product information and the updated product information.
	 * It checks if the product IDs of the previous and updated products match before proceeding
	 * with the update operation. If the IDs don't match, the update operation is considered invalid.
	 *
	 * @param prevProduct   The previous product information before the update.
	 * @param updatedProduct The updated product information to be applied.
	 * @return A status message indicating the result of the product update operation.
	 *         - If the product is updated successfully, the message indicates successful update.
	 *         - If the product IDs don't match or an error occurs during update, an appropriate
	 *           error message with details is returned.
	 */
	@Override
	public String updateProduct(Product prevProduct, Product updatedProduct) {
		// TODO Auto-generated method stub
		
		String status = "Product Updation Failed!";

		if (!prevProduct.getProdId().equals(updatedProduct.getProdId())) {

			status = "Both Products are Different, Updation Failed!";

			return status;
		}

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement(
					"update product set pname=?,ptype=?,pinfo=?,pprice=?,pquantity=?,image=? where pid=?");

			ps.setString(1, updatedProduct.getProdName());
			ps.setString(2, updatedProduct.getProdType());
			ps.setString(3, updatedProduct.getProdInfo());
			ps.setDouble(4, updatedProduct.getProdPrice());
			ps.setInt(5, updatedProduct.getProdQuantity());
			ps.setBlob(6, updatedProduct.getProdImage());
			ps.setString(7, prevProduct.getProdId());

			int k = ps.executeUpdate();

			if (k > 0)
				status = "Product Updated Successfully!";

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return status;
	}

	/**
	 * Updates the price of a product in the database.
	 *
	 * This method updates the price of a product in the 'product' table of the database
	 * based on the provided product ID and the new price.
	 *
	 * @param prodId       The ID of the product whose price needs to be updated.
	 * @param updatedPrice The new price to be set for the product.
	 * @return A status message indicating the result of the price update operation.
	 *         - If the price is updated successfully, the message indicates successful update.
	 *         - If an error occurs during the update, an error message with details is returned.
	 */
	@Override
	public String updateProductPrice(String prodId, double updatedPrice) {
		// TODO Auto-generated method stub
		
		String status = "Price Updation Failed!";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("update product set pprice=? where pid=?");

			ps.setDouble(1, updatedPrice);
			ps.setString(2, prodId);

			int k = ps.executeUpdate();

			if (k > 0)
				status = "Price Updated Successfully!";
		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return status;
	}

	/**
	 * Retrieves a list of all products from the database.
	 *
	 * This method retrieves and returns a list of all products available in the 'product' table
	 * of the database. Each product in the list contains details such as ID, name, type, information,
	 * price, quantity, and image.
	 *
	 * @return A list of Product objects representing all products in the database.
	 *         - If products are found in the database, the list contains Product objects with details.
	 *         - If no products are found or an error occurs during retrieval, an empty list is returned.
	 */
	@Override
	public List<Product> getAllProducts() {
		// TODO Auto-generated method stub
		
		List<Product> products = new ArrayList<Product>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from product");

			rs = ps.executeQuery();

			while (rs.next()) {

				Product product = new Product();

				product.setProdId(rs.getString(1));
				product.setProdName(rs.getString(2));
				product.setProdType(rs.getString(3));
				product.setProdInfo(rs.getString(4));
				product.setProdPrice(rs.getDouble(5));
				product.setProdQuantity(rs.getInt(6));
				product.setProdImage(rs.getAsciiStream(7));

				products.add(product);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return products;
	}

	/**
	 * Retrieves a list of products by their type from the database.
	 *
	 * This method retrieves and returns a list of products from the 'product' table in the database
	 * based on the specified type. It performs a case-insensitive search for products whose type
	 * matches or partially matches the provided type parameter.
	 *
	 * @param type The type of products to retrieve (e.g., "electronics", "clothing").
	 * @return A list of Product objects representing products of the specified type.
	 *         - If products matching the type are found in the database, the list contains Product objects with details.
	 *         - If no matching products are found or an error occurs during retrieval, an empty list is returned.
	 */
	@Override
	public List<Product> getAllProductsByType(String type) {
		// TODO Auto-generated method stub
		
		List<Product> products = new ArrayList<Product>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("SELECT * FROM `origin_tech`.product where lower(ptype) like ?;");
			ps.setString(1, "%" + type + "%");
			rs = ps.executeQuery();

			while (rs.next()) {

				Product product = new Product();

				product.setProdId(rs.getString(1));
				product.setProdName(rs.getString(2));
				product.setProdType(rs.getString(3));
				product.setProdInfo(rs.getString(4));
				product.setProdPrice(rs.getDouble(5));
				product.setProdQuantity(rs.getInt(6));
				product.setProdImage(rs.getAsciiStream(7));

				products.add(product);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return products;
	}

	/**
	 * Searches for products in the database based on a search query.
	 *
	 * This method performs a search across product type, name, and information fields in the database
	 * to find products that match or partially match the provided search query. The search is case-insensitive.
	 *
	 * @param search The search query used to find matching products.
	 * @return A list of Product objects representing products that match the search query.
	 *         - If products matching the search query are found in the database, the list contains Product objects with details.
	 *         - If no matching products are found or an error occurs during retrieval, an empty list is returned.
	 */
	@Override
	public List<Product> searchAllProducts(String search) {
		// TODO Auto-generated method stub
		
		List<Product> products = new ArrayList<Product>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement(
					"SELECT * FROM `origin_tech`.product where lower(ptype) LIKE ? or lower(pname) like ? or lower(pinfo) like ?");
			search = "%" + search + "%";
			ps.setString(1, search);
			ps.setString(2, search);
			ps.setString(3, search);
			rs = ps.executeQuery();

			while (rs.next()) {

				Product product = new Product();

				product.setProdId(rs.getString(1));
				product.setProdName(rs.getString(2));
				product.setProdType(rs.getString(3));
				product.setProdInfo(rs.getString(4));
				product.setProdPrice(rs.getDouble(5));
				product.setProdQuantity(rs.getInt(6));
				product.setProdImage(rs.getAsciiStream(7));

				products.add(product);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return products;
	}

	/**
	 * Retrieves the image data associated with a specific product from the database.
	 *
	 * This method fetches the image data (as a byte array) for a product identified by its unique product ID (prodId)
	 * from the database. If the product with the given ID exists and has an associated image, the method returns
	 * the byte array representing the image. If no image is found or an error occurs during retrieval, null is returned.
	 *
	 * @param prodId The product ID used to identify the product whose image data is to be retrieved.
	 * @return A byte array representing the image data of the product if found, or null if no image is found or an error occurs.
	 *         - If an image is found for the specified product ID, the byte array contains the image data.
	 *         - If no image is associated with the product ID or an error occurs during retrieval, null is returned.
	 */
	@Override
	public byte[] getImage(String prodId) {
		// TODO Auto-generated method stub
		byte[] image = null;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select image from product where  pid=?");

			ps.setString(1, prodId);

			rs = ps.executeQuery();

			if (rs.next())
				image = rs.getBytes("image");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return image;
		
	}

	/**
	 * Retrieves the details of a product based on its unique product ID (prodId) from the database.
	 *
	 * This method fetches the details of a product, including its ID, name, type, description, price, quantity,
	 * and image (if available), from the database based on the provided product ID (prodId). If a product with
	 * the given ID exists in the database, its details are encapsulated in a Product object and returned. If no
	 * product is found with the specified ID or an error occurs during retrieval, null is returned.
	 *
	 * @param prodId The unique product ID used to identify the product whose details are to be retrieved.
	 * @return A Product object containing the details of the product if found, or null if no product is found
	 *         or an error occurs during retrieval.
	 *         - If a product with the specified ID is found in the database, its details are encapsulated in
	 *           the returned Product object.
	 *         - If no product is found with the given ID or an error occurs during retrieval, null is returned.
	 */
	@Override
	public Product getProductDetails(String prodId) {
		// TODO Auto-generated method stub
		
		Product product = null;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from product where pid=?");

			ps.setString(1, prodId);
			rs = ps.executeQuery();

			if (rs.next()) {
				product = new Product();
				product.setProdId(rs.getString(1));
				product.setProdName(rs.getString(2));
				product.setProdType(rs.getString(3));
				product.setProdInfo(rs.getString(4));
				product.setProdPrice(rs.getDouble(5));
				product.setProdQuantity(rs.getInt(6));
				product.setProdImage(rs.getAsciiStream(7));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return product;
	}

	/**
	 * Updates the details of a product in the database without changing its image.
	 *
	 * This method is responsible for updating the details of a product in the database without modifying its
	 * associated image. It first checks if the previous product ID matches the updated product ID to ensure
	 * consistency. If they are different, the method returns a failure status indicating that both products are
	 * different.
	 *
	 * If the product IDs match, the method proceeds to update the product details in the database. It updates the
	 * product name, type, info, price, quantity, and image (if provided) based on the updated product object. If
	 * the update operation is successful and the updated quantity is greater than the previous quantity, it also
	 * checks for customer demands for the product and notifies them via email about the availability of the
	 * product. Additionally, it removes the product from the list of demanded products for those customers.
	 *
	 * @param prevProductId The previous product ID that needs to be updated.
	 * @param updatedProduct The updated Product object containing the new details to be updated in the database.
	 * @return A string status indicating the outcome of the product update operation:
	 *         - If the product IDs are different, "Both Products are Different, Updation Failed!" is returned.
	 *         - If the product is successfully updated without changing the image and the quantity is increased,
	 *           "Product Updated Successfully! And Mail Send to the customers who were waiting for this product!"
	 *           is returned along with the mail notification to customers.
	 *         - If the product is successfully updated without changing the image and the quantity is not increased,
	 *           "Product Updated Successfully!" is returned.
	 *         - If the product is not available in the store, "Product Not available in the store!" is returned.
	 *         - If an SQL exception occurs during the update operation, "Product Updation Failed!" is returned.
	 */
	@Override
	public String updateProductWithoutImage(String prevProductId, Product updatedProduct) {
		// TODO Auto-generated method stub
		
		String status = "Product Updation Failed!";

		if (!prevProductId.equals(updatedProduct.getProdId())) {

			status = "Both Products are Different, Updation Failed!";

			return status;
		}  

		int prevQuantity = new ProductService().getProductQuantity(prevProductId);
		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("update product set pname=?,ptype=?,pinfo=?,pprice=?,pquantity=?,image=? where pid=?");

			ps.setString(1, updatedProduct.getProdName());
			ps.setString(2, updatedProduct.getProdType());
			ps.setString(3, updatedProduct.getProdInfo());
			ps.setDouble(4, updatedProduct.getProdPrice());
			ps.setInt(5, updatedProduct.getProdQuantity());
			ps.setBlob(6, updatedProduct.getProdImage());
			ps.setString(7, prevProductId);

			int k = ps.executeUpdate();
			// System.out.println("prevQuantity: "+prevQuantity);
			if ((k > 0) && (prevQuantity < updatedProduct.getProdQuantity())) {
				status = "Product Updated Successfully!";
				// System.out.println("updated!");
				List<Demand> demandList = new DemandService().haveDemanded(prevProductId);

				for (Demand demand : demandList) {

					String userFName = new UserService().getFName(demand.getUserName());
					try {
						MailMessage.productAvailableNow(demand.getUserName(), userFName, updatedProduct.getProdName(),
								prevProductId);
					} catch (Exception e) {
						System.out.println("Mail Sending Failed: " + e.getMessage());
					}
					boolean flag = new DemandService().removeProduct(demand.getUserName(), prevProductId);

					if (flag)
						status += " And Mail Send to the customers who were waiting for this product!";
				}
			} else if (k > 0)
				status = "Product Updated Successfully!";
			else
				status = "Product Not available in the store!";

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		// System.out.println("Prod Update status : "+status);

		return status;
	}

	/**
	 * Retrieves the price of a product based on its product ID.
	 *
	 * This method is responsible for fetching the price of a product from the database using its unique product ID.
	 * It establishes a database connection, executes a prepared SQL statement to select the product's price, and
	 * retrieves the price value from the result set.
	 *
	 * @param prodId The product ID of the product whose price is to be retrieved.
	 * @return The price of the product as a double value. If the product ID is not found in the database or an SQL
	 *         exception occurs during the retrieval process, the default price of 0.0 is returned.
	 */
	@Override
	public double getProductPrice(String prodId) {
		// TODO Auto-generated method stub
		
		double price = 0;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from product where pid=?");

			ps.setString(1, prodId);
			rs = ps.executeQuery();

			if (rs.next()) {
				price = rs.getDouble("pprice");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return price;

	}

	/**
	 * Decreases the quantity of a product by a specified amount after a successful sale.
	 *
	 * This method is responsible for reducing the quantity of a product in the database by a specified amount
	 * after a successful sale transaction. It takes the product ID and the quantity to be deducted as parameters,
	 * establishes a database connection, and executes an SQL update statement to decrement the product quantity.
	 *
	 * @param prodId The product ID of the product to be updated.
	 * @param n      The quantity to be deducted from the product's current quantity.
	 * @return A boolean value indicating whether the operation was successful (true) or not (false).
	 */
	@Override
	public boolean sellNProduct(String prodId, int n) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {

			ps = con.prepareStatement("update product set pquantity=(pquantity - ?) where pid=?");

			ps.setInt(1, n);

			ps.setString(2, prodId);

			int k = ps.executeUpdate();

			if (k > 0)
				flag = true;
		} catch (SQLException e) {
			flag = false;
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return flag;
	}

	/**
	 * Retrieves the current quantity of a product based on its product ID.
	 *
	 * This method queries the database to retrieve the current quantity of a product
	 * specified by its product ID. It establishes a database connection, executes an SQL
	 * SELECT statement to fetch the product quantity, and returns the retrieved quantity.
	 *
	 * @param prodId The product ID of the product whose quantity is to be retrieved.
	 * @return The current quantity of the product specified by the product ID.
	 *         Returns 0 if the product ID is not found or an SQL exception occurs.
	 */
	@Override
	public int getProductQuantity(String prodId) {
		// TODO Auto-generated method stub
		
		int quantity = 0;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from product where pid=?");

			ps.setString(1, prodId);
			rs = ps.executeQuery();

			if (rs.next()) {
				quantity = rs.getInt("pquantity");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return quantity;
	}

	
}
