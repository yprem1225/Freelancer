<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("fName") %> | WorkPort Professional Profile</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --primary-light: #eff6ff;
            --accent: #7c3aed;
            --dark: #0f172a;
            --slate-50: #f8fafc;
            --slate-100: #f1f5f9;
            --slate-200: #e2e8f0;
            --slate-400: #94a3b8;
            --slate-600: #475569;
            --slate-900: #0f172a;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-md: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #f8fafc; 
            color: var(--slate-900); 
            line-height: 1.6;
        }

        /* --- TOPBAR --- */
        .topbar {
            height: 70px; 
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--slate-200);
            display: flex; align-items: center; padding: 0 10%;
            position: sticky; top: 0; z-index: 1000;
        }
        
        .logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-txt { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.5rem; font-weight: 800; letter-spacing: -0.5px; }
        .logo-txt .w { color: var(--dark); } 
        .logo-txt .p { color: var(--primary); }

        .btn-back {
            margin-left: auto; display: inline-flex; align-items: center; gap: 8px;
            padding: 10px 20px; background: #fff; border: 1px solid var(--slate-200);
            border-radius: 10px; font-size: 14px; font-weight: 600;
            color: var(--slate-600); cursor: pointer; text-decoration: none; 
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
        }
        .btn-back:hover { 
            border-color: var(--primary); 
            color: var(--primary); 
            background: var(--primary-light);
            transform: translateY(-1px);
        }

        /* --- LAYOUT --- */
        .container { max-width: 900px; margin: 50px auto; padding: 0 24px; }

        /* --- HERO SECTION --- */
        .hero-card {
            background: #fff; border-radius: 24px;
            border: 1px solid var(--slate-200);
            box-shadow: var(--shadow-md);
            padding: 40px; margin-bottom: 30px;
            display: flex; gap: 32px; align-items: center;
            position: relative; overflow: hidden;
        }
        
        /* Subtle background pattern for hero */
        .hero-card::before {
            content: ""; position: absolute; top: 0; right: 0;
            width: 150px; height: 150px;
            background: radial-gradient(circle, var(--primary-light) 0%, transparent 70%);
            z-index: 0; opacity: 0.5;
        }

        .avatar {
            width: 110px; height: 110px; border-radius: 22px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            display: flex; align-items: center; justify-content: center;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 2.5rem; font-weight: 800; color: #fff;
            flex-shrink: 0; position: relative; z-index: 1;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.2);
        }

        .hero-info { flex: 1; position: relative; z-index: 1; }
        .hero-info h1 {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 2rem; font-weight: 800; color: var(--dark); 
            margin-bottom: 6px; letter-spacing: -0.5px;
        }
        .hero-title {
            font-size: 17px; color: var(--primary); font-weight: 600; 
            margin-bottom: 18px; display: flex; align-items: center; gap: 6px;
        }
        .hero-meta {
            display: flex; flex-wrap: wrap; gap: 20px; font-size: 14px; color: var(--slate-600);
        }
        .hero-meta span { display: flex; align-items: center; gap: 8px; }
        .hero-meta i { color: var(--primary); font-size: 16px; }

        /* --- SECTION CARDS --- */
        .section-card {
            background: #fff; border-radius: 20px;
            border: 1px solid var(--slate-200);
            padding: 32px; margin-bottom: 24px;
            transition: transform 0.2s ease;
        }
        .section-card:hover { transform: translateY(-2px); }

        .section-card h3 {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.1rem; font-weight: 700; color: var(--dark);
            margin-bottom: 22px;
            display: flex; align-items: center; gap: 10px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .section-card h3 i { 
            padding: 8px; background: var(--primary-light); 
            border-radius: 8px; font-size: 1.1rem;
        }

        /* --- STATS --- */
        .stats-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .stat-box {
            background: var(--slate-50); border-radius: 16px;
            padding: 24px; text-align: center;
            border: 1px solid var(--slate-200);
            transition: all 0.2s ease;
        }
        .stat-box:hover { border-color: var(--primary); background: #fff; }
        .stat-box .stat-val {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.8rem; font-weight: 800; color: var(--primary);
        }
        .stat-box .stat-lbl {
            font-size: 12px; color: var(--slate-400); font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px; margin-top: 6px;
        }

        /* --- BIO & SKILLS --- */
        .bio-text { font-size: 15px; line-height: 1.8; color: var(--slate-600); }
        
        .skills-wrap { display: flex; flex-wrap: wrap; gap: 10px; }
        .skill-badge {
            background: var(--slate-100); color: var(--slate-900);
            padding: 8px 18px; border-radius: 12px;
            font-size: 14px; font-weight: 600; border: 1px solid var(--slate-200);
            transition: all 0.2s;
        }
        .skill-badge:hover {
            background: var(--primary); color: #fff; border-color: var(--primary);
        }

        /* --- LINKS --- */
        .link-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .ext-link {
            display: flex; align-items: center; justify-content: space-between;
            padding: 14px 20px; background: var(--slate-50);
            border: 1px solid var(--slate-200); border-radius: 12px;
            color: var(--dark); text-decoration: none; font-weight: 600;
            font-size: 14px; transition: all 0.2s;
        }
        .ext-link:hover { 
            background: #fff; border-color: var(--primary); 
            box-shadow: var(--shadow-sm); color: var(--primary);
        }
        .no-link { 
            padding: 14px 20px; background: var(--slate-100); 
            border-radius: 12px; color: var(--slate-400); 
            font-size: 14px; border: 1px dashed var(--slate-200);
        }

        @media (max-width: 640px) {
            .hero-card { flex-direction: column; text-align: center; padding: 30px 20px; }
            .hero-meta { justify-content: center; }
            .stats-row, .link-row { grid-template-columns: 1fr; }
            .topbar { padding: 0 5%; }
        }
    </style>
</head>
<body>

<%
    String fName     = (String)  request.getAttribute("fName");
    String fEmail    = (String)  request.getAttribute("fEmail");
    String fPhone    = (String)  request.getAttribute("fPhone");
    String fTitle    = (String)  request.getAttribute("fTitle");
    String fSkills   = (String)  request.getAttribute("fSkills");
    int    fExpYears = (Integer) request.getAttribute("fExpYears");
    double fRate     = (Double)  request.getAttribute("fRate");
    String fBio      = (String)  request.getAttribute("fBio");
    String fLinkedin = (String)  request.getAttribute("fLinkedin");
    String fGithub   = (String)  request.getAttribute("fGithub");

    String[] parts = (fName != null ? fName.trim() : "FL").split("\\s+");
    String initials = parts[0].substring(0,1).toUpperCase()
                    + (parts.length > 1 ? parts[parts.length-1].substring(0,1).toUpperCase() : "");
%>

<nav class="topbar">
    <a href="ClientHomeServlet" class="logo">
        <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:34px;height:34px;">
            <rect width="34" height="34" rx="10" fill="#2563eb"/>
            <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
        </svg>
        <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
    </a>
    <a href="javascript:history.back()" class="btn-back">
        <i class="bi bi-chevron-left"></i> Back
    </a>
</nav>

<div class="container">

    <div class="hero-card">
        <div class="avatar"><%= initials %></div>
        <div class="hero-info">
            <h1><%= fName != null ? fName : "Freelancer Profile" %></h1>
            <div class="hero-title">
                <i class="bi bi-patch-check-fill"></i>
                <%= fTitle != null ? fTitle : "Professional Specialist" %>
            </div>
            <div class="hero-meta">
                <span><i class="bi bi-envelope"></i> <%= fEmail != null ? fEmail : "No email provided" %></span>
                <% if(fPhone != null && !fPhone.isEmpty()){ %>
                    <span><i class="bi bi-phone"></i> <%= fPhone %></span>
                <% } %>
            </div>
        </div>
    </div>

    <div class="section-card">
        <h3><i class="bi bi-lightning-charge"></i> Professional Overview</h3>
        <div class="stats-row">
            <div class="stat-box">
                <div class="stat-val"><%= fExpYears %></div>
                <div class="stat-lbl">Years of Experience</div>
            </div>
            <div class="stat-box">
                <div class="stat-val">₹<%= String.format("%.0f", fRate) %></div>
                <div class="stat-lbl">Hourly Rate</div>
            </div>
        </div>
    </div>

    <% if(fBio != null && !fBio.trim().isEmpty()){ %>
    <div class="section-card">
        <h3><i class="bi bi-file-earmark-person"></i> Professional Bio</h3>
        <p class="bio-text"><%= fBio %></p>
    </div>
    <% } %>

    <% if(fSkills != null && !fSkills.trim().isEmpty()){ %>
    <div class="section-card">
        <h3><i class="bi bi-rocket-takeoff"></i> Expert Skills</h3>
        <div class="skills-wrap">
            <%
                for(String sk : fSkills.split("[,;]+")) {
                    sk = sk.trim();
                    if(!sk.isEmpty()) {
            %>
                <span class="skill-badge"><%= sk %></span>
            <%  }} %>
        </div>
    </div>
    <% } %>

    <div class="section-card">
        <h3><i class="bi bi-share"></i> Connect & Portfolio</h3>
        <div class="link-row">
            <% if(fLinkedin != null && !fLinkedin.trim().isEmpty()){ %>
                <a href="<%= fLinkedin %>" target="_blank" class="ext-link">
                    <span><i class="bi bi-linkedin" style="color:#0a66c2"></i> &nbsp; LinkedIn</span>
                    <i class="bi bi-arrow-up-right-short"></i>
                </a>
            <% } else { %>
                <div class="no-link"><i class="bi bi-linkedin"></i> LinkedIn not linked</div>
            <% } %>

            <% if(fGithub != null && !fGithub.trim().isEmpty()){ %>
                <a href="<%= fGithub %>" target="_blank" class="ext-link">
                    <span><i class="bi bi-github" style="color:#171515"></i> &nbsp; GitHub Portfolio</span>
                    <i class="bi bi-arrow-up-right-short"></i>
                </a>
            <% } else { %>
                <div class="no-link"><i class="bi bi-github"></i> GitHub not linked</div>
            <% } %>
        </div>
    </div>

</div>

</body>
</html>