<%
    String role = request.getParameter("type");
    if (role == null) role = "";
%>

<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
</head>
<body>

<h2>Signup as <%= role.equals("freelancer") ? "Freelancer" : "Client" %></h2>

<form action="SignupServlet" method="post">

    <!-- Role from index.jsp -->
    <input type="hidden" name="role" value="<%= role %>">

    <label>Name</label><br>
    <input type="text" name="name" required><br><br>

    <label>Email</label><br>
    <input type="email" name="email" required><br><br>

    <label>Password</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Create Account</button>
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
    Already have an account?
    <a href="login.jsp?type=<%= role %>">Login</a>
</p>

</body>
</html>
