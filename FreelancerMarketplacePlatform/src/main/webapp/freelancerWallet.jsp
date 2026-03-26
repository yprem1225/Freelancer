<%@ page import="com.model.Wallet" %>
<%@ page import="java.util.*" %>

<%
Wallet wallet = (Wallet) request.getAttribute("wallet");
List<Map<String, Object>> transactions =
    (List<Map<String, Object>>) request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html>
<head>
<title>My Wallet - Freelancer</title>
<style>
body {
    font-family: 'Segoe UI', Arial;
    background: #f4f6f9;
    padding: 40px;
}
.container {
    max-width: 900px;
    margin: auto;
}
.card {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    margin-bottom: 25px;
}
.balance {
    font-size: 24px;
    font-weight: bold;
    color: #2e7d32;
}
.wallet-header {
    display: flex;
    align-items: center;
    gap: 14px;
    margin-bottom: 10px;
}
.wallet-icon {
    font-size: 32px;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}
table th {
    background: #6a1b9a;
    color: white;
    padding: 12px;
    text-align: center;
}
table td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #eee;
}
table tr:hover {
    background: #f9f4ff;
}
.credit {
    color: #2e7d32;
    font-weight: bold;
}
.debit {
    color: #c62828;
    font-weight: bold;
}
.success {
    background: #e8f5e9;
    color: #2e7d32;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 13px;
}
.failed {
    background: #ffebee;
    color: #c62828;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 13px;
}
.badge-info {
    background: #e3f2fd;
    color: #1565c0;
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 600;
}
.back-link {
    text-decoration: none;
    color: #6a1b9a;
    font-weight: bold;
}
</style>
</head>
<body>

<div class="container">

  <div class="card">
    <div class="wallet-header">
      <span class="wallet-icon">💼</span>
      <div>
        <h2 style="margin:0">My Earnings Wallet</h2>
        <span class="badge-info">Freelancer Account</span>
      </div>
    </div>
    <p>User ID: <strong><%= wallet.getUserId() %></strong></p>
    <p class="balance">Available Balance: ₹ <%= wallet.getBalance() %></p>
    <p style="color:#888; font-size:13px;">
      Earnings are credited here when a client releases payment for a completed project.
    </p>
  </div>

  <div class="card">
    <h3>Transaction History</h3>

    <table>
      <tr>
        <th>Transaction ID</th>
        <th>Amount</th>
        <th>Type</th>
        <th>Description</th>
        <th>Status</th>
      </tr>

<%
if (transactions != null && !transactions.isEmpty()) {
    for (Map<String, Object> txn : transactions) {
        String type = txn.get("type").toString();
        String status = txn.get("status").toString();
        Object desc = txn.get("description");
%>
      <tr>
        <td><%= txn.get("transaction_id") %></td>
        <td class="<%= type.equals("CREDIT") ? "credit" : "debit" %>">
          ₹ <%= txn.get("amount") %>
        </td>
        <td class="<%= type.equals("CREDIT") ? "credit" : "debit" %>">
          <%= type %>
        </td>
        <td><%= desc != null ? desc : "-" %></td>
        <td>
          <span class="<%= status.equals("SUCCESS") ? "success" : "failed" %>">
            <%= status %>
          </span>
        </td>
      </tr>
<%
    }
} else {
%>
      <tr>
        <td colspan="5" style="color:#aaa; padding:20px;">No transactions yet</td>
      </tr>
<%
}
%>
    </table>
  </div>

  <a class="back-link" href="FreelancerHomeServlet">⬅ Back to Home</a>

</div>

</body>
</html>