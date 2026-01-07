package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	
	public static Connection getConnection() throws ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection con=null;
		
		try {
			
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/freelancer_db",
			        "root",
			        "prem@1208");
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return con;

	}

	
}
