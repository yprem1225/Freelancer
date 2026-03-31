package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.JobService;
import com.model.Job;

/**
 * Servlet implementation class ClientJobsServlet
 */
@WebServlet("/ClientJobsServlet")
public class ClientJobsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientJobsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

        int userId = Integer.parseInt(session.getAttribute("id").toString());
        JobService jobService = new JobService();


        try {
            List<Job> activeJobs = jobService.getActiveJobsByUser(userId);
            List<Job> workingJobs = jobService.getWorkingJobsByUser(userId);
            List<Job> completedJobs = jobService.getCompletedJobsByUser(userId);

            request.setAttribute("activeJobs", activeJobs);
            request.setAttribute("workingJobs", workingJobs);
            request.setAttribute("completedJobs", completedJobs);

            request.getRequestDispatcher("clientJobs.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

}
