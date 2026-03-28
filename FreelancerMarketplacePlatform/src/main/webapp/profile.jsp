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
    
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- intl-tel-input CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/css/intlTelInput.css">

    <style>
        :root {
            --blue: #2563eb;
            --blue2: #1d4ed8;
            --blue3: #3b82f6;
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
            --ok1: #d1fae5;
            --red: #ef4444;
            --redlt: #fef2f2;
            --red1: #fecaca;
            --rs: 12px;
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

        h1, h2, h3, h4 { font-family: 'Plus Jakarta Sans', sans-serif; }

        /* --- TOPBAR (Matches Post Job) --- */
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

        .topbar-right { margin-left: auto; display: flex; gap: 12px; }

        .ghost-btn {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 8px 16px;
            background: #fff; border: 1.5px solid var(--g200);
            border-radius: 8px; font-size: 13px; font-weight: 700;
            color: var(--g600); cursor: pointer; text-decoration: none;
            transition: all .18s;
        }
        .ghost-btn:hover { border-color: var(--blue); color: var(--blue); background: var(--bluelt); }
        .btn-logout { color: var(--red); border-color: var(--red1); }
        .btn-logout:hover { background: var(--redlt); border-color: var(--red); color: var(--red); }

        /* --- MAIN CONTAINER --- */
        .main-content {
            flex: 1;
            display: flex; justify-content: center;
            padding: 50px 5%;
        }

        .profile-card {
            background: #fff;
            border: 1.5px solid var(--g200);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 750px;
            box-shadow: var(--s2);
        }

        .header-section {
            text-align: center;
            margin-bottom: 35px;
        }

        .header-section h2 { font-size: 1.85rem; font-weight: 800; color: var(--dark); }
        .header-section p { color: var(--g400); font-size: 14px; margin-top: 5px; }

        /* --- READ ONLY INFO GRID --- */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 35px;
            padding: 24px;
            background: var(--g50);
            border: 1.5px solid var(--g200);
            border-radius: 16px;
        }

        .info-item label {
            display: block;
            font-size: 11px;
            font-weight: 800;
            color: var(--g400);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .info-item span {
            font-size: 15px;
            font-weight: 600;
            color: var(--g800);
        }

        /* --- FORM STYLING --- */
        .form-group { margin-bottom: 24px; }
        
        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: var(--g600);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--g200);
            border-radius: 10px;
            font-size: 14px;
            font-family: 'DM Sans', sans-serif;
            color: var(--g800);
            transition: all 0.2s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--blue);
            box-shadow: 0 0 0 4px rgba(37,99,235,.1);
        }

        textarea.form-control { min-height: 120px; resize: vertical; line-height: 1.6; }

        /* --- intl-tel-input overrides to match existing form style --- */
        .iti {
            width: 100%;
        }

        .iti__tel-input {
            width: 100%;
            padding: 12px 16px 12px 52px !important;
            border: 2px solid var(--g200) !important;
            border-radius: 10px !important;
            font-size: 14px !important;
            font-family: 'DM Sans', sans-serif !important;
            color: var(--g800) !important;
            transition: all 0.2s !important;
            background: #fff !important;
            height: auto !important;
        }

        .iti__tel-input:focus {
            outline: none !important;
            border-color: var(--blue) !important;
            box-shadow: 0 0 0 4px rgba(37,99,235,.1) !important;
        }

        .iti__flag-container {
            padding: 0 !important;
        }

        .iti__selected-dial-code {
            font-size: 13px;
            font-family: 'DM Sans', sans-serif;
            color: var(--g600);
        }

        .iti__country-list {
            border-radius: 10px;
            border: 1.5px solid var(--g200);
            box-shadow: var(--s2);
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            z-index: 1001;
        }

        .iti__country-list .iti__country.iti__highlight {
            background: var(--bluelt);
        }

        /* --- BUTTON --- */
        .btn-update {
            width: 100%;
            padding: 14px;
            background: var(--blue);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-weight: 800;
            font-size: 15px;
            cursor: pointer;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3);
            transition: all 0.2s;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }

        .btn-update:hover {
            background: var(--blue2);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37, 99, 235, 0.4);
        }

        /* --- COMPLETION BAR --- */
        .progress-container {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid var(--g200);
        }

        .progress-label-flex {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 10px;
        }

        .progress-label-flex span { font-size: 13px; font-weight: 700; color: var(--g600); }
        
        .progress-bar-bg {
            height: 8px; background: var(--g200); border-radius: 10px; overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            background: <%= profileComplete ? "var(--ok)" : "var(--blue)" %>;
            width: <%= completed %>%;
            transition: width 0.5s ease-in-out;
        }

        .status-msg {
            margin-top: 12px;
            font-size: 12px;
            font-weight: 600;
            display: flex; align-items: center; gap: 5px;
            color: <%= profileComplete ? "var(--ok)" : "var(--red)" %>;
        }

        /* footer */
.ft{background:var(--dark);padding:44px 2.5% 22px;}
.fg{display:grid;grid-template-columns:2fr 1fr 1fr;gap:40px;margin-bottom:30px;}
.fb{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.35rem;font-weight:800;margin-bottom:8px;display:flex;align-items:center;gap:7px;}
.fb .w{color:#fff;}.fb .p{color:#60a5fa;}
.ftag{font-size:13px;color:#ffffff;line-height:1.7;max-width:250px;}
.fct{font-size:10px;font-weight:800;color:#ffffff;text-transform:uppercase;letter-spacing:1px;margin-bottom:12px;}
.fl a{display:block;color:#ffffff;font-size:13px;margin-bottom:8px;transition:color .18s,padding .18s;}
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
        <a href="ClientHomeServlet" class="logo">
            <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;">
                <rect width="34" height="34" rx="9" fill="#2563eb"/>
                <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
                <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
                <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
        </a>
        <div class="topbar-right">
            <a href="ClientHomeServlet" class="ghost-btn"><i class="bi bi-house-door"></i>Home</a>
            <a href="LogoutServlet" class="ghost-btn btn-logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="profile-card">
            <div class="header-section">
                <h2>Account Profile</h2>
                <p>Manage your company details and contact information</p>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <label>Full Name</label>
                    <span><%= profile.getName() %></span>
                </div>
                <div class="info-item">
                    <label>Account Role</label>
                    <span><%= profile.getRole() %></span>
                </div>
                <div class="info-item" style="grid-column: span 2; margin-top: 10px;">
                    <label>Email Address</label>
                    <span><%= profile.getEmail() %></span>
                </div>
            </div>

            <form action="ClientProfileServlet" method="post" id="profileForm">
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <!-- Hidden input that stores the full international number submitted to the server -->
                    <input type="hidden" name="phone" id="phoneHidden">
                    <!-- intl-tel-input is attached to this input; its value is NOT submitted directly -->
                    <input type="tel" id="phoneInput" class="form-control"
                           placeholder="+1 (555) 000-0000"
                           value="<%= profile.getPhone()==null?"":profile.getPhone() %>">
                </div>

                <div class="form-group">
                    <label class="form-label">Company Name</label>
                    <input type="text" class="form-control" name="companyname" placeholder="e.g. Acme Tech Solutions"
                           value="<%= profile.getCompanyname()==null?"":profile.getCompanyname() %>">
                </div>

                <div class="form-group">
                    <label class="form-label">Company Biography</label>
                    <textarea class="form-control" name="companybio" placeholder="Tell freelancers about your company culture and the kind of work you do..."><%= profile.getCompanybio()==null?"":profile.getCompanybio() %></textarea>
                </div>

                <button type="submit" class="btn-update">
                    <i class="bi bi-check2-circle"></i> Save Changes
                </button>
            </form>

            <div class="progress-container">
                <div class="progress-label-flex">
                    <span>Profile Completion</span>
                    <span><%= completed %>%</span>
                </div>
                <div class="progress-bar-bg">
                    <div class="progress-bar-fill"></div>
                </div>
                
                <% if (!profileComplete) { %>
                    <div class="status-msg">
                        <i class="bi bi-exclamation-circle"></i>
                        Please complete all fields to unlock job posting.
                    </div>
                <% } else { %>
                    <div class="status-msg">
                        <i class="bi bi-patch-check-fill"></i>
                        Your profile is fully verified and ready.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

   <!-- FOOTER -->
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

    <!-- intl-tel-input JS -->
    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/intlTelInput.min.js"></script>
    <script>
        const phoneInput = document.querySelector("#phoneInput");
        const phoneHidden = document.querySelector("#phoneHidden");

        const iti = window.intlTelInput(phoneInput, {
            initialCountry: "auto",
            geoIpLookup: function(callback) {
                fetch("https://ipapi.co/json")
                    .then(res => res.json())
                    .then(data => callback(data.country_code))
                    .catch(() => callback("us"));
            },
            loadUtilsOnInit: "https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/utils.js",
        });

        // Before form submits, copy the full international number into the hidden input
        document.querySelector("#profileForm").addEventListener("submit", function () {
            phoneHidden.value = iti.getNumber();
        });
    </script>

</body>
</html>
