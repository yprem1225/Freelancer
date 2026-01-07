package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.User;
import com.util.DBConnection;


@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User user = new User();
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		user.setPassword(request.getParameter("password"));
		user.setRole(request.getParameter("role"));
		
		try {
			Connection con=DBConnection.getConnection();
			
			//check if already registered
			 String checkQuery = "SELECT id FROM users WHERE email=?";
			 PreparedStatement checkps=con.prepareStatement(checkQuery);
			 
			 checkps.setString(1, user.getEmail());
			 ResultSet rs=checkps.executeQuery();
			 
			 if(rs.next()) {
				  // Email already exists
				 request.setAttribute("error","Account with this email already exists");

				 request.getRequestDispatcher("signup.jsp")
				           .forward(request, response);
				 return;
			 }
			 
			 
			 //New Users
			 String insertQuery ="INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";
			 PreparedStatement preparedStatement=con.prepareStatement(insertQuery);
			 preparedStatement.setString(1, user.getName());
			 preparedStatement.setString(2, user.getEmail());
			 preparedStatement.setString(3, user.getPassword());
			 preparedStatement.setString(4, user.getRole());
			 
			 preparedStatement.executeUpdate();
			 
			 HttpSession httpSession=request.getSession();
			 httpSession.setAttribute("name", user.getName());
			 httpSession.setAttribute("email", user.getEmail());
			 httpSession.setAttribute("password", user.getPassword());
			 httpSession.setAttribute("role", user.getRole());
			 
			 response.sendRedirect("home.jsp");
			 
			 
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
	}

}
