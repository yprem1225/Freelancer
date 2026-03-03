package com.freelancer.contoller;

import java.io.IOException;
import java.math.BigDecimal;
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
 * Servlet implementation class WalletServlet
 */
@WebServlet("/WalletServlet")
public class WalletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userId = (int) session.getAttribute("id");
		
		WalletService walletservice = new WalletService();
		
		try {
			walletservice.createWalletIdNotExist(userId);
			Wallet wallet = walletservice.getWalletByUser(userId);
			
			// 🔥 Add this
			List<Map<String, Object>> transactions =
			        walletservice.getTransactionsByUser(userId);

			request.setAttribute("transactions", transactions);
			
			request.setAttribute("wallet", wallet);
            request.getRequestDispatcher("wallet.jsp")
                   .forward(request, response);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession();
	        int userId = (int) session.getAttribute("id");
	        
	        BigDecimal amount =
	                new BigDecimal(request.getParameter("amount"));
	        
	        WalletService walletService = new WalletService();
	        try {
	        	// Ensure wallet exists
	            walletService.createWalletIdNotExist(userId);
	            
	         // Get wallet to fetch wallet_id
	            Wallet wallet = walletService.getWalletByUser(userId);
	            int walletId = wallet.getWalletId();
	            
	         // Generate fake transaction ID
	            String transactionId = "TXN" + System.currentTimeMillis();
	            
	         // Save transaction
	            walletService.saveTransaction(
	                    transactionId,
	                    userId,
	                    walletId,
	                    amount,
	                    "CREDIT",
	                    "SUCCESS",
	                    "Dummy Wallet Top-up"
	            );

	            // Update wallet balance
				walletService.addFunds(userId, amount);
				
				
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        response.sendRedirect("WalletServlet");
	}

}
