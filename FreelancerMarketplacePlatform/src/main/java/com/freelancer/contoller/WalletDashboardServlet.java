package com.freelancer.contoller;

import java.io.IOException;
import java.math.BigDecimal;
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
 * Servlet implementation class WalletDashboardServlet
 */
@WebServlet("/WalletDashboardServlet")
public class WalletDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WalletDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession();
	        int userId = Integer.parseInt(session.getAttribute("id").toString());

	        WalletService ws = new WalletService();

	        try {
	            // Wallet info
	            Wallet wallet = ws.getWalletByUser(userId);

	            // Transactions
	            List<Map<String, Object>> transactions = ws.getTransactionsByUser(userId);

	            // 🔥 Analytics
	            BigDecimal totalCredit = BigDecimal.ZERO;
	            BigDecimal totalDebit = BigDecimal.ZERO;

	            int creditCount = 0;
	            int debitCount = 0;

	            for (Map<String, Object> tx : transactions) {
	                BigDecimal amt = (BigDecimal) tx.get("amount");
	                String type = (String) tx.get("type");

	                if ("CREDIT".equalsIgnoreCase(type)) {
	                    totalCredit = totalCredit.add(amt);
	                    creditCount++;
	                } else {
	                    totalDebit = totalDebit.add(amt);
	                    debitCount++;
	                }
	            }

	            // Send to JSP
	            request.setAttribute("wallet", wallet);
	            request.setAttribute("transactions", transactions);
	            request.setAttribute("totalCredit", totalCredit);
	            request.setAttribute("totalDebit", totalDebit);
	            request.setAttribute("creditCount", creditCount);
	            request.setAttribute("debitCount", debitCount);

	            request.getRequestDispatcher("walletDashboard.jsp").forward(request, response);

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

	

}
