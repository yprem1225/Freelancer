package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.util.DBConnection;

@WebServlet("/ApplyJobServlet")
public class ApplyJobServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        try {

            System.out.println("ApplyJobServlet started");

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("id") == null) {
                response.getWriter().println("Session expired. Please login again.");
                return;
            }

            int freelancerId = Integer.parseInt(session.getAttribute("id").toString());

            String jobParam = request.getParameter("jobId");

            if(jobParam == null){
                response.getWriter().println("JobId not received");
                return;
            }

            int jobId = Integer.parseInt(jobParam);

            String proposal = request.getParameter("cover");

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO job_applications(job_id,freelancer_id,proposal,status) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, jobId);
            ps.setInt(2, freelancerId);
            ps.setString(3, proposal);
            ps.setString(4, "applied");

            ps.executeUpdate();

            ps.close();
            con.close();

            System.out.println("Application saved successfully");

            response.sendRedirect("FreelancerHomeServlet");

        } catch(Exception e) {

            e.printStackTrace();

            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}