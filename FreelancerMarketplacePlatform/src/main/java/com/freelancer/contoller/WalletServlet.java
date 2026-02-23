package com.freelancer.contoller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

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
			Wallet wallet = walletservice.getWalletByUser(userId);
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
