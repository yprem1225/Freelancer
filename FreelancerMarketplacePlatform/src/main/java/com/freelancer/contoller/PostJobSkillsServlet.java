package com.freelancer.contoller;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;



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
	            response.sendRedirect(request.getContextPath() + "/views/home.jsp");
	            return;
	        }

	        request.getRequestDispatcher("/post_job_skills.jsp").forward(request, response);

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

	        System.out.println("Job ID: " + jobId);

	        if (skills != null) {
	            for (String skill : skills) {
	                System.out.println("Selected Skill: " + skill);
	            }
	        }

	        response.sendRedirect(request.getContextPath() + "/views/post_job_budget.jsp");
	    }
	}

