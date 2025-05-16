package services.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.DBConnection;
import models.Cart;
import models.OrderBean;
import models.OrderDetails;
import models.Transaction;
import services.OrderInterface;
import utils.MailMessage;

public class OrderService implements OrderInterface {

	/**
	 * Processes the payment for a user's order.
	 *
	 * @param userName   The username of the user placing the order.
	 * @param paidAmount The amount paid for the order.
	 * @return A string indicating the status of the order placement (success or failure).
	 */
	@Override
	public String paymentSuccess(String userName, double paidAmount) {
		// TODO Auto-generated method stub
		
		String status = "Order Placement Failed!";

		List<Cart> cartItems = new ArrayList<Cart>();
		cartItems = new CartService().getAllCartItems(userName);

		if (cartItems.size() == 0)
			return status;

		Transaction transaction = new Transaction(userName, paidAmount);
		boolean ordered = false;

		String transactionId = transaction.getTransactionId();

		// System.out.println("Transaction: "+transaction.getTransactionId()+"
		// "+transaction.getTransAmount()+" "+transaction.getUserName()+"
		// "+transaction.getTransDateTime());

		for (Cart item : cartItems) {

			double amount = new ProductService().getProductPrice(item.getProdId()) * item.getQuantity();

			OrderBean order = new OrderBean(transactionId, item.getProdId(), item.getQuantity(), amount);

			ordered = addOrder(order);
			if (!ordered)
				break;
			else {
				ordered = new CartService().removeAProduct(item.getUserId(), item.getProdId());
			}

			if (!ordered)
				break;
			else
				ordered = new ProductService().sellNProduct(item.getProdId(), item.getQuantity());

			if (!ordered)
				break;
		}

		if (ordered) {
			ordered = new OrderService().addTransaction(transaction);
			if (ordered) {

				MailMessage.transactionSuccess(userName, new UserService().getFName(userName),
						transaction.getTransactionId(), transaction.getTransAmount());

				status = "Order Placed Successfully!";
			}
		}

		return status;
	}

	/**
	 * This method adds an order to the database.
	 * It takes an OrderBean object containing transaction details,
	 * such as transaction ID, product ID, quantity, amount, and status.
	 * The method inserts these details into the 'orders' table in the database.
	 *
	 * @param order The OrderBean object containing order details.
	 * @return True if the order is successfully added, false otherwise.
	 */
	@Override
	public boolean addOrder(OrderBean order) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("insert into orders values(?,?,?,?,?)");

			ps.setString(1, order.getTransactionId());
			ps.setString(2, order.getProductId());
			ps.setInt(3, order.getQuantity());
			ps.setDouble(4, order.getAmount());
			ps.setInt(5, 0);

			int k = ps.executeUpdate();

			if (k > 0)
				flag = true;

		} catch (SQLException e) {
			flag = false;
			e.printStackTrace();
		}

		return flag;
		
	}

	/**
	 * This method adds a transaction to the 'transactions' table in the database.
	 * It takes a Transaction object containing transaction details such as transaction ID,
	 * user name, transaction date and time, and transaction amount.
	 * The method inserts these details into the 'transactions' table.
	 *
	 * @param transaction The Transaction object containing transaction details.
	 * @return True if the transaction is successfully added, false otherwise.
	 */
	@Override
	public boolean addTransaction(Transaction transaction) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("insert into transactions values(?,?,?,?)");

			ps.setString(1, transaction.getTransactionId());
			ps.setString(2, transaction.getUserName());
			ps.setTimestamp(3, transaction.getTransDateTime());
			ps.setDouble(4, transaction.getTransAmount());

			int k = ps.executeUpdate();

			if (k > 0)
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return flag;
	}

	/**
	 * This method counts the total quantity of a product that has been sold based on its product ID.
	 * It retrieves this information from the 'orders' table in the database, specifically summing up
	 * the quantity of orders for the specified product ID.
	 *
	 * @param prodId The product ID for which the sold quantity is to be counted.
	 * @return The total quantity of the product that has been sold.
	 */
	@Override
	public int countSoldItem(String prodId) {
		// TODO Auto-generated method stub
		int count = 0;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select sum(quantity) from orders where prodid=?");

			ps.setString(1, prodId);

			rs = ps.executeQuery();

			if (rs.next())
				count = rs.getInt(1);

		} catch (SQLException e) {
			count = 0;
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return count;
	}

	/**
	 * Retrieves a list of all orders from the database.
	 * This method fetches all order details including order ID, product ID, quantity,
	 * amount, and shipment status from the 'orders' table in the database.
	 *
	 * @return A list containing OrderBean objects representing all orders in the database.
	 */
	@Override
	public List<OrderBean> getAllOrders() {
		// TODO Auto-generated method stub
		
		List<OrderBean> orderList = new ArrayList<OrderBean>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from orders");

			rs = ps.executeQuery();

			while (rs.next()) {

				OrderBean order = new OrderBean(rs.getString("orderid"), rs.getString("prodid"), rs.getInt("quantity"),
						rs.getDouble("amount"), rs.getInt("shipped"));

				orderList.add(order);

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return orderList;
	}

	/**
	 * Retrieves a list of orders associated with a specific user identified by their email ID.
	 * This method fetches order details including order ID, product ID, quantity, amount,
	 * and shipment status from the 'orders' table and 'transactions' table in the database.
	 *
	 * @param emailId The email ID of the user whose orders are to be retrieved.
	 * @return A list containing OrderBean objects representing orders associated with the user.
	 */
	@Override
	public List<OrderBean> getOrdersByUserId(String emailId) {
		// TODO Auto-generated method stub
		
		List<OrderBean> orderList = new ArrayList<OrderBean>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement(
					"SELECT * FROM orders o inner join transactions t on o.orderid = t.transid where username=?");
			ps.setString(1, emailId);
			rs = ps.executeQuery();

			while (rs.next()) {

				OrderBean order = new OrderBean(rs.getString("t.transid"), rs.getString("t.prodid"),
						rs.getInt("quantity"), rs.getDouble("t.amount"), rs.getInt("shipped"));

				orderList.add(order);

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return orderList;
	}

	/**
	 * Retrieves a list of OrderDetails objects containing detailed information about all orders
	 * associated with a specific user identified by their email ID.
	 *
	 * This method fetches order details including order ID, product ID, product image, product name,
	 * quantity, amount, order time, and shipment status from the 'orders', 'product', and 'transactions'
	 * tables in the database based on the provided user email ID.
	 *
	 * @param userEmailId The email ID of the user whose order details are to be retrieved.
	 * @return A list containing OrderDetails objects representing detailed order information for the user.
	 */
	@Override
	public List<OrderDetails> getAllOrderDetails(String userEmailId) {
		// TODO Auto-generated method stub
		
		List<OrderDetails> orderList = new ArrayList<OrderDetails>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement(
					"SELECT  p.pid as prodid, o.orderid as orderid, o.shipped as shipped, p.image as image, p.pname as pname, o.quantity as qty, o.amount as amount, t.time as time FROM orders o, product p, transactions t where o.orderid=t.transid and o.orderid = t.transid and p.pid=o.prodid and t.username=?");
			ps.setString(1, userEmailId);
			rs = ps.executeQuery();

			while (rs.next()) {

				OrderDetails order = new OrderDetails();
				order.setOrderId(rs.getString("orderid"));
				order.setProdImage(rs.getAsciiStream("image"));
				order.setProdName(rs.getString("pname"));
				order.setQty(rs.getString("qty"));
				order.setAmount(rs.getString("amount"));
				order.setTime(rs.getTimestamp("time"));
				order.setProductId(rs.getString("prodid"));
				order.setShipped(rs.getInt("shipped"));
				orderList.add(order);

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return orderList;
	}

	/**
	 * Marks an order as shipped in the database based on the provided order ID and product ID.
	 *
	 * This method updates the 'orders' table in the database to set the 'shipped' flag to 1 (indicating
	 * shipped status) for the specified order and product IDs if the order was not already marked as shipped.
	 *
	 * @param orderId The ID of the order to be marked as shipped.
	 * @param prodId The ID of the product associated with the order.
	 * @return A status message indicating whether the order was successfully marked as shipped or not.
	 */
	@Override
	public String shipNow(String orderId, String prodId) {
		// TODO Auto-generated method stub
		
		String status = "FAILURE";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;

		try {
			ps = con.prepareStatement("update orders set shipped=1 where orderid=? and prodid=? and shipped=0");

			ps.setString(1, orderId);
			ps.setString(2, prodId);

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "Order Has been shipped successfully!!";
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);

		return status;
	}

	
}
