package services.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import config.DBConnection;
import models.Demand;
import services.DemandInterface;


//This class is to process the demand items which are
//not available at the time of purchase by any customer
//the customer will receive mail once the product is avaible
//back into the store
public class DemandService implements DemandInterface {

	/**
	 * Adds a product demand entry for a user in the database.
	 *
	 * @param userId     The ID of the user making the demand.
	 * @param prodId     The ID of the product demanded.
	 * @param demandQty  The quantity demanded by the user.
	 * @return True if the product demand entry is successfully added; false otherwise.
	 */
	@Override
	public boolean addProduct(String userId, String prodId, int demandQty) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		//get the database connection
		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {
			//create the prepared statement with the query
			ps = con.prepareStatement("select * from user_demand where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, prodId);

			rs = ps.executeQuery();

			if (rs.next()) {

				flag = true;
			} else {
				ps2 = con.prepareStatement("insert into  user_demand values(?,?,?)");

				ps2.setString(1, userId);

				ps2.setString(2, prodId);

				ps2.setInt(3, demandQty);

				int k = ps2.executeUpdate();

				if (k > 0)
					flag = true;
			}

		} catch (SQLException e) {
			flag = false;
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(ps2);
		DBConnection.closeConnection(rs);
		//return true if the product is added into the db
		return flag;
	}

	/**
	 * Adds a product demand entry for a user in the database using a Demand object.
	 *
	 * @param userDemandBean The Demand object containing user ID, product ID, and demand quantity.
	 * @return True if the product demand entry is successfully added; false otherwise.
	 */
	@Override
	public boolean addProduct(Demand userDemandBean) {
		// TODO Auto-generated method stub
		
		return addProduct(userDemandBean.getUserName(), userDemandBean.getProdId(), userDemandBean.getDemandQty());
		
		
	}

	/**
	 * Removes a product demand entry for a user from the database.
	 *
	 * @param userId The ID of the user whose product demand is to be removed.
	 * @param prodId The ID of the product for which the demand entry is to be removed.
	 * @return True if the product demand entry is successfully removed or not present; false otherwise.
	 */
	@Override
	public boolean removeProduct(String userId, String prodId) {
		// TODO Auto-generated method stub
		
		boolean flag = false;

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user_demand where username=? and prodid=?");

			ps.setString(1, userId);
			ps.setString(2, prodId);

			rs = ps.executeQuery();

			// System.out.println("userId "+userId+"\nprodId: "+prodId);

			if (rs.next()) {

				// System.out.println("userId "+userId+"\nprodId: "+prodId);
				ps2 = con.prepareStatement("delete from  user_demand where username=? and prodid=?");

				ps2.setString(1, userId);

				ps2.setString(2, prodId);

				int k = ps2.executeUpdate();

				if (k > 0)
					flag = true;

			} else {
				flag = true;
			}

		} catch (SQLException e) {
			flag = false;
			e.printStackTrace();
		}

		DBConnection.closeConnection(con);
		DBConnection.closeConnection(ps);
		DBConnection.closeConnection(ps2);
		DBConnection.closeConnection(rs);

		return flag;
	}

	/**
	 * Retrieves a list of demands for a specific product from the database.
	 *
	 * @param prodId The ID of the product for which demands are to be retrieved.
	 * @return A list of Demand objects representing the demands for the specified product.
	 */
	@Override
	public List<Demand> haveDemanded(String prodId) {
		// TODO Auto-generated method stub
		
		List<Demand> demandList = new ArrayList<Demand>();

		Connection con = DBConnection.provideConnection();

		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			ps = con.prepareStatement("select * from user_demand where prodid=?");
			ps.setString(1, prodId);
			rs = ps.executeQuery();

			while (rs.next()) {

				Demand demand = new Demand(rs.getString("username"), rs.getString("prodid"),
						rs.getInt("quantity"));

				demandList.add(demand);

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return demandList;
	}

	
}
