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
 * Servlet implementation class ViewFreelancerProfileServlet
 */
@WebServlet("/ViewFreelancerProfileServlet")
public class ViewFreelancerProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("id") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String idParam = request.getParameter("id");
            if (idParam == null) {
                response.sendRedirect("ClientHomeServlet");
                return;
            }

            int freelancerId = Integer.parseInt(idParam);
            Connection con = DBConnection.getConnection();

            // Fetch user + profile joined
            String sql =
                "SELECT u.id, u.name, u.email, " +
                "fp.phone, fp.title, fp.skills, fp.experience_years, " +
                "fp.hourly_rate, fp.bio, fp.linkedin_url, fp.github_url " +
                "FROM users u " +
                "LEFT JOIN freelancer_profile fp ON fp.user_id = u.id " +
                "WHERE u.id = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, freelancerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("fId",         rs.getInt("id"));
                request.setAttribute("fName",       rs.getString("name"));
                request.setAttribute("fEmail",      rs.getString("email"));
                request.setAttribute("fPhone",      rs.getString("phone"));
                request.setAttribute("fTitle",      rs.getString("title"));
                request.setAttribute("fSkills",     rs.getString("skills"));
                request.setAttribute("fExpYears",   rs.getInt("experience_years"));
                request.setAttribute("fRate",       rs.getDouble("hourly_rate"));
                request.setAttribute("fBio",        rs.getString("bio"));
                request.setAttribute("fLinkedin",   rs.getString("linkedin_url"));
                request.setAttribute("fGithub",     rs.getString("github_url"));
            }

            rs.close(); ps.close(); con.close();

            request.getRequestDispatcher("viewFreelancerProfile.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	
}
