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

            String sql = "SELECT \r\n"
            		+ "n.notification_id,\r\n"
            		+ "n.message,\r\n"
            		+ "n.created_at,\r\n"
            		+ "ja.proposal,\r\n"
            		+ "u.name AS freelancer_name,\r\n"
            		+ "fp.title AS freelancer_title,\r\n"
            		+ "j.title AS job_title,\r\n"
            		+ "ja.freelancer_id,\r\n"
            		+ "j.job_id\r\n"
            		+ "\r\n"
            		+ "FROM notifications n\r\n"
            		+ "\r\n"
            		+ "JOIN job_applications ja ON n.reference_id = ja.job_id\r\n"
            		+ "JOIN users u ON ja.freelancer_id = u.id\r\n"
            		+ "LEFT JOIN freelancer_profile fp ON fp.user_id = u.id\r\n"
            		+ "JOIN jobs j ON j.job_id = ja.job_id\r\n"
            		+ "\r\n"
            		+ "WHERE n.user_id=?\r\n"
            		+ "\r\n"
            		+ "ORDER BY n.created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            

            ResultSet rs = ps.executeQuery();

            List<Notification> list = new ArrayList<>();

            while(rs.next()){

            	Notification n = new Notification();

            	n.setMessage(rs.getString("message"));
            	n.setCreatedAt(rs.getString("created_at"));

            	n.setFreelancerName(rs.getString("freelancer_name"));
            	n.setFreelancerTitle(rs.getString("freelancer_title"));
            	n.setJobTitle(rs.getString("job_title"));
            	n.setProposal(rs.getString("proposal"));

            	n.setFreelancerId(rs.getInt("freelancer_id"));
            	n.setJobId(rs.getInt("job_id"));

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
