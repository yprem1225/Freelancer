<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");

    // Session check (security)
    if (email == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f4f4f4;
        }
        .container {
            width: 60%;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }
        .card {
            padding: 20px;
            margin-top: 20px;
            background: #eaeaea;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome to Freelancer Marketplace</h1>

    <div class="card">
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Role:</strong> <%= role %></p>
    </div>

    <div class="card">
        <% if (role.equals("client")) { %>
            <h3>Client Features</h3>
            <ul>
                <li>Post a Job</li>
                <li>View Freelancers</li>
                <li>Manage Projects</li>
            </ul>
        <% } else if (role.equals("freelancer")) { %>
            <h3>Freelancer Features</h3>
            <ul>
                <li>Browse Jobs</li>
                <li>Apply for Jobs</li>
                <li>View Earnings</li>
            </ul>
        <% } %>
    </div>

    <br>
    <a href="logout">Logout</a>
</div>

</body>
</html>
