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


/**
 * Servlet implementation class PostJobDescriptionServlet
 */
@WebServlet("/PostJobDescriptionServlet")
public class PostJobDescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("jobId") == null) {
            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
            return;
        }

        int jobId = (int) session.getAttribute("jobId");
        
        JobService service = new JobService();

        try {
            request.setAttribute("description", service.getDescriptionById(jobId));
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("jobId", jobId);
        
        boolean profileCompleted;
		try {
			profileCompleted = service.isProfileCompleted(
			        (int) session.getAttribute("id"));
			
			request.setAttribute("profileCompleted", profileCompleted);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.getRequestDispatcher("post_job_description.jsp")
               .forward(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession(false);

	        if (session == null || session.getAttribute("jobId") == null) {
	            response.sendRedirect("ClientProfileServlet");
	            return;
	        }
	        
	        int jobId = (int) session.getAttribute("jobId");
	        String description = request.getParameter("description");
	        
	        JobService service = new JobService();
	        
	        try {
				service.updateDescriptionAndActivate(jobId, description);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        // REMOVE session values
	        session.removeAttribute("jobId");
	        session.removeAttribute("budget");

	        // Redirect with success flag
	        response.sendRedirect(request.getContextPath() + "/ClientProfileServlet?success=1");
	
	}
}
