package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.freelancer.services.JobService;
import com.model.Job;

@SuppressWarnings("serial")
@WebServlet("/PostJobTitleServlet")
public class PostJobTitleServlet extends HttpServlet {
	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

		 HttpSession session = request.getSession(false);
		    System.out.println("=== PostJobTitleServlet.doGet START ===");
		    
		    if (session == null || session.getAttribute("id") == null) {
		        System.out.println("No session or user ID - redirect to login");
		        response.sendRedirect("login.jsp");
		        return;
		    }

		    Integer jobId = (Integer) session.getAttribute("jobId");
		    System.out.println("jobId in doGet: " + jobId);

		    if (jobId != null) {
		        JobService service = new JobService();
		        try {
		            String title = service.getJobTitle(jobId);
		            request.setAttribute("title", title);
		            System.out.println("Loaded existing title: " + title);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    } else {
		        System.out.println("No jobId - ready for NEW job");
		    }

		    System.out.println("=== PostJobTitleServlet.doGet END ===");

	        RequestDispatcher rd =
	            request.getRequestDispatcher("post_job_title.jsp");
	        rd.forward(request, response);
	    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        int userId =(int) session.getAttribute("id");
        String title = request.getParameter("title");
        
        System.out.println("title"+title);
        
        JobService service = new JobService();
        
        	
        	try {
        		Integer jobId= (Integer) session.getAttribute("jobId");
        		System.out.println("=== doPost START - jobId: " + jobId);
                
                if(jobId == null) {
                	//FIRST TIME CREATE
                	Job job = new Job();
                	job.setUserId(userId);
                	job.setTitle(title);
                	
                	jobId=service.createJob(job);
                	
                	session.setAttribute("jobId", jobId);
                	System.out.println("data inserted successfully");
                }else {
					//BACK & EXIT -> UPDATE
                	System.out.println("updated sucessfully");
                	service.updateJobTitle(jobId, title);
				}
                
                response.sendRedirect(request.getContextPath() + "/PostJobSkillsServlet");


				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        
    }
}