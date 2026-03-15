package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("id") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int freelancerId = Integer.parseInt(session.getAttribute("id").toString());

            String jobParam = request.getParameter("jobId");

            if (jobParam == null) {
                return;
            }

            int jobId = Integer.parseInt(jobParam);

            String proposal = request.getParameter("cover");

            Connection con = DBConnection.getConnection();

            /*
             * 1️⃣ Insert Job Application
             * Now we capture the generated application_id
             */

            String sql = "INSERT INTO job_applications(job_id,freelancer_id,proposal,status) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setInt(1, jobId);
            ps.setInt(2, freelancerId);
            ps.setString(3, proposal);
            ps.setString(4, "applied");

            ps.executeUpdate();

            /*
             * Get the generated application_id
             */

            ResultSet generatedKeys = ps.getGeneratedKeys();

            int applicationId = 0;

            if (generatedKeys.next()) {
                applicationId = generatedKeys.getInt(1);
            }

            generatedKeys.close();
            ps.close();

            /*
             * 2️⃣ Get Client ID who posted the job
             */

            String getClientSql = "SELECT user_id FROM jobs WHERE job_id=?";

            PreparedStatement psClient = con.prepareStatement(getClientSql);

            psClient.setInt(1, jobId);

            ResultSet rs = psClient.executeQuery();

            int clientId = 0;

            if (rs.next()) {
                clientId = rs.getInt("user_id");
            }

            rs.close();
            psClient.close();

            /*
             * 3️⃣ Insert Notification for Client
             * reference_id now stores application_id
             */

            String notifySql = "INSERT INTO notifications(user_id,user_type,message,reference_id) VALUES(?,?,?,?)";

            PreparedStatement notifyPs = con.prepareStatement(notifySql);

            notifyPs.setInt(1, clientId);
            notifyPs.setString(2, "client");
            notifyPs.setString(3, "A freelancer has applied to your job");
            notifyPs.setInt(4, applicationId);

            notifyPs.executeUpdate();

            notifyPs.close();

            con.close();

            System.out.println("Application saved and notification sent");

            response.sendRedirect("FreelancerHomeServlet");

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}