package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.ClientService;
import com.model.ClientProfile;

/**
 * Servlet implementation class ClientProfileServlet
 */
@WebServlet("/ClientProfileServlet")
public class ClientProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession httpSession = request.getSession(false);
		
		if(httpSession==null || httpSession.getAttribute("id")==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		int id=(int) httpSession.getAttribute("id");
		
		ClientService service= new ClientService();
		
		try {
			ClientProfile profile = service.getProfile(id);
			request.setAttribute("profile", profile);
            request.getRequestDispatcher("home.jsp").forward(request, response);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
