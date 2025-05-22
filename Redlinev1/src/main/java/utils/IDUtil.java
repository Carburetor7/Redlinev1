package utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class IDUtil {
	/**
	 * Generates a unique ID for products based on the current timestamp.
	 *
	 * This method creates a unique product ID by formatting the current date and time in the format "yyyyMMddhhmmss"
	 * using a SimpleDateFormat instance. It then appends a prefix "P" to the formatted timestamp to construct
	 * the product ID. The generated ID is returned as a string.
	 *
	 * @return A unique product ID generated based on the current timestamp.
	 */
	public static String generateId() {
		String pId = null;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		pId = sdf.format(new Date());
		pId = "P" + pId;

		return pId;
	}
	
	/**
	 * Generates a unique transaction ID based on the current timestamp.
	 *
	 * This method creates a unique transaction ID by formatting the current date and time in the format "yyyyMMddhhmmss"
	 * using a SimpleDateFormat instance. It then appends a prefix "T" to the formatted timestamp to construct
	 * the transaction ID. The generated ID is returned as a string.
	 *
	 * @return A unique transaction ID generated based on the current timestamp.
	 */
	public static String generateTransId() {
		String tId = null;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
		tId = sdf.format(new Date());
		tId = "T" + tId;

		return tId;
	}
}
