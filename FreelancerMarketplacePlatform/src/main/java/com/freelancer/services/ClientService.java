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
	         profile.setCompanyname(rs.getString("company_name"));
	         profile.setCompanybio(rs.getString("company_bio"));
	         profile.setCompletedprofile(rs.getString("profile_completed"));
	            
	            return profile;  
		 }
		 return null;
	}
	
	public void updateProfile(ClientProfile profile) throws ClassNotFoundException, SQLException {
	
		Connection con = DBConnection.getConnection();
		
		//Dynamic Completion cal
		int completed=0;
		int totalfields=5;
		
		completed+=2; // name and email already filled after login/SignUp
		
		if(profile.getPhone()!=null && !profile.getPhone().isEmpty()) completed++;
		if(profile.getCompanyname()!=null && !profile.getCompanyname().isEmpty()) completed++;
		if(profile.getCompanybio()!=null && !profile.getCompanybio().isEmpty()) completed++;
		
		//Convert to percentage
		int completionpercentage=(completed*100)/totalfields;
		
		 String sql = """
		            INSERT INTO clients (user_id, phone, company_name, company_bio, profile_completed)
		            VALUES (?, ?, ?, ?, ?)
		            ON DUPLICATE KEY UPDATE
		                phone = VALUES(phone),
		                company_name = VALUES(company_name),
		                company_bio = VALUES(company_bio),
		                profile_completed = VALUES(profile_completed)
		        """;
		 
		 PreparedStatement preparedStatement = con.prepareStatement(sql);
		 preparedStatement.setInt(1,profile.getId());
		 preparedStatement.setString(2, profile.getPhone());
		 preparedStatement.setString(3, profile.getCompanyname());
		 preparedStatement.setString(4, profile.getCompanybio());
		 preparedStatement.setInt(5,completionpercentage);
		 
		 preparedStatement.executeUpdate();
		 con.close();
	}
	
	

}
