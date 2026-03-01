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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | WorkPort</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-hover: #1d4ed8;
            --dark-bg: #000000;
            --text-dark: #1e293b;
            --text-muted: #64748b;
            --border-light: #e2e8f0;
            --nav-bg: #f8fafc;
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
            background: var(--nav-bg);
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
            margin-right: 35px;
        }
        .logo .work { color: #000000; }
        .logo .port { color: var(--primary-blue); }

        .nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        /* --- PROFILE FORM UI --- */
        .main-container {
            flex: 1;
            padding: 60px 5%;
            display: flex;
            justify-content: center;
            background-color: #fcfcfc;
        }

        .profile-card {
            width: 100%;
            max-width: 600px;
            background: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border: 1px solid var(--border-light);
        }

        .profile-card h2 {
            margin-bottom: 30px;
            font-weight: 800;
            font-size: 1.8rem;
            color: #000;
            text-align: center;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 30px;
            padding: 20px;
            background: var(--nav-bg);
            border-radius: 12px;
        }

        .info-item b { color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; display: block; }
        .info-item span { font-weight: 600; color: var(--text-dark); }

        /* --- FLOATING INPUTS --- */
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-light);
            border-radius: 8px;
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s;
            box-sizing: border-box;
            font-family: inherit;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
        }

        label {
            font-weight: 600;
            font-size: 0.9rem;
            margin-bottom: 8px;
            display: block;
            color: var(--text-dark);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        /* --- BUTTONS --- */
        .btn-save {
            background: var(--primary-blue);
            color: #fff;
            padding: 14px;
            border: none;
            width: 100%;
            border-radius: 8px;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .btn-save:hover { background: var(--primary-blue-hover); }

        .completion-status {
            margin-top: 20px;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            font-weight: 700;
            font-size: 0.9rem;
            background: <%= profileComplete ? "#ecfdf5" : "#fff1f2" %>;
            color: <%= profileComplete ? "#059669" : "#e11d48" %>;
        }

        .action-links {
            margin-top: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--border-light);
            padding-top: 20px;
        }

        .link-home { text-decoration: none; color: var(--primary-blue); font-weight: 600; }
        .link-logout { text-decoration: none; color: #ef4444; font-weight: 600; }

        /* --- FOOTER --- */
        .footer {
            background: var(--dark-bg);
            color: #ffffff;
            padding: 60px 5% 40px;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
        }

        .footer h4 { color: #fff; margin-bottom: 20px; border-left: 3px solid var(--primary-blue); padding-left: 10px; }
        .footer p, .footer a { color: #94a3b8; text-decoration: none; font-size: 14px; line-height: 2; }
    </style>
</head>

<body>

    <nav class="navbar">
        <a href="ClientHomeServlet" class="logo">
            <span class="work">Work</span><span class="port">Port</span>
        </a>
        <div class="nav-right">
            <a href="LogoutServlet" style="text-decoration: none; color: #ef4444; font-weight: 600; font-size: 14px;">Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <div class="profile-card">
            <h2>My Profile</h2>

            <div class="info-grid">
                <div class="info-item">
                    <b>Name</b>
                    <span><%= profile.getName() %></span>
                </div>
                <div class="info-item">
                    <b>Role</b>
                    <span><%= profile.getRole() %></span>
                </div>
                <div class="info-item" style="grid-column: span 2;">
                    <b>Email Address</b>
                    <span><%= profile.getEmail() %></span>
                </div>
            </div>

            <form action="ClientProfileServlet" method="post">
                <div class="form-group">
                    <label>Phone Number</label>
                    <input class="form-control" name="phone" placeholder="Enter phone number"
                           value="<%= profile.getPhone()==null?"":profile.getPhone() %>">
                </div>

                <div class="form-group">
                    <label>Company Name</label>
                    <input class="form-control" name="companyname" placeholder="Enter company name"
                           value="<%= profile.getCompanyname()==null?"":profile.getCompanyname() %>">
                </div>

                <div class="form-group">
                    <label>Company Biography</label>
                    <textarea class="form-control" name="companybio" placeholder="Tell us about your business..."><%= profile.getCompanybio()==null?"":profile.getCompanybio() %></textarea>
                </div>

                <button type="submit" class="btn-save">Update Profile</button>
            </form>

            <div class="completion-status">
                Profile Completion: <%= completed %>%
                <% if (!profileComplete) { %>
                    <div style="font-weight: 400; font-size: 0.8rem;">Please fill in all fields to reach 100%</div>
                <% } %>
            </div>

            <div class="action-links">
                <a href="ClientHomeServlet" class="link-home">← Back to Dashboard</a>
                <a href="LogoutServlet" class="link-logout">Logout</a>
            </div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-grid">
            <div>
                <span style="font-size: 1.2rem; font-weight: 800;"><span style="color:#fff;">Work</span><span style="color:var(--primary-blue);">Port</span></span>
                <p>Leading the way in global talent connection. We help businesses find top-tier freelancers.</p>
            </div>
            <div>
                <h4>Support</h4>
                <a href="#">Help Center</a><br>
                <a href="#">Safety & Security</a><br>
                <a href="#">Terms of Service</a>
            </div>
        </div>
        <div style="text-align:center; margin-top:50px; color:#475569; font-size:12px;">
            &copy; 2026 WorkPort Marketplace Inc.
        </div>
    </footer>

</body>
</html>