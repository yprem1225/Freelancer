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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard | WorkPort</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-hover: #1d4ed8;
            --dark-bg: #000000;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --border-light: #e2e8f0;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: #ffffff;
            color: var(--text-dark);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* --- NAVIGATION --- */
        .navbar {
            display: flex;
            align-items: center;
            padding: 0 5%;
            background: #fff;
            border-bottom: 1px solid var(--border-light);
            height: 75px;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo {
            font-size: 1.7rem;
            font-weight: 800;
            text-decoration: none;
            margin-right: 45px;
        }

        .logo .work { color: #000000; }
        .logo .port { color: var(--primary-blue); }

        .nav-links {
            display: flex;
            gap: 8px;
            height: 100%;
            align-items: center;
        }

        .nav-item {
            position: relative;
            height: 100%;
            display: flex;
            align-items: center;
        }

        .nav-link {
            text-decoration: none;
            color: var(--text-dark);
            font-size: 15px;
            font-weight: 500;
            padding: 0 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            height: 100%;
            transition: color 0.2s;
        }

        .nav-link:hover { color: var(--primary-blue); }

        .dropdown-content {
            display: none;
            position: absolute;
            top: 75px;
            left: 0;
            background-color: #fff;
            min-width: 260px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.1);
            border: 1px solid var(--border-light);
            border-radius: 0 0 10px 10px;
            padding: 12px 0;
        }

        .nav-item:hover .dropdown-content { display: block; }

        .dropdown-content a {
            color: var(--text-dark);
            padding: 14px 24px;
            text-decoration: none;
            display: block;
            font-size: 15px;
        }

        .dropdown-content a:hover {
            background-color: #f8fafc;
            color: var(--primary-blue);
        }

        .nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .profile-box {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .user-name-small { font-weight: 700; font-size: 15px; color: var(--text-dark); margin: 0; }
        .user-role-badge { 
            background: #eff6ff; 
            color: var(--primary-blue); 
            font-size: 11px; 
            font-weight: 700; 
            padding: 3px 10px; 
            border-radius: 6px;
            text-transform: uppercase;
        }

        .logout-btn {
            border: 1.5px solid var(--primary-blue);
            color: var(--primary-blue);
            background: transparent;
            padding: 9px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .logout-btn:hover { background: var(--primary-blue); color: white; }

        /* --- HERO SECTION --- */
        .sub-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 50px 5%;
            background: #fff;
        }

        .welcome-text h1 { 
            font-size: 2.4rem; 
            font-weight: 400; /* Not bold */
            margin: 0; 
            color: #1e293b; 
        }
        
        .welcome-text h1 b { 
            font-weight: 800; /* Name is bold */
            color: #000;
        }

        .post-project-btn {
            background-color: var(--primary-blue);
            color: white;
            padding: 16px 32px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            font-size: 16px;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
            transition: background 0.2s;
        }

        .post-project-btn:hover { background-color: var(--primary-blue-hover); }

        /* --- MAIN CONTENT --- */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            width: 90%;
            padding-bottom: 80px;
        }

        .job-card {
            background: white;
            padding: 35px;
            margin-bottom: 25px;
            border-radius: 12px;
            border: 1px solid var(--border-light);
            position: relative;
        }

        .job-card:hover { border-color: #cbd5e1; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }

        .job-card h3 a { color: #000; text-decoration: none; font-size: 1.4rem; font-weight: 700; }

        .delete-btn {
            position: absolute;
            top: 35px;
            right: 35px;
            background: #fff;
            color: #ef4444;
            border: 1px solid #fecaca;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
        }

        .delete-btn:hover { background: #fef2f2; }

        /* --- FOOTER --- */
        .footer {
            background: var(--dark-bg);
            color: #ffffff;
            padding: 80px 5% 40px;
            margin-top: auto;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 60px;
        }

        .footer h4 { font-size: 1.2rem; margin-bottom: 25px; color: #ffffff; border-left: 3px solid var(--primary-blue); padding-left: 12px; }
        .footer p, .footer a { color: #94a3b8; text-decoration: none; line-height: 2.2; font-size: 15px; }
        .footer a:hover { color: var(--primary-blue); }

        .footer-logo { font-size: 1.5rem; font-weight: 800; margin-bottom: 20px; display: block; }
        .footer-logo .work { color: #fff; }
    </style>
</head>

<body>

    <nav class="navbar">
        <a href="client_home.jsp" class="logo">
            <span class="work">Work</span><span class="port">Port</span>
        </a>
        
        <div class="nav-links">
            <div class="nav-item">
                <a class="nav-link">Hire talent ▼</a>
                <div class="dropdown-content">
                    <a href="#">Post a job</a>
                    <a href="#">Search for talent</a>
                    <a href="#">Talent you've hired</a>
                    <a href="#">Direct contracts</a>
                </div>
            </div>
            <div class="nav-item">
                <a class="nav-link">Manage work ▼</a>
                <div class="dropdown-content">
                    <a href="#">My Jobs</a>
                    <a href="#">Contracts</a>
                    <a href="#">Timesheets</a>
                </div>
            </div>
            <div class="nav-item">
                <a class="nav-link">Reports ▼</a>
                <div class="dropdown-content">
                    <a href="#">Weekly Summary</a>
                    <a href="#">Transaction History</a>
                </div>
            </div>
            <a href="#" class="nav-link">Messages</a>
        </div>

        <div class="nav-right">
            <a href="WalletServlet" class="nav-link">💰 Wallet</a>
            
            <a href="ClientProfileServlet" class="profile-box">
                <div class="profile-info" style="text-align: right;">
                    <p class="user-name-small"><%= profile.getName() %></p>
                    <span class="user-role-badge">Client</span>
                </div>
                <div style="width:42px; height:42px; border-radius:50%; background:var(--primary-blue); color:white; display:flex; align-items:center; justify-content:center; font-weight:bold; font-size:18px;">
                    <%= profile.getName().substring(0,1).toUpperCase() %>
                </div>
            </a>

            <form action="LogoutServlet" method="post" style="margin:0">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </nav>

    <div class="sub-nav">
        <div class="welcome-text">
            <h1>Welcome back, <b><%= profile.getName() %></b></h1>
            <p style="margin-top:8px; color:var(--text-muted);">View your active projects and manage your team.</p>
        </div>

        <% if (profileComplete) { %>
            <a href="post_job_title.jsp" class="post-project-btn">+ Post New Project</a>
        <% } else { %>
            <button class="post-project-btn" style="background:#cbd5e1; box-shadow:none; cursor:not-allowed;" onclick="alert('Please complete your profile details first!')">+ Post New Project</button>
        <% } %>
    </div>

    <main class="main-content">
        <% if (!profileComplete) { %>
            <div style="background:#fffbeb; padding:24px; border-radius:12px; margin-bottom:40px; border:1px solid #fde68a; color:#92400e;">
                <span style="font-weight:700;">Profile incomplete (<%= completed %>%)</span> &mdash; Add your details to post a new project.
            </div>
        <% } %>

        <h2 style="margin-bottom:30px; font-size:1.6rem;">Your Active Listings</h2>

        <div class="jobs-list">
            <%
                List<Job> activeJobs = (List<Job>) request.getAttribute("activeJobs");
                if (activeJobs == null || activeJobs.isEmpty()) {
            %>
                <div style="text-align:center; padding:80px; border:2px dashed var(--border-light); border-radius:16px; color:var(--text-muted);">
                    <p style="font-size:1.1rem;">You don't have any active project listings right now.</p>
                </div>
            <% } else {
                for (Job job : activeJobs) {
            %>
                <div class="job-card">
                    <h3><a href="JobInfoServlet?id=<%= job.getJobId() %>"><%= job.getTitle() %></a></h3>
                    
                    <form action="DeleteJobServlet" method="post" onsubmit="return confirm('Permanently delete this project?');">
                        <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                        <button type="submit" class="delete-btn">Remove</button>
                    </form>

                    <div style="display:flex; gap:35px; margin:20px 0; color:var(--text-muted); font-size:15px;">
                        <span><strong>Budget:</strong> ₹<%= job.getBudget() %></span>
                        <span><strong>Duration:</strong> <%= job.getDuration() %></span>
                        <span><strong>Level:</strong> <%= job.getFreelancerLevel() %></span>
                    </div>

                    <div style="display:flex; gap:10px; flex-wrap:wrap;">
                        <% if (job.getSkills() != null) { 
                            for (JobSkill skill : job.getSkills()) { %>
                            <span style="background:#f1f5f9; padding:6px 14px; border-radius:6px; font-size:13px; font-weight:500; color:#475569;"><%= skill.getSkillName() %></span>
                        <% } } %>
                    </div>
                </div>
            <% } } %>
        </div>
    </main>

    <footer class="footer">
        <div class="footer-grid">
            <div>
                <span class="footer-logo"><span class="work">Work</span><span class="port">Port</span></span>
                <p>Leading the way in global talent connection. We help businesses find top-tier freelancers for any project.</p>
            </div>
            <div>
                <h4>For Clients</h4>
                <a href="#">How to Hire</a><br>
                <a href="#">Talent Marketplace</a><br>
                <a href="#">Project Management</a><br>
                <a href="#">Enterprise</a>
            </div>
            <div>
                <h4>Resources</h4>
                <a href="#">Help Center</a><br>
                <a href="#">Safety & Security</a><br>
                <a href="#">Success Stories</a><br>
                <a href="#">Community</a>
            </div>
        </div>
        <div style="text-align:center; margin-top:70px; border-top:1px solid #262626; padding-top:30px; font-size:13px; color:#666;">
            &copy; 2026 WorkPort Marketplace Inc. All rights reserved.
        </div>
    </footer>

</body>
</html>