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
 * Servlet implementation class DeleteJobServlet
 */
@WebServlet("/DeleteJobServlet")
public class DeleteJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("id") == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        int jobId = Integer.parseInt(request.getParameter("jobId"));

	        JobService service = new JobService();

	        try {
	            service.deleteJobById(jobId);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        response.sendRedirect("ClientHomeServlet"); // reload home
	}



}
