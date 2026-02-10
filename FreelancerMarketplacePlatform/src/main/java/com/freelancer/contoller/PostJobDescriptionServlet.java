package com.freelancer.contoller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PostJobDescriptionServlet
 */
@WebServlet("/PostJobDescriptionServlet")
public class PostJobDescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("jobId") == null) {
            response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
            return;
        }

        int jobId = (int) session.getAttribute("jobId");
        request.setAttribute("jobId", jobId);

        request.getRequestDispatcher("post_job_description.jsp")
               .forward(request, response);
	}



}
