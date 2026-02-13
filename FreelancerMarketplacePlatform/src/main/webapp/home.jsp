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

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

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

        /* ✅ SUCCESS POPUP (TOP CENTER, 3 SEC, ANIMATED) */
        .success-popup {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%) translateY(-20px);
            background: #28a745;
            color: #fff;
            padding: 14px 30px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            z-index: 5000;
            opacity: 0;
            animation: slideFade 3s forwards;
        }

        @keyframes slideFade {
            0%   { opacity: 0; transform: translateX(-50%) translateY(-20px); }
            15%  { opacity: 1; transform: translateX(-50%) translateY(0); }
            85%  { opacity: 1; transform: translateX(-50%) translateY(0); }
            100% { opacity: 0; transform: translateX(-50%) translateY(-20px); }
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

            // Remove popup after 3 seconds
            const popup = document.getElementById("successPopup");
            if (popup) {
                setTimeout(function () {
                    popup.remove();
                    window.history.replaceState({}, document.title, window.location.pathname);
                }, 3000);
            }
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

<!-- ✅ SUCCESS POPUP -->
<% if ("1".equals(request.getParameter("success"))) { %>
    <div class="success-popup" id="successPopup">
        ✅ Job posted successfully!
    </div>
<% } %>

<div class="header">

    <% if (profileComplete) { %>
        <a href="post_job_title.jsp" class="post-job-btn">+ Post Job</a>
    <% } else { %>
        <span class="post-job-btn disabled" onclick="blockPostJob()">+ Post Job</span>
    <% } %>

    <div class="profile-icon" onclick="toggleDropdown()">
        <%= profile.getName().substring(0,1).toUpperCase() %>
    </div>
</div>

<% if (!profileComplete) { %>
    <div class="warning">
        Your profile is <b><%= completed %>%</b> complete.
        Please complete remaining details to post a job.
    </div>
<% } %>

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
