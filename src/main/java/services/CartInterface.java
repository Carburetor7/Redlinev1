package services;

import java.util.List;

import models.Cart;

public interface CartInterface {

	public String addProductToCart(String userId, String prodId, int prodQty);

	public String updateProductToCart(String userId, String prodId, int prodQty);

	public List<Cart> getAllCartItems(String userId);

	public int getCartCount(String userId);

	public int getCartItemCount(String userId, String itemId);

	public String removeProductFromCart(String userId, String prodId);

	public boolean removeAProduct(String userId, String prodId);
}
