package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.UserService;
import com.model.User;



@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User user = new User();
		user.setName(request.getParameter("name").trim());
		user.setEmail(request.getParameter("email").trim());
		user.setPassword(request.getParameter("password").trim());
		user.setRole(request.getParameter("role"));
		
		UserService service = new UserService();
		
		try {
			if(service.isEmailExist(user.getEmail())) {
				  request.setAttribute("error", "Account with this email already exists");
	                request.getRequestDispatcher("signup.jsp").forward(request, response);
	                return;
			}
			
			
			
			service.registerUser(user);
			
			HttpSession httpSession = request.getSession();
			httpSession.setAttribute("name", user.getName());
			httpSession.setAttribute("email", user.getEmail());
	        httpSession.setAttribute("role", user.getRole());
	        
	        response.sendRedirect("home.jsp");
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
