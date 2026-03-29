<%@ page import="com.model.Wallet" %>
<%@ page import="java.util.*" %>

<%
Wallet wallet = (Wallet) request.getAttribute("wallet");
List<Map<String, Object>> transactions =
    (List<Map<String, Object>>) request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Freelancer Wallet | WorkPort</title>
    
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --blue: #2563eb;
            --blue2: #1d4ed8;
            --bluelt: #eff6ff;
            --blue1: #dbeafe;
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

        h1, h2, h3 { font-family: 'Plus Jakarta Sans', sans-serif; }

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
        .logo-txt { font-size: 1.4rem; font-weight: 800; }
        .logo-txt .w { color: var(--g800); }
        .logo-txt .p { color: var(--blue); }

        .topbar-right { margin-left: auto; }

        .ghost-btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 16px;
            background: #fff; border: 1.5px solid var(--g200);
            border-radius: 8px; font-size: 13px; font-weight: 700;
            color: var(--g600); cursor: pointer; text-decoration: none;
            transition: all .18s;
        }
        .ghost-btn:hover { border-color: var(--blue); color: var(--blue); background: var(--bluelt); }

        /* --- MAIN CONTAINER --- */
        .main-content {
            flex: 1;
            max-width: 950px;
            margin: 40px auto;
            width: 90%;
        }

        /* --- BALANCE CARD --- */
        .balance-card {
            background: var(--dark);
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: white;
            padding: 40px;
            border-radius: 24px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(12, 26, 58, 0.2);
            margin-bottom: 30px;
        }

        .balance-card::after {
            content: ''; position: absolute; top: -50px; right: -50px;
            width: 200px; height: 200px; background: rgba(255,255,255,0.03);
            border-radius: 50%;
        }

        .balance-card h2 { font-size: 14px; text-transform: uppercase; letter-spacing: 2px; opacity: 0.8; margin-bottom: 10px; }
        .balance-card .amount { font-size: 3rem; font-weight: 800; font-family: 'Plus Jakarta Sans', sans-serif; }
        .balance-card .user-info { margin-top: 15px; font-size: 13px; opacity: 0.7; display: flex; align-items: center; gap: 6px; }

        /* --- INFO BAR --- */
        .info-bar {
            background: #fff;
            padding: 20px 30px;
            border-radius: 16px;
            border: 1.5px solid var(--g200);
            display: flex; align-items: center; gap: 15px;
            margin-bottom: 30px;
            box-shadow: var(--s2);
        }
        .info-bar i { font-size: 24px; color: var(--blue); }
        .info-bar p { font-size: 13px; color: var(--g600); line-height: 1.5; }

        /* --- TRANSACTIONS --- */
        .history-card {
            background: #fff;
            border-radius: 20px;
            border: 1.5px solid var(--g200);
            overflow: hidden;
            box-shadow: var(--s2);
        }

        .history-header { padding: 24px; border-bottom: 1px solid var(--g200); display: flex; justify-content: space-between; align-items: center; }
        .history-header h3 { font-size: 18px; color: var(--dark); }
        .badge { background: var(--bluelt); color: var(--blue); padding: 4px 12px; border-radius: 20px; font-size: 11px; font-weight: 800; }

        table { width: 100%; border-collapse: collapse; }
        th { background: var(--g50); padding: 16px; text-align: left; font-size: 12px; font-weight: 800; color: var(--g400); text-transform: uppercase; letter-spacing: 0.5px; }
        td { padding: 18px 16px; font-size: 14px; border-bottom: 1px solid var(--g100); }

        .txn-id { font-family: monospace; color: var(--g600); font-weight: 600; }
        .amount-val { font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif; }
        .desc-text { color: var(--g600); font-size: 13px; }

        .credit { color: var(--ok); }
        .debit { color: var(--red); }

        .status-pill {
            padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase;
        }
        .status-success { background: var(--oklt); color: var(--ok); }
        .status-failed { background: var(--redlt); color: var(--red); }

        /* footer */
        .ft{background:var(--dark);padding:44px 2.5% 22px; margin-top: 60px;}
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
        <div class="topbar-right">
            <a href="FreelancerHomeServlet" class="ghost-btn">
                <i class="bi bi-house-door"></i> Back to Home
            </a>
        </div>
    </nav>

    <div class="main-content">
        
        <div class="balance-card">
            <h2>Earnings Balance</h2>
            <div class="amount">$ <%= wallet.getBalance() %></div>
            <div class="user-info">
                <i class="bi bi-wallet2"></i> Freelancer Wallet ID: #<%= wallet.getUserId() %>
            </div>
        </div>

        <div class="info-bar">
            <i class="bi bi-info-circle-fill"></i>
            <p>Earnings are automatically credited to this wallet once a client releases payment for your completed milestones or projects. You can track all inflows and outflows below.</p>
        </div>

        <div class="history-card">
            <div class="history-header">
                <h3>Transaction History</h3>
                <span class="badge">Freelancer Account</span>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>Amount</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                if (transactions != null && !transactions.isEmpty()) {
                    for (Map<String, Object> txn : transactions) {
                        String type = txn.get("type").toString();
                        String status = txn.get("status").toString();
                        Object desc = txn.get("description");
                %>
                    <tr>
                        <td class="txn-id">#<%= txn.get("transaction_id") %></td>
                        <td class="amount-val <%= type.equals("CREDIT") ? "credit" : "debit" %>">
                            <%= type.equals("CREDIT") ? "+" : "-" %> $<%= txn.get("amount") %>
                        </td>
                        <td>
                            <span style="font-weight: 700; font-size: 12px; color: <%= type.equals("CREDIT") ? "var(--ok)" : "var(--red)" %>">
                                <%= type %>
                            </span>
                        </td>
                        <td class="desc-text"><%= desc != null ? desc : "No description provided" %></td>
                        <td>
                            <span class="status-pill <%= status.equals("SUCCESS") ? "status-success" : "status-failed" %>">
                                <%= status %>
                            </span>
                        </td>
                    </tr>
                <%
                    }
                } else {
                %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: var(--g400); padding: 50px;">
                            <i class="bi bi-journal-x" style="font-size: 2.5rem; display: block; margin-bottom: 10px;"></i>
                            No transaction history found yet.
                        </td>
                    </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>
        
        <div style="margin-top: 25px; text-align: left;">
            <a href="FreelancerHomeServlet" style="text-decoration: none; color: var(--blue); font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; gap: 5px;">
                <i class="bi bi-arrow-left"></i> Return to Dashboard
            </a>
        </div>

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
        <p>&copy; 2025 WorkPort Technologies. All rights reserved. | Made by Prem Vikas Yadav</p>
        <div class="fs"><a href="#"><i class="bi bi-twitter-x"></i></a><a href="#"><i class="bi bi-linkedin"></i></a><a href="#"><i class="bi bi-github"></i></a></div>
      </div>
    </footer>

</body>
</html>