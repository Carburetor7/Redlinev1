package services.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.DBConnection;
import models.Cart;
import models.Demand;
import models.Product;
import services.CartInterface;

public class CartService implements CartInterface {
	
	/**
	 * Adds a product to the user's cart with the specified quantity.
	 * If the product already exists in the cart, the quantity is updated accordingly.
	 * Handles availability checks and updates cart quantities accordingly.
	 * If the available quantity is less than requested, adjusts the cart and creates a demand.
	 * 
	 * @param userId  The user ID to associate with the cart item.
	 * @param prodId  The product ID to be added to the cart.
	 * @param prodQty The quantity of the product to be added.
	 * @return A status message indicating the result of adding the product to the cart.
	 */
	@Override
	public String addProductToCart(String userId, String prodId, int prodQty) {
		// TODO Auto-generated method stub
		
		String status = "Failed to Add into Cart";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from usercart where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, prodId);

			rs = ps.executeQuery();

			if (rs.next()) {

				int cartQuantity = rs.getInt("quantity");

				Product product = new ProductService().getProductDetails(prodId);

				int availableQty = product.getProdQuantity();

				prodQty += cartQuantity;
				//
				if (availableQty < prodQty) {

					status = updateProductToCart(userId, prodId, availableQty);

					status = "Only " + availableQty + " no of " + product.getProdName()
							+ " are available in the shop! So we are adding only " + availableQty
							+ " no of that item into Your Cart" + "";

					Demand demandBean = new Demand(userId, product.getProdId(), prodQty - availableQty);

					DemandService demand = new DemandService();

					boolean flag = demand.addProduct(demandBean);

					if (flag)
						status += "<br/>Later, We Will Mail You when " + product.getProdName()
								+ " will be available into the Store!";

				} else {
					status = updateProductToCart(userId, prodId, prodQty);

				}
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);
		DBConnection.closeConnection(ps2);

		return status;
	}

	/**
	 * Updates the quantity of a product in the user's cart or adds it if it doesn't exist.
	 * Handles scenarios where the quantity is increased, decreased, or set to zero.
	 * 
	 * @param userId  The user ID associated with the cart item.
	 * @param prodId  The product ID to be updated in the cart.
	 * @param prodQty The new quantity of the product in the cart.
	 * @return A status message indicating the result of updating the product in the cart.
	 */
	@Override
	public String updateProductToCart(String userId, String prodId, int prodQty) {
		// TODO Auto-generated method stub
		String status = "Failed to Add into Cart";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from usercart where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, prodId);

			rs = ps.executeQuery();

			if (rs.next()) {

				if (prodQty > 0) {
					ps2 = con.prepareStatement("update usercart set quantity=? where username=? and prodid=?");

					ps2.setInt(1, prodQty);

					ps2.setString(2, userId);

					ps2.setString(3, prodId);

					int k = ps2.executeUpdate();

					if (k > 0)
						status = "Product Successfully Updated to Cart!";
				} else if (prodQty == 0) {
					ps2 = con.prepareStatement("delete from usercart where username=? and prodid=?");

					ps2.setString(1, userId);

					ps2.setString(2, prodId);

					int k = ps2.executeUpdate();

					if (k > 0)
						status = "Product Successfully Updated in Cart!";
				}
			} else {

				ps2 = con.prepareStatement("insert into usercart values(?,?,?)");

				ps2.setString(1, userId);

				ps2.setString(2, prodId);

				ps2.setInt(3, prodQty);

				int k = ps2.executeUpdate();

				if (k > 0)
					status = "Product Successfully Updated to Cart!";

			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);
		DBConnection.closeConnection(ps2);

		return status;
	}

	/**
	 * Retrieves all cart items for a specific user from the database.
	 * 
	 * @param userId The user ID whose cart items are to be retrieved.
	 * @return A list of Cart objects representing the cart items for the user.
	 */
	@Override
	public List<Cart> getAllCartItems(String userId) {
		// TODO Auto-generated method stub
		List<Cart> items = new ArrayList<Cart>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from usercart where username=?");

			ps.setString(1, userId);

			rs = ps.executeQuery();

			while (rs.next()) {
				Cart cart = new Cart();

				cart.setUserId(rs.getString("username"));
				cart.setProdId(rs.getString("prodid"));
				cart.setQuantity(Integer.parseInt(rs.getString("quantity")));

				items.add(cart);

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return items;
	}
	

	/**
	 * Retrieves the total count of items in the user's cart from the database.
	 * 
	 * @param userId The user ID whose cart count is to be retrieved.
	 * @return An integer representing the total count of items in the user's cart.
	 */
	@Override
	public int getCartCount(String userId) {
		// TODO Auto-generated method stub
		int count = 0;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select sum(quantity) from usercart where username=?");

			ps.setString(1, userId);

			rs = ps.executeQuery();

			if (rs.next() && !rs.wasNull())
				count = rs.getInt(1);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return count;
	}

	/**
	 * Retrieves the count of a specific item in the user's cart from the database.
	 * 
	 * @param userId The user ID whose cart count is to be retrieved.
	 * @param itemId The ID of the item for which the count is to be retrieved.
	 * @return An integer representing the count of the specified item in the user's cart.
	 *         Returns 0 if userId or itemId is null.
	 */
	@Override
	public int getCartItemCount(String userId, String itemId) {
		// TODO Auto-generated method stub
		int count = 0;
		if (userId == null || itemId == null)
			return 0;
		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select quantity from usercart where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, itemId);

			rs = ps.executeQuery();

			if (rs.next() && !rs.wasNull())
				count = rs.getInt(1);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return count;
	}

	/**
	 * Removes a product from the user's cart in the database.
	 * 
	 * @param userId The user ID whose cart contains the product to be removed.
	 * @param prodId The ID of the product to be removed from the cart.
	 * @return A string indicating the status of the product removal process.
	 */
	@Override
	public String removeProductFromCart(String userId, String prodId) {
		// TODO Auto-generated method stub
		
		String status = "Product Removal Failed";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from usercart where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, prodId);

			rs = ps.executeQuery();

			if (rs.next()) {

				int prodQuantity = rs.getInt("quantity");

				prodQuantity -= 1;

				if (prodQuantity > 0) {
					ps2 = con.prepareStatement("update usercart set quantity=? where username=? and prodid=?");

					ps2.setInt(1, prodQuantity);

					ps2.setString(2, userId);

					ps2.setString(3, prodId);

					int k = ps2.executeUpdate();

					if (k > 0)
						status = "Product Successfully removed from the Cart!";
				} else if (prodQuantity <= 0) {

					ps2 = con.prepareStatement("delete from usercart where username=? and prodid=?");

					ps2.setString(1, userId);

					ps2.setString(2, prodId);

					int k = ps2.executeUpdate();

					if (k > 0)
						status = "Product Successfully removed from the Cart!";
				}

			} else {

				status = "Product Not Available in the cart!";

			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);
		DBConnection.closeConnection(ps2);

		return status;
	}

	/**
	 * Removes a specific product from the user's cart in the database.
	 * 
	 * @param userId The ID of the user whose cart contains the product to be removed.
	 * @param prodId The ID of the product to be removed from the cart.
	 * @return True if the product was successfully removed, false otherwise.
	 */
	@Override
	public boolean removeAProduct(String userId, String prodId) {
		// TODO Auto-generated method stub
		// Initialize flag to track removal success
		boolean flag = false;

		  // Obtain database connection
		Connection con = DBConnection.provideConnection();

		 // Initialize SQL statement and result set
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			 // Execute SQL delete statement to remove the product from the user's cart
			ps = con.prepareStatement("delete from usercart where username=? and prodid=?");
			ps.setString(1, userId);
			ps.setString(2, prodId);

			  // Get the number of rows affected by the delete operation
			int k = ps.executeUpdate();

			   // If at least one row was deleted, set flag to true
			if (k > 0)
				flag = true;

		} catch (SQLException e) {
			flag = false;
			e.printStackTrace();
		}
		 // Close database connections and resources
		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

	    // Return the flag indicating the success of the product removal operation
		return flag;
	}
	
	/**
	 * Retrieves the total quantity of a specific product in the user's cart.
	 * 
	 * @param userId The ID of the user whose cart contains the product.
	 * @param prodId The ID of the product to count in the cart.
	 * @return The total quantity of the specified product in the user's cart.
	 */
	public int getProductCount(String userId, String prodId) {
		 // Initialize count to track product quantity
		int count = 0;

		 // Obtain database connection
		Connection con = DBConnection.provideConnection();

		// Initialize SQL statement and result set
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			 // Execute SQL query to calculate the sum of product quantities in the cart
			ps = con.prepareStatement("select sum(quantity) from usercart where username=? and prodid=?");
			ps.setString(1, userId);
			ps.setString(2, prodId);
			rs = ps.executeQuery();

			 // If the result set has data and is not null, retrieve the total quantity
			if (rs.next() && !rs.wasNull())
				count = rs.getInt(1);

		} catch (SQLException e) {
			 // If an SQL exception occurs, print the stack trac
			e.printStackTrace();
		}

		 // Return the total quantity of the specified product in the user's cart
		return count;
	}

	
}
