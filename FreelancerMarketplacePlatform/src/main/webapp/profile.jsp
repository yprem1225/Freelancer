<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.ClientProfile" %>

<%
    ClientProfile profile = (ClientProfile) request.getAttribute("profile");

    if (profile == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int completed = 40;
    if (profile.getPhone() != null && !profile.getPhone().trim().isEmpty()) completed += 20;
    if (profile.getCompanyname() != null && !profile.getCompanyname().trim().isEmpty()) completed += 20;
    if (profile.getCompanybio() != null && !profile.getCompanybio().trim().isEmpty()) completed += 20;

    boolean profileComplete = completed == 100;
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>

    <style>
        body {
            font-family: Arial;
            background: #f4f6f8;
            padding: 30px;
        }

        .container {
            width: 500px;
            margin: auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 12px;
        }

        button {
            background: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
        }

        .completion {
            margin-top: 10px;
            font-weight: bold;
            color: <%= profileComplete ? "green" : "red" %>;
        }

        .back {
            margin-top: 15px;
            display: block;
            text-align: center;
        }

        .logout {
            margin-top: 10px;
            color: red;
            text-align: center;
            display: block;
        }
    </style>
</head>

<body>

<div class="container">

    <h2>My Profile</h2>

    <p><b>Name:</b> <%= profile.getName() %></p>
    <p><b>Email:</b> <%= profile.getEmail() %></p>
    <p><b>Role:</b> <%= profile.getRole() %></p>

    <form action="ClientProfileServlet" method="post">

        <label>Phone</label>
        <input name="phone"
               value="<%= profile.getPhone()==null?"":profile.getPhone() %>">

        <label>Company Name</label>
        <input name="companyname"
               value="<%= profile.getCompanyname()==null?"":profile.getCompanyname() %>">

        <label>Company Bio</label>
        <textarea name="companybio"><%= profile.getCompanybio()==null?"":profile.getCompanybio() %></textarea>

        <button type="submit">Save Profile</button>
    </form>

    <div class="completion">
        Profile Completed: <%= completed %>%
        <% if (!profileComplete) { %>
            – Please complete remaining details
        <% } %>
    </div>

    <a href="ClientHomeServlet" class="back">⬅ Back to Home</a>
    <a href="LogoutServlet" class="logout">Logout</a>

</div>

</body>
</html>
