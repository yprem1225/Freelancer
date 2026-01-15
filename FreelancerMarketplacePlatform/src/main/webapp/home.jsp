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
    <title>Client Home</title>

    <!-- intl-tel-input -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/css/intlTelInput.css"/>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        /* HEADER */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* POST JOB BUTTON */
        .post-job-btn {
            background: #28a745;
            color: #fff;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
        }

        .post-job-btn.disabled {
            background: #9ccc9c;
            cursor: not-allowed;
        }

        /* PROFILE ICON */
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

        /* DROPDOWN */
        .dropdown {
            position: absolute;
            top: 75px;
            right: 30px;
            width: 360px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: none;
            padding: 16px;
            z-index: 1000;
        }

        .dropdown label {
            font-size: 14px;
            margin-top: 6px;
            display: block;
        }

        .dropdown input, .dropdown textarea {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
        }

        .readonly {
            background: #eee;
        }

        .dropdown button {
            margin-top: 10px;
            background: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            width: 100%;
            cursor: pointer;
        }

        .completion {
            margin-top: 10px;
            font-size: 14px;
            color: <%= profileComplete ? "green" : "red" %>;
        }

        .warning {
            background: #fff3cd;
            padding: 12px;
            margin: 20px;
            border-left: 5px solid #ffc107;
            font-size: 15px;
        }
    </style>

    <!-- intl-tel-input JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/intlTelInput.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js"></script>

    <script>
        function toggleDropdown() {
            const d = document.getElementById("profileDropdown");
            d.style.display = (d.style.display === "block") ? "none" : "block";
        }

        let iti;
        window.onload = function () {
            const phoneInput = document.querySelector("#phone");
            iti = window.intlTelInput(phoneInput, {
                separateDialCode: true,
                initialCountry: "auto",
                utilsScript:
                    "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.19/js/utils.js"
            });

            <% if (profile.getPhone() != null && !profile.getPhone().isEmpty()) { %>
                iti.setNumber("<%= profile.getPhone() %>");
            <% } %>
        };

        function preparePhone() {
            document.getElementById("phone").value = iti.getNumber();
        }

        function blockPostJob() {
            alert("Complete your profile (100%) before posting a job.");
        }
    </script>
</head>

<body>

<!-- HEADER -->
<div class="header">

    <!-- POST JOB -->
    <% if (profileComplete) { %>
        <a href="post_job_title.jsp" class="post-job-btn">+ Post Job</a>
    <% } else { %>
        <span class="post-job-btn disabled" onclick="blockPostJob()">+ Post Job</span>
    <% } %>

    <!-- PROFILE ICON -->
    <div class="profile-icon" onclick="toggleDropdown()">
        <%= profile.getName().substring(0,1).toUpperCase() %>
    </div>
</div>

<!-- WARNING -->
<% if (!profileComplete) { %>
    <div class="warning">
        Your profile is <b><%= completed %>%</b> complete.
        Please complete remaining details to post a job.
    </div>
<% } %>

<!-- PROFILE DROPDOWN -->
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
        <input id="phone" name="phone" type="tel">

        <label>Company Name</label>
        <input name="companyname"
               value="<%= profile.getCompanyname() == null ? "" : profile.getCompanyname() %>">

        <label>Company Bio</label>
        <textarea name="companybio" rows="3"><%= profile.getCompanybio() == null ? "" : profile.getCompanybio() %></textarea>

        <button type="submit">Save Profile</button>
    </form>

    <div class="completion">
        Profile Completed: <%= completed %>%
        <% if (!profileComplete) { %> – Please complete remaining details <% } %>
    </div>

    <a href="LogoutServlet" style="color:red;">Logout</a>
</div>

</body>
</html>
