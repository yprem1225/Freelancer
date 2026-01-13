<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.ClientProfile" %>

<%
    ClientProfile profile = (ClientProfile) request.getAttribute("profile");

    if (profile == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int completed = 40; // base completion
    if (profile.getPhone() != null && !profile.getPhone().isEmpty()) completed += 20;
    if (profile.getCompanyname() != null && !profile.getCompanyname().isEmpty()) completed += 20;
    if (profile.getCompanubio() != null && !profile.getCompanubio().isEmpty()) completed += 20;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
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

        .dropdown input, .dropdown textarea, .dropdown select {
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

    <script>
        function toggleDropdown() {
            var d = document.getElementById("profileDropdown");
            d.style.display = d.style.display === "block" ? "none" : "block";
        }

        // Pre-select country code based on existing phone
        function initPhone() {
            var phoneInput = document.getElementById("phone");
            var countrySelect = document.getElementById("countryCode");

            if (phoneInput.value) {
                var match = phoneInput.value.match(/^\+(\d{1,3})/);
                if (match) {
                    countrySelect.value = "+" + match[1];
                    phoneInput.value = phoneInput.value.replace(/^\+\d{1,3}/, "");
                }
            }
        }

        function combinePhone() {
            var phoneInput = document.getElementById("phone");
            var countrySelect = document.getElementById("countryCode");
            phoneInput.value = countrySelect.value + phoneInput.value;
        }

        window.onload = function() {
            initPhone();
        };
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

    <form action="ClientProfileServlet" method="post" onsubmit="combinePhone()">
        <label>Country Code</label>
        <select id="countryCode" name="countryCode">
            <option value="+91">India (+91)</option>
            <option value="+1">USA (+1)</option>
            <option value="+44">UK (+44)</option>
            <option value="+61">Australia (+61)</option>
            <option value="+81">Japan (+81)</option>
            <option value="+49">Germany (+49)</option>
            <!-- Add more countries here -->
        </select>

        <label>Phone</label>
        <input id="phone" name="phone"
               pattern="\+\d{1,3}\d{6,12}"
               placeholder="Enter phone number" required
               value="<%= profile.getPhone() == null ? "" : profile.getPhone() %>">

        <label>Company Name</label>
        <input name="companyname" value="<%= profile.getCompanyname() == null ? "" : profile.getCompanyname() %>">

        <label>Company Bio</label>
        <textarea name="companubio"><%= profile.getCompanubio() == null ? "" : profile.getCompanubio() %></textarea>

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
