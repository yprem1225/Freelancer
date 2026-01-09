<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String role = request.getParameter("type");
    if (role == null || role.trim().isEmpty()) {
        role = "client";  // Default role - FIXES your empty role problem
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 400px; margin: 50px auto; padding: 20px; }
        input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0; box-sizing: border-box; }
        button { background: #007bff; color: white; padding: 12px; border: none; width: 100%; cursor: pointer; }
        button:hover { background: #0056b3; }
        .error { color: red; margin: 10px 0; }
        a { color: #007bff; text-decoration: none; }
    </style>
</head>
<body>

<h2>Login as <%= role.equals("freelancer") ? "Freelancer" : "Client" %></h2>

<form action="LoginServlet" method="post">
    <input type="hidden" name="role" value="<%= role %>">
    
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>
    
    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>
    
    <button type="submit">Login</button>
</form>

<% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<p>
    Don't have an account? 
    <a href="signup.jsp?type=<%= role %>">Signup</a>
</p>

</body>
</html>
