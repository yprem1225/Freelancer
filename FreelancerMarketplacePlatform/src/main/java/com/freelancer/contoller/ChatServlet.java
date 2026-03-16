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

import com.model.ChatMessage;
import com.util.DBConnection;

/**
 * Servlet implementation class ChatServlet
 */
@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	@SuppressWarnings("unused")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{

			HttpSession session = request.getSession(false);

			String jobParam = request.getParameter("jobId");

			if(jobParam == null){
			    response.sendRedirect("FreelancerHomeServlet");
			    return;
			}

			int jobId = Integer.parseInt(jobParam);

			Connection con = DBConnection.getConnection();

			// get chat id
			String chatSql =
			"SELECT chat_id FROM chat_rooms WHERE job_id=?";

			PreparedStatement ps = con.prepareStatement(chatSql);
			ps.setInt(1, jobId);

			ResultSet rs = ps.executeQuery();

			int chatId = 0;

			if(rs.next()){
			chatId = rs.getInt("chat_id");
			}
			if(chatId == 0){

			    String createChat =
			    "INSERT INTO chat_rooms(job_id) VALUES(?)";

			    PreparedStatement ps3 = con.prepareStatement(createChat,PreparedStatement.RETURN_GENERATED_KEYS);

			    ps3.setInt(1, jobId);
			    ps3.executeUpdate();

			    ResultSet gen = ps3.getGeneratedKeys();

			    if(gen.next()){
			        chatId = gen.getInt(1);
			    }
			}

			// load messages
			String msgSql =
			"SELECT * FROM messages WHERE chat_id=? ORDER BY sent_at";

			PreparedStatement ps2 = con.prepareStatement(msgSql);
			ps2.setInt(1, chatId);

			ResultSet rs2 = ps2.executeQuery();

			List<ChatMessage> list = new ArrayList<>();

			while(rs2.next()){

			ChatMessage m = new ChatMessage();

			m.setSenderId(rs2.getInt("sender_id"));
			m.setMessage(rs2.getString("message"));
			m.setTime(rs2.getString("sent_at"));

			list.add(m);
			}

			request.setAttribute("messages", list);
			request.setAttribute("chatId", chatId);
			request.setAttribute("jobId", jobId);

			request.getRequestDispatcher("chat.jsp").forward(request,response);

			}catch(Exception e){
			e.printStackTrace();
			}
	}

	

}
