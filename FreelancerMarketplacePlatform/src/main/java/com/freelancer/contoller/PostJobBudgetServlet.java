package com.freelancer.contoller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.JobService;

/**
 * Servlet implementation class PostJobBudgetServlet
 */
@WebServlet("/PostJobBudgetServlet")
public class PostJobBudgetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	   @SuppressWarnings("unused")
	private JobService jobService = new JobService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   HttpSession session = request.getSession();
	        Integer jobId = (Integer) session.getAttribute("jobId");
	        request.setAttribute("jobId", jobId);

	        request.getRequestDispatcher("/post_job_budget.jsp").forward(request, response);
	}



}
