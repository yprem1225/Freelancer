package com.freelancer.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.ClientProfile;
import com.util.DBConnection;

public class ClientService {
	
	public ClientProfile getProfile(int id) throws ClassNotFoundException, SQLException {
		Connection con =DBConnection.getConnection();
		
		 String sql = """
		            SELECT u.id, u.name, u.email, u.role,
		                   c.phone, c.company_name, c.company_bio, c.profile_completed
		            FROM users u
		            LEFT JOIN clients c ON u.id = c.user_id
		            WHERE u.id = ?
		        """;
		 
		 PreparedStatement preparedStatement = con.prepareStatement(sql);
		 preparedStatement.setInt(1, id);
		 
		 ResultSet rs=preparedStatement.executeQuery();
		 
		 if(rs.next()) {
			 ClientProfile profile = new ClientProfile();
			 
			 profile.setId(rs.getInt("id"));
			 profile.setName(rs.getString("name"));
	            profile.setEmail(rs.getString("email"));
	            profile.setRole(rs.getString("role"));

	            profile.setPhone(rs.getString("phone"));
	            profile.setCompanyname("company_name");
	            profile.setCompanubio("company_bio");
	            profile.setCompletedprofile("profile_completed");
	            
	            return profile;
	            

		 }
		 return null;
		
		
	

	}

}
