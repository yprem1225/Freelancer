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
            request.getRequestDispatcher("profile.jsp").forward(request, response);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession httpSession = request.getSession(false);
		
		if(httpSession==null || httpSession.getAttribute("id")==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		int id =(int) httpSession.getAttribute("id");
		
		//get from input
		String phone=request.getParameter("phone");
		String companyName=request.getParameter("companyname");
		String companyBio=request.getParameter("companybio");
		
		//Set the values
		ClientProfile profile = new ClientProfile();
		profile.setId(id);
		profile.setPhone(phone);
		profile.setCompanyname(companyName);
		profile.setCompanybio(companyBio);
		
		ClientService service = new ClientService();
		try {
			service.updateProfile(profile);
			 response.sendRedirect("ClientProfileServlet"); // redirect to refresh data
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
