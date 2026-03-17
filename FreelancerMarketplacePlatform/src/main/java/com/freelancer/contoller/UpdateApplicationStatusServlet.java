package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBConnection;

/**
 * Servlet implementation class UpdateApplicationStatusServlet
 */
@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {

	            int applicationId = Integer.parseInt(request.getParameter("appId"));
	            int jobId = Integer.parseInt(request.getParameter("jobId"));
	            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
	            String status = request.getParameter("status");

	            Connection con = DBConnection.getConnection();

	            // 1️⃣ Get freelancer ID
	            String getFreelancer = "SELECT freelancer_id FROM job_applications WHERE application_id=?";
	            PreparedStatement ps1 = con.prepareStatement(getFreelancer);

	            ps1.setInt(1, applicationId);

	            ResultSet rs = ps1.executeQuery();

	            int freelancerId = 0;

	            if (rs.next()) {
	                freelancerId = rs.getInt("freelancer_id");
	            }

	            rs.close();
	            ps1.close();

	            if (status.equals("accepted")) {
	            	

	                HttpSession session = request.getSession();
	            	int clientId = Integer.parseInt(session.getAttribute("id").toString());

	                // update application status
	                String updateApp = "UPDATE job_applications SET status='accepted' WHERE application_id=?";
	                PreparedStatement ps2 = con.prepareStatement(updateApp);

	                ps2.setInt(1, applicationId);
	                ps2.executeUpdate();
	                ps2.close();

	             // update job status + assign freelancer
	                String updateJob = "UPDATE jobs SET status='WORKING', assigned_freelancer_id=? WHERE job_id=?";
	                PreparedStatement ps3 = con.prepareStatement(updateJob);

	                ps3.setInt(1, freelancerId);  // ✅ assign freelancer
	                ps3.setInt(2, jobId);

	                ps3.executeUpdate();
	                ps3.close();
	                
	             // create chat room
	                String chatSql =
	                "INSERT INTO chat_rooms(job_id,client_id,freelancer_id) VALUES(?,?,?)";

	                PreparedStatement psChat = con.prepareStatement(chatSql);

	                psChat.setInt(1, jobId);
	                psChat.setInt(2, clientId);
	                psChat.setInt(3, freelancerId);

	                psChat.executeUpdate();
	                psChat.close();
	                // send notification
	                String notify = "INSERT INTO notifications(user_id,user_type,message,reference_id) VALUES(?,?,?,?)";

	                PreparedStatement ps4 = con.prepareStatement(notify);

	                ps4.setInt(1, freelancerId);
	                ps4.setString(2, "freelancer");
	                ps4.setString(3, "🎉 Your proposal was accepted by the client.");
	                ps4.setInt(4, applicationId);

	                ps4.executeUpdate();
	                ps4.close();

	            } else {

	                // change status instead of deleting
	                String rejectApp = "UPDATE job_applications SET status='rejected' WHERE application_id=?";
	                PreparedStatement ps5 = con.prepareStatement(rejectApp);

	                ps5.setInt(1, applicationId);
	                ps5.executeUpdate();
	                ps5.close();

	                // rejection notification
	                String notify = "INSERT INTO notifications(user_id,user_type,message,reference_id) VALUES(?,?,?,?)";

	                PreparedStatement ps6 = con.prepareStatement(notify);

	                ps6.setInt(1, freelancerId);
	                ps6.setString(2, "freelancer");
	                ps6.setString(3, "❌ Your proposal was rejected by the client.");
	                ps6.setInt(4, applicationId);

	                ps6.executeUpdate();
	                ps6.close();
	            }

	            // delete client notification
	            String deleteNotification = "DELETE FROM notifications WHERE notification_id=?";
	            PreparedStatement ps7 = con.prepareStatement(deleteNotification);

	            ps7.setInt(1, notificationId);
	            ps7.executeUpdate();
	            ps7.close();

	            con.close();

	            response.sendRedirect("NotificationServlet");

	        }
	        catch (Exception e) {
	            e.printStackTrace();
        }
	}

}
