<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Notification"%>

<%
List<Notification> list = (List<Notification>)request.getAttribute("notifications");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Notifications | WorkPort</title>
    
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --blue: #2563eb;
            --blue2: #1d4ed8;
            --bluelt: #eff6ff;
            --dark: #0c1a3a;
            --g50: #f9fafb;
            --g100: #f3f4f6;
            --g200: #e5e7eb;
            --g400: #9ca3af;
            --g600: #4b5563;
            --g800: #1f2937;
            --ok: #10b981;
            --oklt: #ecfdf5;
            --red: #ef4444;
            --redlt: #fef2f2;
            --s2: 0 10px 32px rgba(37,99,235,.13), 0 2px 8px rgba(0,0,0,.06);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        
        body {
            font-family: 'DM Sans', sans-serif;
            background: #f1f5f9;
            color: var(--g800);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* --- TOPBAR --- */
        .topbar {
            height: 64px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--g200);
            display: flex; align-items: center;
            padding: 0 5%;
            position: sticky; top: 0; z-index: 1000;
        }

        .logo { display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .logo-txt { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.4rem; font-weight: 800; }
        .logo-txt .w { color: var(--g800); }
        .logo-txt .p { color: var(--blue); }

        .container {
            flex: 1;
            max-width: 850px;
            margin: 40px auto;
            padding: 0 20px;
            width: 100%;
        }

        .page-header {
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .page-header h2 {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--dark);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--g600);
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            padding: 8px 16px;
            background: #fff;
            border: 1.5px solid var(--g200);
            border-radius: 8px;
            transition: all 0.2s;
        }
        .back-link:hover { color: var(--blue); border-color: var(--blue); background: var(--bluelt); }

        /* --- NOTIFICATION CARD --- */
        .notif-card {
            background: #fff;
            border: 1.5px solid var(--g200);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: var(--s2);
            transition: transform 0.2s;
            position: relative;
            overflow: hidden;
        }

        .notif-card::before {
            content: '';
            position: absolute;
            left: 0; top: 0; bottom: 0;
            width: 5px;
            background: var(--blue);
        }

        .notif-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .notif-title {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.15rem;
            font-weight: 800;
            color: var(--dark);
        }

        .status-badge {
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 5px 12px;
            border-radius: 20px;
        }
        
        /* Dynamic colors based on keywords */
        .status-accepted { background: var(--oklt); color: var(--ok); }
        .status-rejected { background: var(--redlt); color: var(--red); }
        .status-pending { background: var(--bluelt); color: var(--blue); }

        .time-badge {
            font-size: 12px;
            color: var(--g400);
            display: flex;
            align-items: center;
            gap: 4px;
            margin-top: 15px;
        }

        .notif-content {
            background: var(--g50);
            border-radius: 12px;
            padding: 16px;
        }

        .info-label {
            color: var(--g400);
            font-weight: 800;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: block;
            margin-bottom: 6px;
        }

        .proposal-quote {
            color: var(--g600);
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--g200);
        }

        .message-text {
            color: var(--g800);
            font-weight: 600;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 24px;
            border: 2px dashed var(--g200);
        }
        .empty-state i { font-size: 4rem; color: var(--g200); margin-bottom: 20px; display: block; }
        .empty-state p { color: var(--g400); font-weight: 600; font-size: 1.1rem; }

        /* --- FOOTER --- */
        .ft{background:var(--dark);padding:44px 2.5% 22px; margin-top: auto;}
        .fg{display:grid;grid-template-columns:2fr 1fr 1fr;gap:40px;margin-bottom:30px;}
        .fb{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.35rem;font-weight:800;margin-bottom:8px;display:flex;align-items:center;gap:7px;}
        .fb .w{color:#fff;}.fb .p{color:#60a5fa;}
        .ftag{font-size:13px;color:#ffffff;line-height:1.7;max-width:250px;}
        .fct{font-size:10px;font-weight:800;color:#ffffff;text-transform:uppercase;letter-spacing:1px;margin-bottom:12px;}
        .fl a{display:block;color:#ffffff;font-size:13px;margin-bottom:8px;transition:color .18s,padding .18s; text-decoration: none;}
        .fl a:hover{color:#60a5fa;padding-left:4px;}
        .fbot{border-top:1px solid rgba(255,255,255,.06);padding-top:16px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px;}
        .fbot p{font-size:12px;color:#ffffff;}
        .fs{display:flex;gap:6px;}
        .fs a{width:28px;height:28px;background:rgba(255,255,255,.05);border-radius:7px;display:flex;align-items:center;justify-content:center;color:#ffffff;font-size:13px;border:1px solid rgba(255,255,255,.08);transition:all .18s;}
        .fs a:hover{background:var(--blue);color:#fff;transform:translateY(-2px);}

    </style>
</head>
<body>

    <nav class="topbar">
        <a href="FreelancerHomeServlet" class="logo">
            <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;">
                <rect width="34" height="34" rx="9" fill="#2563eb"/>
                <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
                <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
                <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
        </a>
    </nav>

    <div class="container">
        <div class="page-header">
            <h2>Notifications</h2>
            <a href="FreelancerHomeServlet" class="back-link">
                <i class="bi bi-arrow-left"></i> Dashboard
            </a>
        </div>

        <%
        if(list != null && !list.isEmpty()){
            for(Notification n : list){
                String message = n.getMessage().toLowerCase();
                String statusClass = "status-pending";
                if(message.contains("accepted")) statusClass = "status-accepted";
                else if(message.contains("rejected")) statusClass = "status-rejected";
        %>
            <div class="notif-card">
                <div class="notif-top">
                    <h3 class="notif-title"><%= n.getJobTitle() %></h3>
                    <span class="status-badge <%= statusClass %>">
                        <%= n.getMessage().split(" ")[0] %>
                    </span>
                </div>

                <div class="notif-content">
                    <span class="info-label">Your Submitted Proposal</span>
                    <div class="proposal-quote">
                        "<%= n.getProposal() %>"
                    </div>
                    
                    <span class="info-label">Update Message</span>
                    <div class="message-text">
                        <% if(statusClass.equals("status-accepted")) { %>
                            <i class="bi bi-check-circle-fill" style="color: var(--ok)"></i>
                        <% } else if(statusClass.equals("status-rejected")) { %>
                            <i class="bi bi-x-circle-fill" style="color: var(--red)"></i>
                        <% } else { %>
                            <i class="bi bi-info-circle-fill" style="color: var(--blue)"></i>
                        <% } %>
                        <%= n.getMessage() %>
                    </div>
                </div>

                <div class="time-badge">
                    <i class="bi bi-calendar3"></i> Received on <%= n.getCreatedAt() %>
                </div>
            </div>
        <%
            }
        } else {
        %>
            <div class="empty-state">
                <i class="bi bi-bell-slash"></i>
                <p>No notifications yet. Keep applying for jobs!</p>
                <a href="FreelancerHomeServlet" style="color: var(--blue); font-weight: 700; text-decoration: none; margin-top: 15px; display: inline-block;">Browse Open Jobs</a>
            </div>
        <%
        }
        %>
    </div>

    <footer class="ft">
      <div class="fg">
        <div>
          <div class="fb">
            <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:26px;height:26px;flex-shrink:0;">
              <rect width="34" height="34" rx="9" fill="#2563eb"/>
              <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
              <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
              <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <span class="w">Work</span><span class="p">Port</span>
          </div>
          <p class="ftag">Connecting businesses with top-tier global talent — securely, quickly, at scale.</p>
        </div>
        <div><div class="fct">Support</div><div class="fl"><a href="#">Help Center</a><a href="#">Safety &amp; Security</a><a href="#">Privacy Policy</a></div></div>
        <div><div class="fct">Company</div><div class="fl"><a href="#">About Us</a><a href="#">Careers</a><a href="#">Blog</a></div></div>
      </div>
      <div class="fbot">
        <p>&copy; 2026 WorkPort Technologies. All rights reserved. | Made by Prem Vikas Yadav</p>
        <div class="fs"><a href="#"><i class="bi bi-twitter-x"></i></a><a href="#"><i class="bi bi-linkedin"></i></a><a href="#"><i class="bi bi-github"></i></a></div>
      </div>
    </footer>

</body>
</html>