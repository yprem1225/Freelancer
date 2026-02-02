package com.freelancer.contoller;


import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.freelancer.services.JobSkillService;



	@WebServlet("/PostJobSkillsServlet")
	public class PostJobSkillsServlet extends HttpServlet {

	    /**
		 * 
		 */
		private static final long serialVersionUID = 1L;

		protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("jobId") == null) {
	            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
	            return;
	        }

	        Integer jobId = (Integer) session.getAttribute("jobId");
	        request.setAttribute("jobId", jobId);
	        
	        // Load existing skills (for back/edit)
	        JobSkillService service = new JobSkillService();
	        request.setAttribute("skills", service.getSkillsByJobId(jobId));
	        

	        request.getRequestDispatcher("post_job_skills.jsp")
            .forward(request, response);
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("jobId") == null) {
	            response.sendRedirect(request.getContextPath() + "/views/home.jsp");
	            return;
	        }

	        Integer jobId = (Integer) session.getAttribute("jobId");
	        String[] skills = request.getParameterValues("skills");
	        
	        JobSkillService service = new JobSkillService();
	        
	     
	        try {
	        	// Clear old skills (important for edit)
				service.deleteSkillByJobId(jobId);
				
				 System.out.println("Job ID: " + jobId);

			        if (skills != null) {
			            for (String skill : skills) {
			                service.addSkill(jobId, skill);
			            }
			        }

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	       

	        
	        response.sendRedirect(request.getContextPath() + "/PostJobDetailsServlet");
	    }
	}

