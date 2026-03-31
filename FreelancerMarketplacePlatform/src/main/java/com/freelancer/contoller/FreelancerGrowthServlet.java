package com.freelancer.contoller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.freelancer.services.WalletService;

/**
 * Servlet implementation class FreelancerGrowthServlet
 */
@WebServlet("/FreelancerGrowthServlet")
public class FreelancerGrowthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FreelancerGrowthServlet() {
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
            List<Map<String, Object>> txs = ws.getTransactionsByUser(userId);

            BigDecimal totalCredit = BigDecimal.ZERO;
            BigDecimal totalDebit = BigDecimal.ZERO;

            Map<String, BigDecimal> monthlyData = new LinkedHashMap<>();

            for (Map<String, Object> tx : txs) {

                BigDecimal amt = (BigDecimal) tx.get("amount");
                String type = (String) tx.get("type");

                // TOTAL
                if ("CREDIT".equalsIgnoreCase(type)) {
                    totalCredit = totalCredit.add(amt);
                } else {
                    totalDebit = totalDebit.add(amt);
                }

                // MONTHLY (dummy grouping - you can improve using date)
                String month = "Month"; // replace with real month later

                monthlyData.putIfAbsent(month, BigDecimal.ZERO);
                monthlyData.put(month, monthlyData.get(month).add(amt));
            }

            request.setAttribute("transactions", txs);
            request.setAttribute("totalCredit", totalCredit);
            request.setAttribute("totalDebit", totalDebit);
            request.setAttribute("monthlyData", monthlyData);

            request.getRequestDispatcher("freelancerGrowth.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	

}
