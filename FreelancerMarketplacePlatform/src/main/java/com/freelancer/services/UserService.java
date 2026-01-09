package com.freelancer.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.model.User;
import com.util.DBConnection;

public class UserService {
	public boolean isEmailExist(String Email) throws ClassNotFoundException, SQLException {
		
		//check if user exist
		Connection connection = DBConnection.getConnection();
        String sql = "SELECT id FROM users WHERE email=?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, Email);
        ResultSet rs=preparedStatement.executeQuery();
        return rs.next();  

	}
	
        //insert new user
		public void registerUser(User user) throws ClassNotFoundException, SQLException {
			Connection connection = DBConnection.getConnection();
			 String sql = "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";
			 PreparedStatement preparedStatement = connection.prepareStatement(sql);
			 preparedStatement.setString(1, user.getName());
			 preparedStatement.setString(2, user.getEmail());
			 preparedStatement.setString(3, user.getPassword());
			 preparedStatement.setString(4, user.getRole());
			 preparedStatement.executeUpdate();
		}
		
		
		//login
		public User login(String email, String password) throws ClassNotFoundException, SQLException {
			Connection connection = DBConnection.getConnection();
			String sql = "SELECT name, email, role FROM users WHERE email=? AND password=?";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, password);
			
			ResultSet rs = preparedStatement.executeQuery();
			
			if(rs.next()) {
				User user = new User();
				  user.setName(rs.getString("name"));
		          user.setEmail(rs.getString("email"));
		          user.setRole(rs.getString("role"));
		          return user;
			}
			
			
			return null;
		
		}
}