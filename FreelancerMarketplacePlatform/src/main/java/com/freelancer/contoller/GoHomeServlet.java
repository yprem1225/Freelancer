package com.freelancer.contoller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/GoHomeServlet")
public class GoHomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	 
        HttpSession session = request.getSession(false);
        System.out.println("=== GoHomeServlet START ===");
        
        if (session != null && session.getAttribute("id") != null) {
            Integer jobId = (Integer) session.getAttribute("jobId");
            System.out.println("BEFORE clear - jobId: " + jobId);
            session.removeAttribute("jobId");
            System.out.println("AFTER clear - jobId removed");
        }
        
        System.out.println("=== GoHomeServlet END ===");
        
        // Go to home.jsp WITHOUT triggering login checks
        response.sendRedirect(request.getContextPath() + "/ClientProfileServlet");
    }
}
