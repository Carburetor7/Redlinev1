package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class DBConnection {
	private static Connection conn;
	
	/**
	 * Provides a database connection using the specified configuration properties.
	 * If the connection is not initialized or is closed, a new connection is established.
	 * 
	 * @return A Connection object representing the database connection.
	 */
	public static Connection provideConnection() {
		try {
			if(conn == null || conn.isClosed()) {
				ResourceBundle rb = ResourceBundle.getBundle("application");
				String connectionDatabase = rb.getString("db.connectionDatabase");
				String driverName = rb.getString("db.driverName");
				String username = rb.getString("db.username");
				String password = rb.getString("db.password");
				
				try {
					Class.forName(driverName);
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				conn = DriverManager.getConnection(connectionDatabase, username, password);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	
	/**
	 * Closes the given database connection.
	 * 
	 * @param con The Connection object to be closed.
	 */
	public static void closeConnection(Connection con) {
		
	}

	/**
	 * Closes the given ResultSet object.
	 * 
	 * @param rs The ResultSet object to be closed.
	 */
	public static void closeConnection(ResultSet rs) {
		try {
			if (rs != null && !rs.isClosed()) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Closes the given PreparedStatement object.
	 * 
	 * @param ps The PreparedStatement object to be closed.
	 */
	public static void closeConnection(PreparedStatement ps) {
		try {
			if (ps != null && !ps.isClosed()) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
