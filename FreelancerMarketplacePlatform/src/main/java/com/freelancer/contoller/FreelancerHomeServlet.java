package com.freelancer.contoller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.FreelancerService;
import com.freelancer.services.JobService;
import com.model.FreelancerProfile;
import com.model.Job;

/**
 * Servlet implementation class FreelancerHomeServlet
 */
@WebServlet("/FreelancerHomeServlet")
public class FreelancerHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		     HttpSession session = request.getSession(false);

	        if(session == null || session.getAttribute("id") == null){
	            response.sendRedirect("login.jsp");
	            return;
	        }
	        System.out.println("Inside FreelancerHomeServlet");
	        System.out.println("Role = " + session.getAttribute("role"));
	        System.out.println("ID = " + session.getAttribute("id"));
	        int id = (int) session.getAttribute("id");

	        FreelancerService service = new FreelancerService();
	        JobService jobService = new JobService();

	        try {

	            FreelancerProfile profile = service.getProfile(id);
	            
	         // 👇 get all active jobs
	            List<Job> activeJobs = jobService.getAllActiveJobs();
	            List<Job> workingJobs = jobService.getJobsByFreelancer(id);
	            // send profile to JSP
	            request.setAttribute("profile", profile);
	            request.setAttribute("activeJobs", activeJobs);
	            request.setAttribute("workingJobs", workingJobs);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        request.getRequestDispatcher("freelancer_home.jsp")
	               .forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
