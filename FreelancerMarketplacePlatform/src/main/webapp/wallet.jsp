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
<title>My Wallet</title>

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

form input {
    padding: 10px;
    width: 180px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

button {
    padding: 10px 18px;
    background: #1976d2;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background: #125aa0;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

table th {
    background: #1976d2;
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
    background: #f1f1f1;
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

.back-link {
    text-decoration: none;
    color: #1976d2;
    font-weight: bold;
}
</style>

</head>

<body>

<div class="container">

<div class="card">
    <h2>My Wallet</h2>
    <p>User ID: <strong><%= wallet.getUserId() %></strong></p>
    <p class="balance">Current Balance: ₹ <%= wallet.getBalance() %></p>
</div>

<div class="card">
    <form action="WalletServlet" method="post">
        <label>Add Funds:</label>
        <input type="number" name="amount" required />
        <button type="submit">Add Money</button>
    </form>
</div>

<div class="card">
    <h3>Transaction History</h3>

    <table>
        <tr>
            <th>Transaction ID</th>
            <th>Amount</th>
            <th>Type</th>
            <th>Status</th>
        </tr>

<%
if (transactions != null && !transactions.isEmpty()) {
    for (Map<String, Object> txn : transactions) {

        String type = txn.get("type").toString();
        String status = txn.get("status").toString();
%>
        <tr>
            <td><%= txn.get("transaction_id") %></td>

            <td class="<%= type.equals("CREDIT") ? "credit" : "debit" %>">
                ₹ <%= txn.get("amount") %>
            </td>

            <td class="<%= type.equals("CREDIT") ? "credit" : "debit" %>">
                <%= type %>
            </td>

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
            <td colspan="4">No transactions found</td>
        </tr>
<%
}
%>

    </table>
</div>

<a class="back-link" href="ClientHomeServlet">⬅ Back to Home</a>

</div>

</body>
</html>