package com.freelancer.contoller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.EscrowService;
import com.util.DBConnection;

@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int applicationId  = Integer.parseInt(request.getParameter("appId"));
            int jobId          = Integer.parseInt(request.getParameter("jobId"));
            int notificationId = Integer.parseInt(request.getParameter("notificationId"));
            String status      = request.getParameter("status");

            HttpSession session   = request.getSession();
            int clientUserId      = Integer.parseInt(session.getAttribute("id").toString());

            Connection con = DBConnection.getConnection();

            // ── 1. Get freelancer_id ──────────────────────────────────────────────
            String getFreelancer = "SELECT freelancer_id FROM job_applications WHERE application_id=?";
            PreparedStatement ps1 = con.prepareStatement(getFreelancer);
            ps1.setInt(1, applicationId);
            ResultSet rs = ps1.executeQuery();
            int freelancerId = 0;
            if (rs.next()) freelancerId = rs.getInt("freelancer_id");
            rs.close(); ps1.close();

            if (status.equals("accepted")) {

                // ── 2. Get job budget for escrow ──────────────────────────────────
                String getBudgetSql = "SELECT budget FROM jobs WHERE job_id = ?";
                PreparedStatement psBudget = con.prepareStatement(getBudgetSql);
                psBudget.setInt(1, jobId);
                ResultSet rsBudget = psBudget.executeQuery();
                BigDecimal budget = BigDecimal.ZERO;
                if (rsBudget.next()) budget = rsBudget.getBigDecimal("budget");
                rsBudget.close(); psBudget.close();

                // ── 3. Hold funds in escrow (debit client wallet) ─────────────────
                // Close the current connection first so EscrowService can open its own
                con.close();
                con = null;

                EscrowService escrowService = new EscrowService();
                try {
                    escrowService.holdFunds(jobId, clientUserId, freelancerId, budget);
                } catch (IllegalStateException e) {
                    // Client has insufficient balance — redirect with error
                    response.sendRedirect("NotificationServlet?error=" +
                            java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
                    return;
                }

                // Reopen connection for the remaining DB work
                con = DBConnection.getConnection();

                // ── 4. Update application status ──────────────────────────────────
                PreparedStatement ps2 = con.prepareStatement(
                        "UPDATE job_applications SET status='accepted' WHERE application_id=?");
                ps2.setInt(1, applicationId);
                ps2.executeUpdate(); ps2.close();

                // ── 5. Update job status + assign freelancer ──────────────────────
                PreparedStatement ps3 = con.prepareStatement(
                        "UPDATE jobs SET status='WORKING', assigned_freelancer_id=? WHERE job_id=?");
                ps3.setInt(1, freelancerId);
                ps3.setInt(2, jobId);
                ps3.executeUpdate(); ps3.close();

                // ── 6. Create chat room ───────────────────────────────────────────
                PreparedStatement psChat = con.prepareStatement(
                        "INSERT INTO chat_rooms(job_id, client_id, freelancer_id) VALUES(?,?,?)");
                psChat.setInt(1, jobId);
                psChat.setInt(2, clientUserId);
                psChat.setInt(3, freelancerId);
                psChat.executeUpdate(); psChat.close();

                // ── 7. Notify freelancer ──────────────────────────────────────────
                PreparedStatement ps4 = con.prepareStatement(
                        "INSERT INTO notifications(user_id, user_type, message, reference_id) " +
                        "VALUES(?, 'freelancer', ?, ?)");
                ps4.setInt(1, freelancerId);
                ps4.setString(2, "🎉 Your proposal was accepted! Payment is held in escrow.");
                ps4.setInt(3, applicationId);
                ps4.executeUpdate(); ps4.close();

            } else {

                // ── REJECTED path (unchanged) ────────────────────────────────────
                PreparedStatement ps5 = con.prepareStatement(
                        "UPDATE job_applications SET status='rejected' WHERE application_id=?");
                ps5.setInt(1, applicationId);
                ps5.executeUpdate(); ps5.close();

                PreparedStatement ps6 = con.prepareStatement(
                        "INSERT INTO notifications(user_id, user_type, message, reference_id) " +
                        "VALUES(?, 'freelancer', ?, ?)");
                ps6.setInt(1, freelancerId);
                ps6.setString(2, "❌ Your proposal was rejected by the client.");
                ps6.setInt(3, applicationId);
                ps6.executeUpdate(); ps6.close();
            }

            // ── Delete the client's notification ─────────────────────────────────
            if (con != null) {
                PreparedStatement ps7 = con.prepareStatement(
                        "DELETE FROM notifications WHERE notification_id=?");
                ps7.setInt(1, notificationId);
                ps7.executeUpdate(); ps7.close();
                con.close();
            }

            response.sendRedirect("NotificationServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("NotificationServlet?error=unexpected");
        }
    }
}