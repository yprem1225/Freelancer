<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.ClientProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Job" %>
<%@ page import="com.model.JobSkill" %>

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

        .nav-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .post-job-btn {
            background: #28a745;
            color: #fff;
            padding: 10px 18px;
            border-radius: 6px;
            font-size: 16px;
            text-decoration: none;
            font-weight: bold;
        }

        .post-job-btn.disabled {
            background: #9ccc9c;
            cursor: not-allowed;
        }

        .wallet-btn {
            background: #ffc107;
            color: #000;
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 15px;
            text-decoration: none;
            font-weight: bold;
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
            text-decoration: none;
        }

        .warning {
            background: #fff3cd;
            padding: 12px;
            margin: 20px;
            border-left: 5px solid #ffc107;
            font-size: 15px;
        }

        .jobs-container {
            padding: 30px;
        }

        .job-card {
            background: #fff;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .job-card h3 {
            margin: 0 0 10px 0;
        }

        .job-card a {
            text-decoration: none;
            color: #007bff;
        }

        .skill-tag {
            background: #e3f2fd;
            padding: 5px 10px;
            margin-right: 5px;
            border-radius: 20px;
            font-size: 12px;
            display: inline-block;
            margin-top: 5px;
        }

    </style>

    <script>
        function blockPostJob() {
            alert("Complete your profile (100%) before posting a job.");
        }
    </script>

</head>

<body>

<div class="header">

    <div class="nav-left">
        <% if (profileComplete) { %>
            <a href="post_job_title.jsp" class="post-job-btn">+ Post Job</a>
        <% } else { %>
            <span class="post-job-btn disabled" onclick="blockPostJob()">+ Post Job</span>
        <% } %>

        <!-- ✅ WALLET BUTTON ADDED -->
        <a href="WalletServlet" class="wallet-btn">
            💰 Wallet
        </a>
    </div>

    <a href="ClientProfileServlet" class="profile-icon">
        <%= profile.getName().substring(0,1).toUpperCase() %>
    </a>

</div>

<% if (!profileComplete) { %>
    <div class="warning">
        Your profile is <b><%= completed %>%</b> complete.
        Please complete remaining details to post a job.
    </div>
<% } %>

<!-- ================= ACTIVE JOBS SECTION ================= -->

<div class="jobs-container">

    <h2>Active Jobs</h2>

    <%
        List<Job> activeJobs = (List<Job>) request.getAttribute("activeJobs");
    %>

    <% if (activeJobs == null || activeJobs.isEmpty()) { %>

        <p>No active jobs found.</p>

    <% } else {

        for (Job job : activeJobs) {
    %>

        <div class="job-card" style="position:relative;">

            <h3>
                <a href="JobInfoServlet?id=<%= job.getJobId() %>">
                    <%= job.getTitle() %>
                </a>
            </h3>

            <!-- DELETE BUTTON -->
            <form action="DeleteJobServlet" method="post"
                  style="position:absolute; top:20px; right:20px;"
                  onsubmit="return confirm('Are you sure you want to delete this job?');">

                <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>

                <button type="submit"
                        style="background:#dc3545; color:white; border:none;
                               padding:6px 12px; border-radius:5px; cursor:pointer;">
                    Delete
                </button>
            </form>

            <p><b>Budget:</b> ₹ <%= job.getBudget() %></p>
            <p><b>Duration:</b> <%= job.getDuration() %></p>
            <p><b>Level:</b> <%= job.getFreelancerLevel() %></p>

            <p><b>Skills:</b><br/>

                <%
                    if (job.getSkills() != null) {
                        for (JobSkill skill : job.getSkills()) {
                %>
                    <span class="skill-tag">
                        <%= skill.getSkillName() %>
                    </span>
                <%
                        }
                    }
                %>

            </p>

        </div>

    <%  }
       } %>

</div>

</body>
</html>