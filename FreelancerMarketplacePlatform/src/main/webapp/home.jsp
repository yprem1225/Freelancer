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
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --nav-bg: #f8fafc; /* Darker white for navbar */
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
            background: var(--nav-bg); /* Updated to darker white */
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
            font-size: 14px;
            font-weight: 500;
            padding: 0 12px;
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
            min-width: 240px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.1);
            border: 1px solid var(--border-light);
            border-radius: 0 0 10px 10px;
            padding: 12px 0;
        }

        .nav-item:hover .dropdown-content { display: block; }

        .dropdown-content a {
            color: var(--text-dark);
            padding: 12px 24px;
            text-decoration: none;
            display: block;
            font-size: 14px;
        }

        .dropdown-content a:hover {
            background-color: #f8fafc;
            color: var(--primary-blue);
        }

        /* --- SEARCH BAR --- */
        .search-container {
            flex-grow: 1;
            max-width: 400px;
            margin: 0 30px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border-radius: 25px;
            border: 1px solid var(--border-light);
            font-size: 14px;
            outline: none;
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .nav-right {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .profile-box {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }

        .user-name-small { font-weight: 700; font-size: 14px; color: var(--text-dark); margin: 0; }
        .user-role-badge { 
            background: #eff6ff; 
            color: var(--primary-blue); 
            font-size: 10px; 
            font-weight: 700; 
            padding: 2px 8px; 
            border-radius: 6px;
            text-transform: uppercase;
        }

        .logout-btn {
            border: 1.5px solid var(--primary-blue);
            color: var(--primary-blue);
            background: transparent;
            padding: 7px 16px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 14px;
        }

        .logout-btn:hover { background: var(--primary-blue); color: white; }

        /* --- HERO BANNER SLIDER --- */
        .hero-banner-container {
            width: 90%; /* Matches the alignment of sub-nav content */
            max-width: 1200px;
            margin: 30px auto 0;
            border: 2px solid var(--primary-blue); 
            border-radius: 16px;
            overflow: hidden;
            height: 400px; /* Doubled height */
            position: relative;
            box-shadow: var(--card-shadow);
        }

        .slider {
            display: flex;
            width: 100%;
            height: 100%;
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .slide {
            min-width: 100%;
            height: 100%;
        }

        .slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* --- HERO SECTION --- */
        .sub-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 40px 5%;
            background: #fff;
        }

        .welcome-text h1 { 
            font-size: 2.2rem; 
            font-weight: 400;
            margin: 0; 
            color: #1e293b; 
        }
        
        .welcome-text h1 b { 
            font-weight: 800;
            color: #000;
        }

        .post-project-btn {
            background-color: var(--primary-blue);
            color: white;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            font-size: 15px;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
            transition: background 0.2s;
        }

        .post-project-btn:hover { background-color: var(--primary-blue-hover); }

        /* --- MAIN CONTENT --- */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            width: 90%;
            padding-bottom: 40px;
        }

        .job-card {
            background: white;
            padding: 30px;
            margin-bottom: 25px;
            border-radius: 12px;
            border: 1px solid var(--border-light);
            position: relative;
        }

        .job-card:hover { border-color: #cbd5e1; }

        .job-card h3 a { color: #000; text-decoration: none; font-size: 1.3rem; font-weight: 700; }

        .delete-btn {
            position: absolute;
            top: 30px;
            right: 30px;
            background: #fff;
            color: #ef4444;
            border: 1px solid #fecaca;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.3s ease; /* Smooth hover transition */
        }

        /* Hover Change: Full red background and white text */
        .delete-btn:hover {
            background: #ef4444;
            color: #ffffff;
            border-color: #ef4444;
        }

        /* --- RESOURCE GRID --- */
        .resource-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 40px;
        }

        .resource-card {
            background: #fff;
            border: 1px solid var(--border-light);
            border-radius: 12px;
            padding: 24px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: left;
        }

        .resource-card:hover {
            box-shadow: var(--card-shadow);
            transform: translateY(-2px);
            border-color: var(--primary-blue);
        }

        .resource-icon {
            font-size: 24px;
            margin-bottom: 15px;
            color: var(--primary-blue);
        }

        .resource-card h3 {
            margin: 0 0 10px 0;
            font-size: 18px;
            color: var(--text-dark);
        }

        .resource-card p {
            margin: 0;
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.5;
        }

        /* --- MODAL CSS --- */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            width: 90%;
            max-width: 600px;
            border-radius: 16px;
            padding: 40px;
            position: relative;
            animation: slideUp 0.3s ease-out;
        }

        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .close-modal {
            position: absolute;
            top: 20px; right: 20px;
            font-size: 24px;
            cursor: pointer;
            color: var(--text-muted);
        }

        .modal-header { border-bottom: 1px solid var(--border-light); padding-bottom: 15px; margin-bottom: 20px; }
        .modal-header h2 { margin: 0; color: var(--primary-blue); }

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
                </div>
            </div>
            <div class="nav-item">
                <a class="nav-link">Manage work ▼</a>
                <div class="dropdown-content">
                    <a href="#">My Jobs</a>
                    <a href="#">Contracts</a>
                </div>
            </div>
            <div class="nav-item">
                <a class="nav-link">Reports ▼</a>
                <div class="dropdown-content">
                    <a href="#">Weekly Summary</a>
                </div>
            </div>
            <a href="#" class="nav-link">Messages</a>
        </div>
        <a href="NotificationServlet" class="nav-link">🔔 Notifications</a>


        <div class="search-container">
            <span class="search-icon">🔍</span>
            <input type="text" class="search-input" placeholder="Search for talent or projects...">
        </div>

        <div class="nav-right">
            <a href="WalletServlet" class="nav-link">💰 Wallet</a>
            <a href="ClientProfileServlet" class="profile-box">
                <div class="profile-info" style="text-align: right;">
                    <p class="user-name-small"><%= profile.getName() %></p>
                    <span class="user-role-badge">Client</span>
                </div>
                <div style="width:40px; height:40px; border-radius:50%; background:var(--primary-blue); color:white; display:flex; align-items:center; justify-content:center; font-weight:bold;">
                    <%= profile.getName().substring(0,1).toUpperCase() %>
                </div>
            </a>
            <form action="LogoutServlet" method="post" style="margin:0">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </nav>

    <div class="hero-banner-container">
        <div class="slider" id="bannerSlider">
            <div class="slide"><img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=1200&h=400" alt="Banner 1"></div>
            <div class="slide"><img src="https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=1200&h=400" alt="Banner 2"></div>
            <div class="slide"><img src="https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=1200&h=400" alt="Banner 3"></div>
            <div class="slide"><img src="https://images.unsplash.com/photo-1600880210837-2199b35d5620?auto=format&fit=crop&w=1200&h=400" alt="Banner 4"></div>
        </div>
    </div>

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

        <h2 style="margin-bottom:25px; font-size:1.5rem;">Your Active Listings</h2>
        <div class="jobs-list">
            <%
                List<Job> activeJobs = (List<Job>) request.getAttribute("activeJobs");
                if (activeJobs == null || activeJobs.isEmpty()) {
            %>
                <div style="text-align:center; padding:60px; border:2px dashed var(--border-light); border-radius:12px; color:var(--text-muted);">
                    <p>No active project listings found.</p>
                </div>
            <% } else {
                for (Job job : activeJobs) {
            %>
                <div class="job-card">
                    <h3><a href="JobInfoServlet?id=<%= job.getJobId() %>"><%= job.getTitle() %></a></h3>
                    <a href="ChatServlet?jobId=<%=job.getJobId()%>">Open Chat</a>
                    <form action="DeleteJobServlet" method="post" onsubmit="return confirm('Permanently remove this project?');">
                        <input type="hidden" name="jobId" value="<%= job.getJobId() %>"/>
                        <button type="submit" class="delete-btn">Remove</button>
                    </form>
                    <div style="display:flex; gap:30px; margin-top:15px; color:var(--text-muted); font-size:14px;">
                        <span><strong>Budget:</strong> ₹<%= job.getBudget() %></span>
                        <span><strong>Duration:</strong> <%= job.getDuration() %></span>
                    </div>
                </div>
            <% 
            } // END ACTIVE LOOP
        } 
        %>
        </div>
        
        <hr style="margin:50px 0;">

    <h2 style="margin-bottom:25px; font-size:1.5rem;">Your Ongoing Projects</h2>

    <div class="jobs-list">
        <%
            List<Job> workingJobs = (List<Job>) request.getAttribute("workingJobs");

            if (workingJobs == null || workingJobs.isEmpty()) {
        %>
            <div style="text-align:center; padding:60px;">
                <p>No ongoing projects found.</p>
            </div>
        <% } else {
            for (Job job : workingJobs) {
        %>

        <!-- WORKING JOB CARD -->
        <div class="job-card" style="border-left:5px solid #22c55e;">
            <h3><a href="JobInfoServlet?id=<%= job.getJobId() %>"><%= job.getTitle() %></a></h3>

            <a href="ChatServlet?jobId=<%=job.getJobId()%>">Open Chat</a>

            <div style="display:flex; gap:30px; margin-top:15px;">
                <span><strong>Budget:</strong> ₹<%= job.getBudget() %></span>
                <span><strong>Duration:</strong> <%= job.getDuration() %></span>
                <span style="color:#22c55e;">● In Progress</span>
            </div>
        </div>

        <% 
            }
        } 
        %>
    </div>
        

        <hr style="border:0; border-top:1px solid var(--border-light); margin:50px 0;">

        <h2 style="margin-bottom:20px; font-size:1.5rem;">Resource Center</h2>
        <div class="resource-grid">
            <div class="resource-card" onclick="openResource('howTo')">
                <div class="resource-icon">👤</div>
                <h3>How to Hire</h3>
                <p>Learn best practices for finding and hiring the right freelancer for your project.</p>
            </div>
            <div class="resource-card" onclick="openResource('payments')">
                <div class="resource-icon">💳</div>
                <h3>Payments</h3>
                <p>Secure and timely payments for all your projects using industry-standard encryption.</p>
            </div>
            <div class="resource-card" onclick="openResource('safety')">
                <div class="resource-icon">🛡️</div>
                <h3>Trust & Safety</h3>
                <p>How we keep your data secure and ensure a safe environment for your business.</p>
            </div>
        </div>
    </main>

    <div id="resourceModal" class="modal-overlay" onclick="closeModal()">
        <div class="modal-content" onclick="event.stopPropagation()">
            <span class="close-modal" onclick="closeModal()">&times;</span>
            <div id="modalBody"></div>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-grid">
            <div>
                <span class="footer-logo"><span class="work">Work</span><span class="port">Port</span></span>
                <p>Connecting businesses with top-tier global talent.</p>
            </div>
            <div>
                <h4>Support</h4>
                <a href="#">Help Center</a><br>
                <a href="#">Safety & Security</a>
            </div>
        </div>
    </footer>

    <script>
        // --- 4-Image Slider Logic ---
        let currentSlide = 0;
        const slider = document.getElementById('bannerSlider');
        const slides = document.querySelectorAll('.slide');
        
        setInterval(() => {
            currentSlide = (currentSlide + 1) % slides.length;
            slider.style.transform = `translateX(-${currentSlide * 100}%)`;
        }, 4000); 

        // --- Resource Content Logic ---
        const content = {
            howTo: {
                title: "How to Hire",
                body: "<h3>The Hiring Process</h3><ul><li><b>Post Jobs:</b> Be clear and detailed.</li><li><b>Evaluate Bids:</b> Review portfolios and past feedback.</li><li><b>Communication:</b> Use our messaging system to clarify details.</li></ul>"
            },
            payments: {
                title: "Key Payment Features",
                body: "<h3>Secure Payments</h3><p>Our platform ensures secure and timely payments for all projects.</p><ul><li><b>Escrow Security:</b> Funds held safely until you approve work.</li></ul>"
            },
            safety: {
                title: "Trust & Safety",
                body: "<h3>Your Security Matters</h3><p>We use industry-standard encryption protocols to protect your financial and personal data.</p>"
            }
        };

        function openResource(type) {
            const modal = document.getElementById('resourceModal');
            const body = document.getElementById('modalBody');
            body.innerHTML = `
                <div class="modal-header"><h2>${content[type].title}</h2></div>
                <div style="line-height:1.6; color:#334155;">${content[type].body}</div>
            `;
            modal.style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('resourceModal').style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target == document.getElementById('resourceModal')) {
                closeModal();
            }
        }
    </script>
</body>
</html>