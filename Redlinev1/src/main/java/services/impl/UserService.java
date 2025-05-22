package services.impl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.DBConnection;
import constant.UserConstant;
import models.User;
import services.UserInterface;
import utils.MailMessage;


public class UserService implements UserInterface {
	/**
	 * Registers a new user with the provided details.
	 *
	 * This method creates a new User object with the given parameters and attempts to register
	 * the user by calling the overloaded registerUser method that takes a User object as input.
	 * It then returns the status of the registration process, which can be a success message
	 * or an error message.
	 *
	 * @param userName The username of the user to be registered.
	 * @param mobileNo The mobile number of the user.
	 * @param emailId The email ID of the user.
	 * @param address The address of the user.
	 * @param pinCode The PIN code of the user's location.
	 * @param password The password for the user account.
	 * @return A status message indicating the result of the registration process.
	 *         Returns a success message if the registration is successful.
	 *         Returns an error message if registration fails due to invalid data or database errors.
	 */
	@Override
	public String registerUser(String userName, Long mobileNo, String emailId, String address, int pinCode,
			String password) {

		User user = new User(userName, mobileNo, emailId, address, pinCode, password);

		String status = registerUser(user);

		return status;
	}
	
	/**
	 * Registers a new user with the provided User object.
	 *
	 * This method takes a User object as input and attempts to register the user in the database.
	 * It first checks if the user's email is already registered. If the email is already in use,
	 * the registration fails with a message indicating that the email is already registered.
	 *
	 * If the email is not already registered, the method proceeds to insert the user's details
	 * into the database using a prepared statement. After successful insertion, it sends a
	 * registration success email to the user and returns a success message. If any error occurs
	 * during the database operation, it catches the SQLException and returns an error message
	 * along with the stack trace.
	 *
	 * @param user The User object containing the details of the user to be registered.
	 * @return A status message indicating the result of the registration process.
	 *         Returns "User Registered Successfully!" if registration is successful.
	 *         Returns "Email Id Already Registered!" if the email is already in use.
	 *         Returns an error message if registration fails due to database errors.
	 */
	@Override
	public String registerUser(User user) {

		String status = "User Registration Failed!";

		boolean isRegtd = isRegistered(user.getEmail());

		if (isRegtd) {
			status = "Email Id Already Registered!";
			return status;
		}
		Connection conn = DBConnection.provideConnection();
		PreparedStatement ps = null;
		if (conn != null) {
			System.out.println("Connected Successfully!");
		}

		try {

			ps = conn.prepareStatement("insert into " + UserConstant.TABLE_USER + " values(?,?,?,?,?,?)");

			ps.setString(1, user.getEmail());
			ps.setString(2, user.getName());
			ps.setLong(3, user.getMobile());
			ps.setString(4, user.getAddress());
			ps.setInt(5, user.getPinCode());
			ps.setString(6, user.getPassword());

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "User Registered Successfully!";
				MailMessage.registrationSuccess(user.getEmail(), user.getName().split(" ")[0]);
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(ps);

		return status;
	}
	
	/**
	 * Updates the details of an existing user.
	 *
	 * This method takes a User object as input and updates the user's information in the database.
	 * It prepares and executes an SQL update statement to modify the user's name, mobile number,
	 * address, and pin code based on the provided User object's details. If the update operation
	 * is successful, the method returns a success message indicating that the profile has been
	 * updated successfully. If any error occurs during the database operation, it catches the
	 * SQLException, prints the stack trace, and returns an error message.
	 *
	 * @param user The User object containing the updated details of the user.
	 * @return A status message indicating the result of the update operation.
	 *         Returns "Profile Updated Successfully!" if the update is successful.
	 *         Returns an error message if the update operation fails due to database errors.
	 */
	public String updateUser(User user) {

		String status = "User Updation Failed!";
		
		Connection conn = DBConnection.provideConnection();
		PreparedStatement ps = null;
		if (conn != null) {
			System.out.println("Connected Successfully!");
		}

		try {

			ps = conn.prepareStatement("update user set name=?,mobile=?,address=?,pincode=? where email=?");

			ps.setString(1, user.getName());
			ps.setLong(2, user.getMobile());
			ps.setString(3, user.getAddress());
			ps.setInt(4, user.getPinCode());
			ps.setString(5, user.getEmail());

			int k = ps.executeUpdate();

			if (k > 0) {
				status = "Profile Updated Successfully!";
			}

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(ps);

		return status;
	}


	/**
	 * Checks if a user with the given email ID is already registered.
	 *
	 * This method queries the database to check if there exists a user record with the provided
	 * email ID. It prepares and executes an SQL SELECT statement to fetch user details based on
	 * the email ID. If a matching user record is found in the database, the method returns true
	 * indicating that the user is registered. If no matching record is found, it returns false.
	 * If any error occurs during the database operation, it catches the SQLException, prints the
	 * stack trace, and returns false.
	 *
	 * @param emailId The email ID of the user to check for registration.
	 * @return true if a user with the given email ID is registered in the database, false otherwise.
	 */
	@Override
	public boolean isRegistered(String emailId) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=?");

			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next())
				flag = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return flag;
	}

	/**
	 * Validates user credentials by checking the provided email ID and password against the database.
	 *
	 * This method queries the database to check if there exists a user record with the provided
	 * email ID and password combination. It prepares and executes an SQL SELECT statement to fetch
	 * user details based on the email ID and password. If a matching user record is found in the
	 * database, the method returns "valid" indicating that the credentials are valid. If no matching
	 * record is found, it returns "Login Denied! Incorrect Username or Password". If any error occurs
	 * during the database operation, it catches the SQLException, prints the stack trace, and returns
	 * an error message.
	 *
	 * @param emailId The email ID of the user to validate.
	 * @param password The password associated with the user's account.
	 * @return "valid" if the credentials are valid, otherwise an error message indicating login denial.
	 */
	@Override
	public String isValidCredential(String emailId, String password) {
		// TODO Auto-generated method stub
		String status = "Login Denied! Incorrect Username or Password";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select * from user where email=? and password=?");

			ps.setString(1, emailId);
			ps.setString(2, password);

			rs = ps.executeQuery();

			if (rs.next())
				status = "valid";

		} catch (SQLException e) {
			status = "Error: " + e.getMessage();
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);
		
		return status;
	}

	/**
	 * Retrieves user details based on the provided email ID and password.
	 *
	 * This method queries the database to fetch user details by matching the provided email ID
	 * and password with the corresponding records in the 'user' table. It prepares and executes
	 * an SQL SELECT statement with placeholders for email ID and password, sets the values for
	 * these placeholders using the method parameters, and then executes the query to fetch the
	 * user details if a matching record is found. If a record is found, it creates a new User
	 * object and sets its attributes (name, mobile number, email, address, pin code, and password)
	 * with the values retrieved from the database. If no matching record is found, it returns null.
	 * If any SQL exception occurs during the database operation, it catches the exception, prints
	 * the stack trace, and returns null.
	 *
	 * @param emailId The email ID of the user whose details are to be retrieved.
	 * @param password The password associated with the user's account.
	 * @return A User object containing the details of the user if found, or null if no matching record is found.
	 */
	@Override
	public User getUserDetails(String emailId, String password) {
		// TODO Auto-generated method stub
		User user = null;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=? and password=?");
			ps.setString(1, emailId);
			ps.setString(2, password);
			rs = ps.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setName(rs.getString("name"));
				user.setMobile(rs.getLong("mobile"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setPinCode(rs.getInt("pincode"));
				user.setPassword(rs.getString("password"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return user;
	}
	
	
	
	/**
	 * Retrieves user details based on the provided email ID.
	 *
	 * This method queries the database to fetch user details by matching the provided email ID
	 * with the corresponding record in the 'user' table. It prepares and executes an SQL SELECT
	 * statement with a placeholder for email ID, sets the value for this placeholder using the
	 * method parameter, and then executes the query to fetch the user details if a matching record
	 * is found. If a record is found, it creates a new User object and sets its attributes (name,
	 * mobile number, email, address, pin code, and password) with the values retrieved from the database.
	 * If no matching record is found, it returns null. If any SQL exception occurs during the database
	 * operation, it catches the exception, prints the stack trace, and returns null.
	 *
	 * @param emailId The email ID of the user whose details are to be retrieved.
	 * @return A User object containing the details of the user if found, or null if no matching record is found.
	 */
	public User getUserDetails(String emailId) {
		// TODO Auto-generated method stub
		User user = null;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user where email=?");
			ps.setString(1, emailId);
			rs = ps.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setName(rs.getString("name"));
				user.setMobile(rs.getLong("mobile"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setPinCode(rs.getInt("pincode"));
				user.setPassword(rs.getString("password"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(rs);

		return user;
	}

	/**
	 * Retrieves the first name of a user based on the provided email ID.
	 *
	 * This method queries the database to fetch the user's first name by matching the provided email ID
	 * with the corresponding record in the 'user' table. It prepares and executes an SQL SELECT statement
	 * with a placeholder for email ID, sets the value for this placeholder using the method parameter, and
	 * then executes the query to retrieve the user's name if a matching record is found. If a record is found,
	 * it extracts the first name from the retrieved full name and returns it. If no matching record is found or
	 * if any SQL exception occurs during the database operation, it returns an empty string.
	 *
	 * @param emailId The email ID of the user whose first name is to be retrieved.
	 * @return The first name of the user if found, or an empty string if no matching record is found or an error occurs.
	 */
	@Override
	public String getFName(String emailId) {
		// TODO Auto-generated method stub
		
		String fname = "";

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select name from user where email=?");
			ps.setString(1, emailId);

			rs = ps.executeQuery();

			if (rs.next()) {
				fname = rs.getString(1);

				fname = fname.split(" ")[0];

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return fname;
	}

	/**
	 * Retrieves the address of a user based on the provided user ID (email ID).
	 *
	 * This method queries the database to fetch the user's address by matching the provided user ID
	 * with the corresponding record in the 'user' table. It prepares and executes an SQL SELECT statement
	 * with a placeholder for user ID, sets the value for this placeholder using the method parameter, and
	 * then executes the query to retrieve the user's address if a matching record is found. If a record is found,
	 * it assigns the retrieved address to the 'userAddr' variable and returns it. If no matching record is found or
	 * if any SQL exception occurs during the database operation, it returns an empty string.
	 *
	 * @param userId The user ID (email ID) of the user whose address is to be retrieved.
	 * @return The address of the user if found, or an empty string if no matching record is found or an error occurs.
	 */
	@Override
	public String getUserAddr(String userId) {
		// TODO Auto-generated method stub
		
		String userAddr = "";

		Connection con = DBConnection.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select address from user where email=?");

			ps.setString(1, userId);

			rs = ps.executeQuery();

			if (rs.next())
				userAddr = rs.getString(1);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return userAddr;
	}
}
