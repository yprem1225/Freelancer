package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.Notification;
import com.util.DBConnection;

/**
 * Servlet implementation class NotificationServlet
 */
@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try{

	            HttpSession session = request.getSession(false);
	            int userId = Integer.parseInt(session.getAttribute("id").toString());

	            Connection con = DBConnection.getConnection();

	            String sql =
	            		"SELECT " +
	            		"n.notification_id, " +
	            		"n.reference_id, " +
	            		"n.message, " +
	            		"n.created_at, " +
	            		"ja.application_id,"+
	            		"ja.proposal, " +
	            		"ja.freelancer_id, " +
	            		"u.name AS freelancer_name, " +
	            		"fp.title AS freelancer_title, " +
	            		"j.title AS job_title, " +
	            		"j.job_id " +

	            		"FROM notifications n " +

	            		"JOIN job_applications ja ON n.reference_id = ja.job_id " +   // FIXED
	            		"JOIN users u ON ja.freelancer_id = u.id " +
	            		"LEFT JOIN freelancer_profile fp ON fp.user_id = u.id " +
	            		"JOIN jobs j ON j.job_id = ja.job_id " +

	            		"WHERE n.user_id=? " +
	            		"ORDER BY n.created_at DESC";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setInt(1, userId);

	            ResultSet rs = ps.executeQuery();

	            List<Notification> list = new ArrayList<>();

	            while(rs.next()){

	                Notification n = new Notification();

	                n.setNotificationId(rs.getInt("notification_id"));
	                n.setReferenceId(rs.getInt("reference_id"));

	                n.setMessage(rs.getString("message"));
	                n.setCreatedAt(rs.getString("created_at"));

	                n.setFreelancerName(rs.getString("freelancer_name"));
	                n.setFreelancerTitle(rs.getString("freelancer_title"));
	                n.setJobTitle(rs.getString("job_title"));
	                n.setProposal(rs.getString("proposal"));

	                n.setFreelancerId(rs.getInt("freelancer_id"));
	                n.setJobId(rs.getInt("job_id"));
	                n.setApplicationId(rs.getInt("application_id"));

	                list.add(n);
	            }

	            request.setAttribute("notifications", list);

	            request.getRequestDispatcher("notifications.jsp").forward(request,response);

	            con.close();

	        }catch(Exception e){
	            e.printStackTrace();
	            response.getWriter().println(e);
	        }
	}
	
	


}
