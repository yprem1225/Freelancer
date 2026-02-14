package com.freelancer.contoller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.ClientService;
import com.freelancer.services.JobService;
import com.model.ClientProfile;
import com.model.Job;

/**
 * Servlet implementation class ClientHomeServlet
 */
@WebServlet("/ClientHomeServlet")
public class ClientHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    HttpSession session = request.getSession(false);

	        if(session == null || session.getAttribute("id") == null){
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        int id = (int) session.getAttribute("id");
	        System.out.println("Logged in user id.........: " + id);


	        ClientService service = new ClientService();
	        JobService jobService = new JobService();

	        try {
	            ClientProfile profile = service.getProfile(id);
	            List<Job> activejobs = jobService.getActiveJobsByUser(id);
	            request.setAttribute("profile", profile);
	            request.setAttribute("activeJobs", activejobs);
	            request.getRequestDispatcher("home.jsp")
	                    .forward(request, response);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

	

}
