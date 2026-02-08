package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.JobService;
import com.model.Job;


/**
 * Servlet implementation class PostJobDetailsServlet
 */
@WebServlet("/PostJobDetailsServlet")
public class PostJobDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Integer jobId = (Integer) session.getAttribute("jobId");

		if (jobId == null) {
            response.sendRedirect("PostJobSkillsServlet");
            return;
        }
		JobService service = new JobService();
		try {
			request.setAttribute("job", service.getJobById(jobId));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		request.getRequestDispatcher("/post_job_details.jsp").forward(request, response);
	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		Integer jobId = (Integer) session.getAttribute("jobId");
		
		Job job = new Job();
		job.setJobId(jobId);
        job.setComplexity(req.getParameter("complexity"));
        job.setDuration(req.getParameter("duration"));
        job.setFreelancerLevel(req.getParameter("freelancerLevel"));
       
        
        JobService jobService = new JobService();
        try {
			jobService.updateJobDetails(job);
			
			 resp.sendRedirect("PostJobBudgetServlet");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
