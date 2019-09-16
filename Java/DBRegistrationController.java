package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBRegistrationController {

	public static StringBuilder table = new StringBuilder();

	private final static String SELECT_QUERY = "SELECT * FROM users WHERE login = ?";

	private final static String INSERT_QUERY = "INSERT INTO users (login, password, name, region, gender, comment)"
			+ " VALUES (?, ?, ?, ?, ?, ?)";
	
	public DBRegistrationController() {
		super();
	}

	public Boolean getUniqueLogin(String login) {

		boolean isUnique = true;

		try {
			System.out.println("Connecting Database");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (Exception ex) {
		}
		System.out.println("SUCCESS");

		Connection conn = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/iteashop?" + "user=root&password=");
			System.out.println("OK");

		} catch (SQLException ex) {
			System.out.println("Failed");
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
		}

		Statement selectStmt = null;
		ResultSet rs = null;

		try {

			PreparedStatement prepSt = conn.prepareStatement(SELECT_QUERY);
			prepSt.setString(1, login);
			rs = prepSt.executeQuery();

			while (rs.next()) {
				if (login.equals(rs.getString("login"))) {
					isUnique = false;
				}
			}

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());

		} finally {
			// it is a good idea to release
			// resources in a finally{} block
			// in reverse-order of their creation
			// if they are no-longer needed

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqlEx) {
				} // ignore

				rs = null;
			}

			if (selectStmt != null) {
				try {
					selectStmt.close();
					conn.close();
				} catch (SQLException sqlEx) {
				} // ignore

				selectStmt = null;
			}
		}
		return isUnique;
	}

	public static void setUser(String login, String password, String name, String region, Boolean gender, String comment) {

		try {
			System.out.println("Connecting Database");
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (Exception ex) {
		}
		System.out.println("SUCCESS");

		Connection conn = null;

		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/iteashop?" + "user=root&password=");
			System.out.println("OK");

		} catch (SQLException ex) {
			System.out.println("Failed");
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());
		}

		Statement insertStmt = null;
		Statement selectStmt = null;
		ResultSet rs = null;

		try {
			PreparedStatement prepSt = conn.prepareStatement(INSERT_QUERY);
			prepSt.setString(1, login);
			prepSt.setString(2, password);
			prepSt.setString(3, name);
			prepSt.setString(4, region);
			prepSt.setBoolean(5, gender);
			prepSt.setString(6, comment);
			prepSt.executeUpdate();
			
//			insertStmt = conn.createStatement();
//			if (insertStmt.execute(INSERT_QUERY)) {
//				System.out.println("Inserted Succesfuly");
//			}
			

		} catch (SQLException ex) {
			// handle any errors
			System.out.println("SQLException: " + ex.getMessage());
			System.out.println("SQLState: " + ex.getSQLState());
			System.out.println("VendorError: " + ex.getErrorCode());

		} finally {
			// it is a good idea to release
			// resources in a finally{} block
			// in reverse-order of their creation
			// if they are no-longer needed

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqlEx) {
				} // ignore

				rs = null;
			}

			if (selectStmt != null) {
				try {
					selectStmt.close();
					conn.close();
				} catch (SQLException sqlEx) {
				} // ignore

				selectStmt = null;
			}

		}

	}

}
