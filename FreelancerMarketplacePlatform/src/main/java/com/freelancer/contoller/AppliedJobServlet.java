package com.freelancer.contoller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.freelancer.services.JobService;
import com.model.AppliedJob;

@WebServlet("/AppliedJobServlet")
public class AppliedJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("id") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int freelancerId = (Integer) session.getAttribute("id");

            JobService service = new JobService();

            List<AppliedJob> jobs = service.getAppliedJobs(freelancerId);

            request.setAttribute("appliedJobs", jobs);

            request.getRequestDispatcher("appliedjob.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}