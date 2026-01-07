<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = request.getParameter("type");
    if (role == null) role = "";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Login as <%= role.equals("freelancer") ? "Freelancer" : "Client" %></h2>

<form action="LoginServlet" method="post">

    <!-- role comes from signup / index -->
    <input type="hidden" name="role" value="<%= role %>">

    <label>Email</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<!-- ERROR MESSAGE -->
<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>

<hr>

<p>
    Don’t have an account?
    <a href="signup.jsp?type=<%= role %>">Signup</a>
</p>

</body>
</html>
