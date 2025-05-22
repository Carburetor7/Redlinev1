package services;

import java.util.List;

import models.OrderBean;
import models.OrderDetails;
import models.Transaction;


public interface OrderInterface {

	public String paymentSuccess(String userName, double paidAmount);

	public boolean addOrder(OrderBean order);

	public boolean addTransaction(Transaction transaction);

	public int countSoldItem(String prodId);

	public List<OrderBean> getAllOrders();

	public List<OrderBean> getOrdersByUserId(String emailId);

	public List<OrderDetails> getAllOrderDetails(String userEmailId);

	public String shipNow(String orderId, String prodId);
}
