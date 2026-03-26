package com.freelancer.contoller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.EscrowService;

@WebServlet("/ReleasePaymentServlet")
public class ReleasePaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"client".equalsIgnoreCase(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        int clientUserId = Integer.parseInt(session.getAttribute("id").toString());
        int jobId        = Integer.parseInt(request.getParameter("jobId"));

        EscrowService escrowService = new EscrowService();

        try {
            escrowService.releaseFunds(jobId, clientUserId);
            // Redirect back with success flag
            response.sendRedirect("ClientHomeServlet?paymentReleased=true");
        } catch (IllegalStateException e) {
            // Escrow not found or already released
            response.sendRedirect("ClientHomeServlet?error=" +
                    java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ClientHomeServlet?error=unexpected");
        }
    }
}