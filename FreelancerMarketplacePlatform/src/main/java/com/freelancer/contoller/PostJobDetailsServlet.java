package com.freelancer.contoller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PostJobDetailsServlet
 */
@WebServlet("/PostJobDetailsServlet")
public class PostJobDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("jobId") == null) {
            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
            return;
        }

        request.setAttribute("jobId", session.getAttribute("jobId"));

        request.getRequestDispatcher("post_job_details.jsp")
               .forward(request, response);
	}



}
