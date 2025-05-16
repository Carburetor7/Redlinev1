package services;

import java.io.InputStream;
import java.util.List;

import models.Product;

public interface ProductInterface {
	
	public String addProduct(String prodName, String prodType, String prodInfo, double prodPrice, int prodQuantity,
			InputStream prodImage);

	public String addProduct(Product product);

	public String removeProduct(String prodId);

	public String updateProduct(Product prevProduct, Product updatedProduct);

	public String updateProductPrice(String prodId, double updatedPrice);

	public List<Product> getAllProducts();

	public List<Product> getAllProductsByType(String type);

	public List<Product> searchAllProducts(String search);

	public byte[] getImage(String prodId);

	public Product getProductDetails(String prodId);

	public String updateProductWithoutImage(String prevProductId, Product updatedProduct);

	public double getProductPrice(String prodId);

	public boolean sellNProduct(String prodId, int n);

	public int getProductQuantity(String prodId);
}
