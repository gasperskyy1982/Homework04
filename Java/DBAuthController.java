package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBAuthController {

	private final static String SELECT_QUERY = "Select * FROM users WHERE login = ? && password = ?";

	public DBAuthController() {
		super();
	}

	
	public static Boolean getAuth(String login, String password) {
		
		boolean isAuth = false;
		
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
			prepSt.setString(2, password);
			rs = prepSt.executeQuery();
			
			while (rs.next()) {
				if (login.equals(rs.getString("login")) && password.equals(rs.getString("password"))) {
					isAuth = true;
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

		return isAuth;

	}
}
