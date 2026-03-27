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
    <title>Notifications | WorkPort</title>
    
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
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

        /* --- NOTIFICATION CARD --- */
        .notif-card {
            background: #fff;
            border: 1.5px solid var(--g200);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: var(--s2);
            transition: transform 0.2s;
        }

        .notif-card:hover {
            transform: translateY(-2px);
        }

        .notif-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .notif-title {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark);
            line-height: 1.4;
        }

        .notif-title span { color: var(--blue); }

        .time-badge {
            font-size: 12px;
            color: var(--g400);
            display: flex;
            align-items: center;
            gap: 4px;
            white-space: nowrap;
        }

        .freelancer-info {
            background: var(--g50);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 20px;
        }

        .info-row { margin-bottom: 8px; font-size: 14px; line-height: 1.5; }
        .info-row b { color: var(--g600); font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; display: block; margin-bottom: 2px; }
        
        .proposal-text {
            color: var(--g800);
            font-style: italic;
            border-left: 3px solid var(--g200);
            padding-left: 12px;
            margin-top: 10px;
        }

        .view-profile-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: var(--blue);
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            margin-bottom: 20px;
            transition: color 0.2s;
        }
        .view-profile-link:hover { color: var(--blue2); text-decoration: underline; }

        /* --- BUTTONS --- */
        .actions-form {
            display: flex;
            gap: 12px;
            border-top: 1px solid var(--g100);
            padding-top: 20px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 800;
            font-size: 14px;
            cursor: pointer;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-accept {
            background: var(--ok);
            color: #fff;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
        }
        .btn-accept:hover { background: #059669; transform: translateY(-1px); }

        .btn-reject {
            background: #fff;
            color: var(--red);
            border: 1.5px solid var(--red1);
        }
        .btn-reject:hover { background: var(--redlt); border-color: var(--red); }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: #fff;
            border-radius: 20px;
            border: 2px dashed var(--g200);
        }
        .empty-state i { font-size: 3rem; color: var(--g200); margin-bottom: 15px; display: block; }
        .empty-state p { color: var(--g400); font-weight: 500; }

    </style>
</head>
<body>

    <nav class="topbar">
        <a href="ClientHomeServlet" class="logo">
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
            <div class="time-badge"><i class="bi bi-bell-fill" style="color: var(--blue)"></i> Recent Updates</div>
        </div>

        <%
        if(list != null && !list.isEmpty()){
            for(Notification n : list){
        %>
            <div class="notif-card">
                <div class="notif-top">
                    <h3 class="notif-title">
                        <span><%= n.getFreelancerName() %></span> applied to "<%= n.getJobTitle() %>"
                    </h3>
                    <div class="time-badge">
                        <i class="bi bi-clock"></i> <%= n.getCreatedAt() %>
                    </div>
                </div>

                <div class="freelancer-info">
                    <div class="info-row">
                        <b>Freelancer Title</b>
                        <%= n.getFreelancerTitle() %>
                    </div>
                    <div class="info-row">
                        <b>Proposal Details</b>
                        <div class="proposal-text">"<%= n.getProposal() %>"</div>
                    </div>
                </div>

                <a href="ViewFreelancerProfileServlet?id=<%=n.getFreelancerId()%>" class="view-profile-link">
                    <i class="bi bi-person-badge"></i> View Freelancer Profile
                </a>

                <form action="UpdateApplicationStatusServlet" method="post" class="actions-form">
                    <input type="hidden" name="appId" value="<%= n.getApplicationId() %>">
                    <input type="hidden" name="jobId" value="<%= n.getJobId() %>">
                    <input type="hidden" name="notificationId" value="<%= n.getNotificationId() %>">

                    <button type="submit" name="status" value="rejected" class="btn btn-reject">
                        <i class="bi bi-x-lg"></i> Reject
                    </button>
                    <button type="submit" name="status" value="accepted" class="btn btn-accept">
                        <i class="bi bi-check-lg"></i> Accept Application
                    </button>
                </form>
            </div>
        <%
            }
        } else {
        %>
            <div class="empty-state">
                <i class="bi bi-envelope-open"></i>
                <p>No new notifications at the moment.</p>
                <a href="ClientHomeServlet" style="color: var(--blue); font-weight: 700; text-decoration: none; margin-top: 10px; display: inline-block;">Back to Dashboard</a>
            </div>
        <%
        }
        %>
    </div>

</body>
</html>