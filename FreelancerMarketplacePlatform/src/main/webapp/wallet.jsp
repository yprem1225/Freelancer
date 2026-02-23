<%@ page import="com.model.Wallet" %>

<%
    Wallet wallet = (Wallet) request.getAttribute("wallet");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Wallet</title>
</head>
<body style="font-family:Arial; padding:40px;">

<h2>My Wallet</h2>

<h3>User ID: <%= wallet.getUserId() %></h3>

<h3>Current Balance:  <%= wallet.getBalance() %></h3>

<hr>

<form action="WalletServlet" method="post">
    <label>Add Funds:</label>
    <input type="number" name="amount" required />
    <button type="submit">Add Money</button>
</form>

<br>
<a href="ClientHomeServlet">⬅ Back to Home</a>

</body>
</html>