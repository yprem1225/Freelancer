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

import com.util.DBConnection;

/**
 * Servlet implementation class UpdateApplicationStatusServlet
 */
@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

            int appId = Integer.parseInt(request.getParameter("appId"));
            String status = request.getParameter("status");

            Connection con = DBConnection.getConnection();

            /*
             * 1️⃣ Update Application Status
             */

            String updateSql = "UPDATE job_applications SET status=? WHERE application_id=?";

            PreparedStatement ps = con.prepareStatement(updateSql);

            ps.setString(1, status);
            ps.setInt(2, appId);

            ps.executeUpdate();

            ps.close();

            /*
             * 2️⃣ Get Freelancer ID
             */

            String getFreelancer = "SELECT freelancer_id FROM job_applications WHERE application_id=?";

            PreparedStatement ps2 = con.prepareStatement(getFreelancer);

            ps2.setInt(1, appId);

            ResultSet rs = ps2.executeQuery();

            int freelancerId = 0;

            if (rs.next()) {
                freelancerId = rs.getInt("freelancer_id");
            }

            rs.close();
            ps2.close();

            /*
             * 3️⃣ Insert Notification for Freelancer
             */

            String message;

            if (status.equals("accepted")) {
                message = "Your proposal has been accepted!";
            } else {
                message = "Your proposal has been rejected.";
            }

            String notifySql = "INSERT INTO notifications(user_id,user_type,message,reference_id) VALUES(?,?,?,?)";

            PreparedStatement ps3 = con.prepareStatement(notifySql);

            ps3.setInt(1, freelancerId);
            ps3.setString(2, "freelancer");
            ps3.setString(3, message);
            ps3.setInt(4, appId);

            ps3.executeUpdate();

            ps3.close();
            con.close();

            response.sendRedirect("ClientJobApplicationsServlet");

        } catch (Exception e) {

            e.printStackTrace();
        }
	}

}
