package com.freelancer.contoller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.DBConnection;

/**
 * Servlet implementation class FreelancerSendMessageServlet
 */
@WebServlet("/FreelancerSendMessageServlet")
public class FreelancerSendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            HttpSession session = request.getSession();
            int senderId = Integer.parseInt(session.getAttribute("id").toString());
            int chatId   = Integer.parseInt(request.getParameter("chatId"));
            String message = request.getParameter("message");

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO messages(chat_id, sender_id, message) VALUES(?,?,?)");
            ps.setInt(1, chatId);
            ps.setInt(2, senderId);
            ps.setString(3, message);
            ps.executeUpdate();

            // Redirect back to FREELANCER servlet
            response.sendRedirect("FreelancerChatServlet?jobId=" + request.getParameter("jobId"));

        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
