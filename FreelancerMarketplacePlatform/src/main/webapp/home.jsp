<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.ClientProfile" %>

<%
    ClientProfile profile = (ClientProfile) request.getAttribute("profile");

    if (profile == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int completed = 40;
    if (profile.getPhone() != null && !profile.getPhone().isEmpty()) completed += 20;
    if (profile.getCompanyname() != null && !profile.getCompanyname().isEmpty()) completed += 20;
    if (profile.getCompanybio() != null && !profile.getCompanybio().isEmpty()) completed += 20;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>

    <!-- intl-tel-input CSS -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/css/intlTelInput.css"/>

    <style>
        body { font-family: Arial; margin: 0; background: #f5f5f5; }

        .header {
            display: flex;
            justify-content: flex-end;
            padding: 15px 30px;
            background: #fff;
        }

        .profile-icon {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #007bff;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
        }

        .dropdown {
            position: absolute;
            top: 70px;
            right: 30px;
            width: 350px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: none;
            padding: 15px;
        }

        .dropdown input, .dropdown textarea {
            width: 100%;
            padding: 8px;
            margin: 6px 0;
        }

        .readonly {
            background: #eee;
        }

        button {
            background: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
        }
    </style>

    <!-- intl-tel-input JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/intlTelInput.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js"></script>

    <script>
        function toggleDropdown() {
            var d = document.getElementById("profileDropdown");
            d.style.display = d.style.display === "block" ? "none" : "block";
        }

        let iti;

        window.onload = function () {
            const phoneInput = document.querySelector("#phone");

            iti = window.intlTelInput(phoneInput, {
                initialCountry: "auto",
                separateDialCode: true,
                utilsScript:
                  "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js"
            });

            // Pre-fill phone if exists
            <% if (profile.getPhone() != null && !profile.getPhone().isEmpty()) { %>
                iti.setNumber("<%= profile.getPhone() %>");
            <% } %>
        };

        function preparePhone() {
            document.getElementById("phone").value = iti.getNumber();
        }
    </script>

</head>
<body>

<!-- HEADER -->
<div class="header">
    <div class="profile-icon" onclick="toggleDropdown()">
        <%= profile.getName().substring(0,1).toUpperCase() %>
    </div>
</div>

<!-- DROPDOWN -->
<div class="dropdown" id="profileDropdown">

    <h3>Profile</h3>

    <p><b>User ID:</b> <%= profile.getId() %></p>

    <label>Name</label>
    <input class="readonly" readonly value="<%= profile.getName() %>">

    <label>Email</label>
    <input class="readonly" readonly value="<%= profile.getEmail() %>">

    <label>Role</label>
    <input class="readonly" readonly value="<%= profile.getRole() %>">

    <form action="ClientProfileServlet" method="post" onsubmit="preparePhone()">

        <label>Phone</label>
        <input id="phone" name="phone" type="tel" required>

        <label>Company Name</label>
        <input name="companyname"
               value="<%= profile.getCompanyname() == null ? "" : profile.getCompanyname() %>">

        <label>Company Bio</label>
        <textarea name="companybio"><%= profile.getCompanybio() == null ? "" : profile.getCompanybio() %></textarea>

        <button type="submit">Save Profile</button>
    </form>

    <p style="margin-top:10px; color:red;">
        Profile Completed: <%= completed %>%
        <% if (completed < 100) { %> – Please complete remaining details <% } %>
    </p>

    <a href="LogoutServlet">Logout</a>
</div>

</body>
</html>
