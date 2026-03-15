package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.Notification;
import com.util.DBConnection;

/**
 * Servlet implementation class FreelancerNotificationServlet
 */
@WebServlet("/FreelancerNotificationServlet")
public class FreelancerNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

            HttpSession session = request.getSession(false);
            System.out.println("----- SESSION DEBUG START -----");

            if(session == null){
                System.out.println("Session is NULL");
            }else{

                System.out.println("Session ID: " + session.getId());

                java.util.Enumeration<String> attributes = session.getAttributeNames();

                while(attributes.hasMoreElements()){
                    String name = attributes.nextElement();
                    Object value = session.getAttribute(name);

                    System.out.println("Session Attribute -> " + name + " : " + value);
                }
            }


            int freelancerId = Integer.parseInt(session.getAttribute("id").toString());

            Connection con = DBConnection.getConnection();

            String sql =
            		"SELECT n.notification_id, n.message, n.created_at, j.title, ja.proposal " +
            		"FROM notifications n " +
            		"JOIN job_applications ja ON n.reference_id = ja.application_id " +
            		"JOIN jobs j ON ja.job_id = j.job_id " +
            		"WHERE n.user_id=? AND n.user_type='freelancer' " +
            		"ORDER BY n.created_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, freelancerId);

            ResultSet rs = ps.executeQuery();

            List<Notification> notifications = new ArrayList<>();

            while(rs.next()){

            	Notification n = new Notification();

            	n.setNotificationId(rs.getInt("notification_id"));
            	n.setMessage(rs.getString("message"));
            	n.setCreatedAt(rs.getString("created_at"));

            	n.setJobTitle(rs.getString("title"));
            	n.setProposal(rs.getString("proposal"));

            	notifications.add(n);

            	}

            request.setAttribute("notifications", notifications);

            RequestDispatcher rd = request.getRequestDispatcher("freelancer_notifications.jsp");
            rd.forward(request, response);

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	

}
