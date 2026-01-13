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



@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String selectedRole = request.getParameter("role");
        
        UserService service = new UserService();
        
        
        
        try {
			User user = service.login(email, password);
			
		
			
			
			if(user==null) {
				request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("login.jsp?type=" + selectedRole)
                       .forward(request, response);
                return;
			}
			
			if(!user.getRole().equals(selectedRole)) {
				  request.setAttribute("error",
	                        "You are registered as " + user.getRole());
	                request.getRequestDispatcher("login.jsp?type=" + selectedRole)
	                       .forward(request, response);
	                return;
			}
			
			
			 HttpSession session = request.getSession();
			 	session.setAttribute("id", user.getId());
	            session.setAttribute("name", user.getName());
	            session.setAttribute("email", user.getEmail());
	            session.setAttribute("role", user.getRole());
	            
	            System.out.println("DB ROLE = " + user.getId());
	            System.out.println("FORM ROLE = " + selectedRole);

	            System.out.println("Registration successful, redirecting to home.jsp");
	            
	            response.sendRedirect("ClientProfileServlet");


		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
