package com.freelancer.contoller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.WalletService;
import com.model.Wallet;

/**
 * Servlet implementation class FreelancerWalletServlet
 */
@WebServlet("/FreelancerWalletServlet")
public class FreelancerWalletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("id");

        WalletService walletService = new WalletService();

        try {
            // Auto-create wallet if not exists (safety net)
            walletService.createWalletIdNotExist(userId);

            Wallet wallet = walletService.getWalletByUser(userId);
            List<Map<String, Object>> transactions =
                    walletService.getTransactionsByUser(userId);

            request.setAttribute("wallet", wallet);
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("freelancerWallet.jsp")
                   .forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
	}

	
}
