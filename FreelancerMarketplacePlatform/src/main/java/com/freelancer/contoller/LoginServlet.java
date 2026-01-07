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

import com.util.DBConnection;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        String selectedRole = request.getParameter("role");
        
        try {
			Connection con =DBConnection.getConnection();
			
			String sql = "SELECT * FROM users WHERE email=? AND password=?";
			
			PreparedStatement preparedStatement = con.prepareStatement(sql);
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, password);
			
			ResultSet rs=preparedStatement.executeQuery();
			
			if(rs.next()) {
				
				 String dbRole = rs.getString("role");
				 
	                // Role mismatch check
				 if (selectedRole != null && !dbRole.equals(selectedRole)) {
	                    request.setAttribute("error","You are registered as " + dbRole);
	                    request.getRequestDispatcher("login.jsp?type=" + selectedRole)
	                           .forward(request, response);
	                    return;
	                }
				 
				 //create session
				 HttpSession session = request.getSession();
	             session.setAttribute("name", rs.getString("name"));
	             session.setAttribute("email", email);
	             session.setAttribute("role", dbRole);
	             
	             response.sendRedirect("home.jsp");
			}
			else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp?type=" + selectedRole)
                       .forward(request, response);
            }
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	}

}
