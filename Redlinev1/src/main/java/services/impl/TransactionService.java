package services.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.DBConnection;
import services.TransactionInterface;

public class TransactionService implements TransactionInterface {

	/**
	 * Retrieves the user ID associated with a transaction ID.
	 *
	 * This method queries the database to retrieve the user ID associated with a given
	 * transaction ID. It establishes a database connection, executes an SQL SELECT statement
	 * to fetch the username based on the transaction ID, and returns the retrieved user ID.
	 *
	 * @param transId The transaction ID for which the user ID is to be retrieved.
	 * @return The user ID associated with the specified transaction ID.
	 *         Returns an empty string if the transaction ID is not found or an SQL exception occurs.
	 */
	@Override
	public String getUserId(String transId) {
		// TODO Auto-generated method stub
		String userId = "";

		Connection con = DBConnection.provideConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {

			ps = con.prepareStatement("select username from transactions where transid=?");

			ps.setString(1, transId);

			rs = ps.executeQuery();

			if (rs.next())
				userId = rs.getString(1);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userId;
	}

}
