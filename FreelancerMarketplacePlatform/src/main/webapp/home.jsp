<%@ page contentType="text/html; charset=UTF-8" %>

<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer userIdObj = (Integer) session.getAttribute("id"); // FIXED
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    int userId = (userIdObj != null) ? userIdObj : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
</head>
<body>

<h2>Welcome Home</h2>

<p><b>User ID:</b> <%= userId %></p>
<p><b>Name:</b> <%= name %></p>
<p><b>Email:</b> <%= email %></p>
<p><b>Role:</b> <%= role %></p>

<form action="LogoutServlet" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>
