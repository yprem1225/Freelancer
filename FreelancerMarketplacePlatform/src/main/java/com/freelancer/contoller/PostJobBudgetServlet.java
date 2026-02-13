package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.JobService;
import com.model.Job;

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
	        
	        if (session == null || session.getAttribute("jobId") == null) {
	            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
	            return;
	        }
	        if (session != null) {
	            Enumeration<String> names = session.getAttributeNames();
	            while (names.hasMoreElements()) {
	                String name = names.nextElement();
	                System.out.println(name + " : " + session.getAttribute(name));
	            }
	        }
	        request.setAttribute("jobId", jobId);
	        
	        JobService service = new JobService();
	        try {
				request.setAttribute("budget", service.getBudgetById(jobId));
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	        request.getRequestDispatcher("/post_job_budget.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		

        if (session == null || session.getAttribute("jobId") == null) {
            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
            return;
        }
        
        int jobId = (int) session.getAttribute("jobId");
        int budget = Integer.parseInt(request.getParameter("budget"));
        
        Job job = new Job();
        job.setBudget(request.getParameter("budget"));
        
        JobService service = new JobService();
        try {
			service.updateJobBudget(jobId, budget);
			session.setAttribute("budget", budget);

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        response.sendRedirect(request.getContextPath() + "/PostJobDescriptionServlet");
        
	}



}
