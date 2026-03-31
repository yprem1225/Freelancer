<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String role = request.getParameter("type");
    if (role == null || role.trim().isEmpty()) {
        role = "client";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login | WorkPort</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --blue:      #1a6bff;
            --blue-dk:   #1254cc;
            --blue-lt:   #e8f0ff;
            --navy:      #0b1d3a;
            --navy2:     #0d2347;
            --sky:       #38bdf8;
            --teal:      #06b6d4;
            --white:     #ffffff;
            --offwhite:  #f5f8ff;
            --muted:     #8097b5;
            --border:    rgba(255,255,255,0.10);
            --border-lt: #d6e2f7;
            --err:       #f43f5e;
            --gold:      #fbbf24;
            --card-bg:   rgba(255,255,255,0.05);
            --grad:      linear-gradient(135deg, var(--blue) 0%, var(--teal) 100%);
        }

        html, body { height: 100%; overflow: hidden; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--navy);
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        /* ── SCENE (Left Panel Decor) ── */
        .scene { position:absolute;inset:0;pointer-events:none;overflow:hidden; }
        .grid-lines {
            position:absolute;inset:0;
            background-image:
                linear-gradient(rgba(26,107,255,0.06) 1px, transparent 1px),
                linear-gradient(90deg, rgba(26,107,255,0.06) 1px, transparent 1px);
            background-size:48px 48px;
        }
        .orb { position:absolute;border-radius:50%;filter:blur(88px);pointer-events:none; }
        .o1 { width:420px;height:420px;top:-130px;left:-80px; background:rgba(26,107,255,0.22); animation:pulse 9s ease-in-out infinite; }
        .o2 { width:280px;height:280px;bottom:-80px;left:240px; background:rgba(6,182,212,0.16); animation:pulse 11s 2s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{transform:scale(1);opacity:.85;} 50%{transform:scale(1.1);opacity:1;} }

        .wrapper { display: flex; width: 100%; min-height: 100vh; overflow: hidden; }

        /* ═══════════════════════════════════════
           LEFT PANEL — 40% (Content)
        ═══════════════════════════════════════ */
        .left {
            flex: 0 0 40%;
            width: 40%;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 48px 44px;
            background: var(--navy);
            overflow: hidden;
        }

        .logo { display: flex; align-items: center; gap: 8px; margin-bottom: 48px; animation: up .65s ease both; text-decoration: none; }
        .logo-svg { width: 34px; height: 34px; flex-shrink: 0; display: block; }
        .logo-txt { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.35rem; font-weight: 800; letter-spacing: -.3px; }
        .logo-txt .w { color: var(--white); }
        .logo-txt .p { color: #60a5fa; }

        .headline {
            font-family:'Syne',sans-serif; font-size:clamp(30px,3vw,48px);
            font-weight:800;line-height:1.1;letter-spacing:-1.5px;
            color:var(--white);margin-bottom:14px; animation:up .65s .08s ease both;
        }
        .headline .acc { background:linear-gradient(90deg,#38bdf8,#1a6bff); -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text; }
        .subline { font-size:13.5px;color:var(--muted);line-height:1.7; max-width:340px;margin-bottom:36px; animation:up .65s .15s ease both; }

        .cards { display:flex;flex-direction:column;gap:10px;margin-bottom:40px;animation:up .65s .22s ease both; }
        .card {
            display:flex;align-items:center;gap:14px; padding:13px 17px;
            background:var(--card-bg);border:1px solid var(--border);
            border-radius:14px;backdrop-filter:blur(8px);
            transition:background .2s,transform .2s;cursor:default;
        }
        .card:hover { background:rgba(255,255,255,0.08);transform:translateX(5px); }
        .cico { width:38px;height:38px;border-radius:10px;flex-shrink:0; display:flex;align-items:center;justify-content:center;font-size:16px; }
        .cb { background:rgba(26,107,255,0.18);color:#60a5fa; }
        .cg { background:rgba(251,191,36,0.15);color:var(--gold); }
        .ctxt strong { display:block;color:var(--white);font-size:13px;font-weight:600;margin-bottom:2px; }
        .ctxt span { color:var(--muted);font-size:11.5px; }

        .proof { display:flex;align-items:center;gap:14px;animation:up .65s .3s ease both; }
        .avs { display:flex; }
        .av { width:32px;height:32px;border-radius:50%; border:2.5px solid var(--navy); margin-left:-8px; background:linear-gradient(135deg,#1a6bff,#06b6d4); display:flex;align-items:center;justify-content:center; font-size:10px;font-weight:700;color:white; }
        .av:first-child{margin-left:0;}
        .pc strong{display:block;color:var(--white);font-size:12.5px;font-weight:600;}
        .stars{color:var(--gold);font-size:11px;letter-spacing:1px;}

        @keyframes up { from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);} }

        /* ═══════════════════════════════════════
           RIGHT PANEL — 60% (Form)
        ═══════════════════════════════════════ */
        .right {
            flex: 0 0 60%;
            width: 60%;
            background: var(--white);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 32px 24px;
            position: relative;
            z-index: 2;
            overflow-y: auto;
            box-shadow: -20px 0 60px rgba(0,0,0,0.35);
            animation: fromR .55s .1s ease both;
        }
        @keyframes fromR { from{opacity:0;transform:translateX(24px);}to{opacity:1;transform:translateX(0);} }

        .form-inner { width: 100%; max-width: 400px; }

        .rbadge { display: inline-flex; align-items: center; gap:6px; background: var(--blue-lt); color: var(--blue-dk); font-size:11px; font-weight:700; text-transform:uppercase; letter-spacing:.7px; padding:4px 12px; border-radius:20px; border:1px solid rgba(26,107,255,0.25); margin-bottom:14px; }
        .ftitle { font-family:'Syne', sans-serif; font-weight:800; font-size:24px; letter-spacing:-.7px; color:var(--navy); margin-bottom:3px; }
        .fsub { color:var(--muted); font-size:12.5px; margin-bottom:20px; }

        .aerr { background:#fff1f3; border:1px solid #fecdd3; border-left:3px solid var(--err); color:#be123c; padding:9px 13px; border-radius:9px; font-size:12px; margin-bottom:13px; display:flex; align-items:center; gap:7px; animation: up .3s ease; }
        .soc { display:flex; gap:8px; margin-bottom:14px; }
        .sbtn { flex:1; display:flex; align-items:center; justify-content:center; gap:7px; padding:10px; border:1.5px solid var(--border-lt); border-radius:10px; background:white; font-family:inherit; font-size:12.5px; font-weight:500; color:#334155; cursor:pointer; text-decoration:none; transition:border-color .2s, box-shadow .15s, transform .15s; }
        .sbtn:hover { border-color:#a0bcf0; box-shadow:0 2px 10px rgba(26,107,255,0.12); transform:translateY(-1px); }
        .sbtn .fa-google   { color:#ea4335; font-size:13px; }

        .divr { display:flex; align-items:center; gap:9px; margin-bottom:14px; }
        .divr::before,.divr::after { content:'';flex:1;height:1px;background:var(--border-lt); }
        .divr span { font-size:10.5px; color:var(--muted); white-space:nowrap; }

        .fld { margin-bottom:12px; }
        .fld label { display:block; font-size:11.5px; font-weight:600; color:#2c4270; margin-bottom:5px; }
        .iw { position:relative; }
        .iw .ico { position:absolute; left:12px; top:50%; transform:translateY(-50%); color:#b0c4e0; font-size:13px; pointer-events:none; }
        .iw input { width:100%; padding:11px 38px 11px 36px; border:1.5px solid var(--border-lt); border-radius:10px; font-family:inherit; font-size:13.5px; color:var(--navy); background:var(--offwhite); outline:none; transition:border-color .2s, box-shadow .2s; }
        .iw input:focus { border-color:var(--blue); background:#fff; box-shadow:0 0 0 3px rgba(26,107,255,0.12); }
        .tpw { position:absolute; right:12px; top:50%; transform:translateY(-50%); background:none; border:none; cursor:pointer; color:#b0c4e0; font-size:13px; padding:0; }

        .frow { text-align:right; margin-top:-6px; margin-bottom:14px; }
        .frow a { font-size:11px; color:var(--blue); text-decoration:none; font-weight:600; }
        .bsub { width:100%; padding:13px; background: var(--grad); color:white; border:none; border-radius:11px; font-family:'Syne', sans-serif; font-size:15px; font-weight:700; letter-spacing:.2px; cursor:pointer; box-shadow:0 4px 20px rgba(26,107,255,0.35); transition:all .2s; display:flex; align-items:center; justify-content:center; gap:8px; }
        .bsub:hover { filter:brightness(1.08); transform:translateY(-1px); box-shadow:0 8px 28px rgba(26,107,255,0.4); }

        .ffoot { text-align:center; margin-top:16px; font-size:12px; color:var(--muted); }
        .ffoot a { color:var(--blue); font-weight:600; text-decoration:none; }
        .swrole { margin-top:12px; padding:10px 14px; background:var(--offwhite); border:1.5px solid var(--border-lt); border-radius:10px; text-align:center; font-size:11.5px; color:var(--muted); }
        .swrole a { color:var(--blue); font-weight:600; text-decoration:none; }

        @media (max-width: 780px) {
            html, body { overflow: auto; }
            .left  { display: none; }
            .right { flex: 0 0 100%; width: 100%; padding: 28px 18px; }
        }
    </style>
</head>
<body>
<div class="wrapper">

    <div class="left">
        <div class="scene">
            <div class="grid-lines"></div>
            <div class="orb o1"></div>
            <div class="orb o2"></div>
            <div class="orb o3"></div>
        </div>

        <a href="home.jsp" class="logo">
            <svg class="logo-svg" viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg">
                <rect width="34" height="34" rx="9" fill="#2563eb"/>
                <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
                <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
            </svg>
            <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
        </a>

        <h1 class="headline">Start Your<br><span class="acc">Career</span> Today</h1>
        <p class="subline">Join thousands of vetted experts and companies on the smartest freelance network.</p>

        <div class="cards">
            <div class="card">
                <div class="cico cb"><i class="fa-solid fa-coins"></i></div>
                <div class="ctxt">
                    <strong>Earn on Your Terms</strong>
                    <span>Pick your clients and work remotely</span>
                </div>
            </div>
            <div class="card">
                <div class="cico cg"><i class="fa-solid fa-shield-halved"></i></div>
                <div class="ctxt">
                    <strong>Secure Payments</strong>
                    <span>Escrow protection for every milestone</span>
                </div>
            </div>
        </div>

        <div class="proof">
            <div class="avs">
                <div class="av">AR</div><div class="av">JK</div><div class="av">MS</div><div class="av">+</div>
            </div>
            <div class="pc">
                <strong>Trusted by 10,000+ users</strong>
                <span><span class="stars">★★★★★</span>&nbsp; 4.9 / 5</span>
            </div>
        </div>
    </div>

    <div class="right">
        <div class="form-inner">
            <div class="rbadge">
                <i class="fa-solid <%= role.equals("freelancer") ? "fa-briefcase" : "fa-building" %>"></i>
                <%= role.equals("freelancer") ? "Freelancer" : "Client" %>
            </div>

            <h2 class="ftitle">Welcome back</h2>
            <p class="fsub">Sign in to continue to your dashboard.</p>

            <% String error = (String) request.getAttribute("error");
               if (error != null) { %>
                <div class="aerr"><i class="fa-solid fa-triangle-exclamation"></i> <%= error %></div>
            <% } %>

            <div class="soc">
                <a href="#" class="sbtn"><i class="fa-brands fa-google"></i> Google</a>
                <a href="#" class="sbtn"><i class="fa-brands fa-linkedin"></i> LinkedIn</a>
            </div>
            <div class="divr"><span>or use email</span></div>

            <form action="LoginServlet" method="post" novalidate>
                <input type="hidden" name="role" value="<%= role %>">
                <div class="fld">
                    <label>Email address</label>
                    <div class="iw">
                        <i class="fa-regular fa-envelope ico"></i>
                        <input type="email" name="email" placeholder="you@example.com" required>
                    </div>
                </div>
                <div class="fld">
                    <label>Password</label>
                    <div class="iw">
                        <i class="fa-solid fa-lock ico"></i>
                        <input type="password" id="lpw" name="password" placeholder="••••••••" required>
                        <button type="button" class="tpw" onclick="tpw('lpw',this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="frow"><a href="#">Forgot password?</a></div>
                <button type="submit" class="bsub"><i class="fa-solid fa-right-to-bracket"></i> Sign In</button>
            </form>

            <div class="ffoot">New here? <a href="signup.jsp?type=<%= role %>">Create free account →</a></div>
            <div class="swrole">
                <%= role.equals("freelancer") ? "Looking to hire?" : "Want to freelance?" %>
                <a href="login.jsp?type=<%= role.equals("freelancer") ? "client" : "freelancer" %>">Switch to <%= role.equals("freelancer") ? "Client" : "Freelancer" %> login</a>
            </div>
        </div>
    </div>
</div>

<script>
function tpw(id, btn) {
    const f = document.getElementById(id);
    const i = btn.querySelector('i');
    f.type = f.type === 'password' ? 'text' : 'password';
    i.classList.toggle('fa-eye');
    i.classList.toggle('fa-eye-slash');
}
</script>
</body>
</html>