<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = request.getParameter("type");
    if (role == null || role.trim().isEmpty()) {
        role = "freelancer";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Sign Up | WorkoHub</title>
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

        html, body {
            height: 100%;
            overflow: hidden;
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--navy);
            display: flex;
            min-height: 100vh;
            margin: 0;
        }

        /* ── SCENE ── */
        .scene { position:absolute;inset:0;pointer-events:none;overflow:hidden; }
        .grid-lines {
            position:absolute;inset:0;
            background-image:
                linear-gradient(rgba(26,107,255,0.06) 1px, transparent 1px),
                linear-gradient(90deg, rgba(26,107,255,0.06) 1px, transparent 1px);
            background-size:48px 48px;
        }
        .orb { position:absolute;border-radius:50%;filter:blur(88px);pointer-events:none; }
        .o1 { width:420px;height:420px;top:-130px;left:-80px;
              background:rgba(26,107,255,0.22);animation:pulse 9s ease-in-out infinite; }
        .o2 { width:280px;height:280px;bottom:-80px;left:240px;
              background:rgba(6,182,212,0.16);animation:pulse 11s 2s ease-in-out infinite; }
        .o3 { width:180px;height:180px;top:42%;left:50%;
              background:rgba(56,189,248,0.10);animation:pulse 7s 1s ease-in-out infinite; }
        @keyframes pulse { 0%,100%{transform:scale(1);opacity:.85;} 50%{transform:scale(1.1);opacity:1;} }

        /* ── WRAPPER ── */
        .wrapper {
            display: flex;
            width: 100%;
            min-height: 100vh;
            overflow: hidden;
        }

        /* ═══════════════════════════════════════
           LEFT PANEL — 40%
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

        /* Logo — matches navbar CSS style */
        .logo {
            display: flex; align-items: center; gap: 8px;
            margin-bottom: 48px;
            animation: up .65s ease both;
            text-decoration: none;
        }
        .logo-svg {
            width: 34px; height: 34px; flex-shrink: 0; display: block;
        }
        .logo-txt {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 1.35rem; font-weight: 800; letter-spacing: -.3px;
            line-height: 1;
        }
        .logo-txt .w { color: var(--white); }
        .logo-txt .p { color: #60a5fa; }
        .headline {
            font-family:'Syne',sans-serif;
            font-size:clamp(32px,3.5vw,52px);
            font-weight:800;line-height:1.09;letter-spacing:-2px;
            color:var(--white);margin-bottom:14px;
            animation:up .65s .08s ease both;
        }
        .headline .acc {
            background:linear-gradient(90deg,#38bdf8,#1a6bff);
            -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;
        }

        .subline {
            font-size:14px;color:var(--muted);line-height:1.7;
            max-width:380px;margin-bottom:36px;
            animation:up .65s .15s ease both;
        }

        /* Feature cards */
        .cards { display:flex;flex-direction:column;gap:10px;margin-bottom:40px;animation:up .65s .22s ease both; }
        .card {
            display:flex;align-items:center;gap:14px;
            padding:13px 17px;
            background:var(--card-bg);border:1px solid var(--border);
            border-radius:14px;backdrop-filter:blur(8px);
            transition:background .2s,transform .2s;cursor:default;
        }
        .card:hover { background:rgba(255,255,255,0.08);transform:translateX(5px); }
        .cico {
            width:38px;height:38px;border-radius:10px;flex-shrink:0;
            display:flex;align-items:center;justify-content:center;font-size:16px;
        }
        .cb{background:rgba(26,107,255,0.18);color:#60a5fa;}
        .ct{background:rgba(6,182,212,0.18);color:#22d3ee;}
        .cg{background:rgba(251,191,36,0.15);color:var(--gold);}
        .ctxt strong{display:block;color:var(--white);font-size:13px;font-weight:600;margin-bottom:2px;}
        .ctxt span{color:var(--muted);font-size:11.5px;}

        /* Proof */
        .proof { display:flex;align-items:center;gap:14px;animation:up .65s .3s ease both; }
        .avs { display:flex; }
        .av {
            width:32px;height:32px;border-radius:50%;
            border:2.5px solid var(--navy);
            margin-left:-8px;
            background:linear-gradient(135deg,#1a6bff,#06b6d4);
            display:flex;align-items:center;justify-content:center;
            font-size:10px;font-weight:700;color:white;
        }
        .av:first-child{margin-left:0;}
        .pc strong{display:block;color:var(--white);font-size:13px;font-weight:600;}
        .pc span{color:var(--muted);font-size:11px;}
        .stars{color:var(--gold);font-size:11px;letter-spacing:1px;}

        /* Testimonial */
        .testi {
            margin-top:20px; padding:16px 18px;
            background:var(--card-bg);border:1px solid var(--border);border-radius:14px;
            animation:up .65s .36s ease both;
        }
        .testi p { color:rgba(255,255,255,0.65);font-size:12.5px;line-height:1.6;font-style:italic;margin-bottom:10px; }
        .ta { display:flex;align-items:center;gap:9px; }
        .ta-av {
            width:26px;height:26px;border-radius:50%;
            background:linear-gradient(135deg,#1a6bff,#38bdf8);
            display:flex;align-items:center;justify-content:center;
            font-size:10px;font-weight:700;color:white;
        }
        .ta-name strong{display:block;color:var(--white);font-size:12px;font-weight:600;}
        .ta-name span{color:var(--muted);font-size:11px;}

        @keyframes up { from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);} }

        /* ═══════════════════════════════════════
           RIGHT PANEL — 60%, starts at 40% mark
        ═══════════════════════════════════════ */
        .right {
            flex: 0 0 60%;
            width: 60%;
            background: var(--white);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;           /* centres form block horizontally */
            padding: 32px 24px;
            position: relative;
            z-index: 2;
            overflow-y: auto;
            box-shadow: -20px 0 60px rgba(0,0,0,0.35);
            animation: fromR .55s .1s ease both;
        }
        @keyframes fromR { from{opacity:0;transform:translateX(24px);}to{opacity:1;transform:translateX(0);} }

        /* Inner form container — constrained + centered */
        .form-inner {
            width: 100%;
            max-width: 400px;
        }

        /* Progress steps */
        .steps { display:flex;align-items:flex-start;margin-bottom:20px; }
        .step { display:flex;flex-direction:column;align-items:center;gap:4px;flex:1;position:relative; }
        .step::after {
            content:'';position:absolute;
            top:12px;left:calc(50% + 13px);
            width:calc(100% - 26px);height:2px;
            background:var(--border-lt);transition:background .4s;
        }
        .step:last-child::after { display:none; }
        .step.done::after { background:var(--blue); }
        .step-c {
            width:24px;height:24px;border-radius:50%;z-index:1;
            background:var(--offwhite);border:2px solid var(--border-lt);
            display:flex;align-items:center;justify-content:center;
            font-size:10px;font-weight:700;color:var(--muted);
            transition:all .3s;
        }
        .step.active .step-c { background:var(--blue);border-color:var(--blue);color:white;box-shadow:0 0 0 4px rgba(26,107,255,0.18); }
        .step.done .step-c   { background:var(--blue);border-color:var(--blue);color:white; }
        .step-l { font-size:10px;color:var(--muted);font-weight:500;white-space:nowrap; }
        .step.active .step-l { color:var(--blue-dk);font-weight:700; }
        .step.done .step-l   { color:var(--blue-dk); }

        /* Role toggle */
        .rtoggle { display:flex;background:#f0f5ff;border-radius:10px;padding:3px;margin-bottom:15px; }
        .rtoggle a {
            flex:1;text-align:center;padding:8px;border-radius:8px;
            font-size:12.5px;font-weight:500;color:var(--muted);
            text-decoration:none;transition:all .2s;
        }
        .rtoggle a.active {
            background:white;color:var(--blue-dk);
            box-shadow:0 1px 6px rgba(26,107,255,0.15);font-weight:700;
        }
        .rtoggle a:hover:not(.active) { color:#334155; }

        .ftitle { font-family:'Syne',sans-serif;font-weight:800;font-size:22px;letter-spacing:-.6px;color:var(--navy);margin-bottom:2px; }
        .fsub   { color:var(--muted);font-size:12px;margin-bottom:16px; }

        /* Error */
        .aerr {
            background:#fff1f3;border:1px solid #fecdd3;border-left:3px solid var(--err);
            color:#be123c;padding:9px 12px;border-radius:9px;
            font-size:12px;margin-bottom:12px;
            display:flex;align-items:center;gap:7px;animation:up .3s ease;
        }

        /* Social */
        .soc { display:flex;gap:8px;margin-bottom:13px; }
        .sbtn {
            flex:1;display:flex;align-items:center;justify-content:center;gap:7px;
            padding:10px;border:1.5px solid var(--border-lt);border-radius:10px;
            background:white;font-family:inherit;
            font-size:12.5px;font-weight:500;color:#334155;
            cursor:pointer;text-decoration:none;
            transition:border-color .2s,box-shadow .15s,transform .15s;
        }
        .sbtn:hover { border-color:#a0bcf0;box-shadow:0 2px 10px rgba(26,107,255,0.12);transform:translateY(-1px); }
        .sbtn .fa-google   { color:#ea4335;font-size:13px; }
        .sbtn .fa-linkedin { color:#0a66c2;font-size:13px; }

        /* Divider */
        .divr { display:flex;align-items:center;gap:9px;margin-bottom:13px; }
        .divr::before,.divr::after { content:'';flex:1;height:1px;background:var(--border-lt); }
        .divr span { font-size:10.5px;color:var(--muted);white-space:nowrap; }

        /* Fields */
        .fld { margin-bottom:11px; }
        .fld label { display:block;font-size:11.5px;font-weight:600;color:#2c4270;margin-bottom:4px; }
        .iw { position:relative; }
        .iw .ico {
            position:absolute;left:12px;top:50%;transform:translateY(-50%);
            color:#b0c4e0;font-size:13px;pointer-events:none;transition:color .2s;
        }
        .iw input {
            width:100%;padding:10px 36px 10px 34px;
            border:1.5px solid var(--border-lt);border-radius:10px;
            font-family:inherit;font-size:13px;color:var(--navy);
            background:var(--offwhite);outline:none;
            transition:border-color .2s,box-shadow .2s,background .2s;
        }
        .iw input::placeholder { color:#b8cde8; }
        .iw input:focus { border-color:var(--blue);background:#fff;box-shadow:0 0 0 3px rgba(26,107,255,0.12); }
        .iw:focus-within .ico { color:var(--blue); }
        .tpw {
            position:absolute;right:11px;top:50%;transform:translateY(-50%);
            background:none;border:none;cursor:pointer;
            color:#b0c4e0;font-size:13px;padding:0;transition:color .2s;
        }
        .tpw:hover { color:var(--blue); }

        /* Password strength */
        .sbar { display:flex;gap:3px;margin-top:6px; }
        .sbar span { flex:1;height:3px;border-radius:2px;background:var(--border-lt);transition:background .3s; }
        .slabel { font-size:10.5px;color:var(--muted);margin-top:4px;transition:color .3s; }

        /* Submit */
        .bsub {
            width:100%;padding:12px;
            background:var(--grad);
            color:white;border:none;border-radius:11px;
            font-family:'Syne',sans-serif;font-size:15px;font-weight:700;
            letter-spacing:.2px;cursor:pointer;
            box-shadow:0 4px 20px rgba(26,107,255,0.35);
            transition:filter .2s,transform .15s,box-shadow .2s;
            display:flex;align-items:center;justify-content:center;gap:8px;
            margin-top:4px;
        }
        .bsub:hover { filter:brightness(1.08);transform:translateY(-1px);box-shadow:0 8px 28px rgba(26,107,255,0.4); }
        .bsub:active { transform:translateY(0); }

        .terms { font-size:10.5px;color:var(--muted);text-align:center;margin-top:10px;line-height:1.5; }
        .terms a { color:var(--blue);text-decoration:none; }

        .ffoot { text-align:center;margin-top:13px;font-size:12px;color:var(--muted); }
        .ffoot a { color:var(--blue);font-weight:600;text-decoration:none; }
        .ffoot a:hover { text-decoration:underline; }

        /* ── RESPONSIVE ── */
        @media (max-width: 780px) {
            html, body { overflow: auto; }
            .left  { display: none; }
            .right {
                flex: 0 0 100%;
                width: 100%;
                padding: 28px 18px;
            }
        }
    </style>
</head>
<body>
<div class="wrapper">

    <!-- ══ LEFT PANEL (60%) ════════════════════════════ -->
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
                <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
                <line x1="23" y1="24" x2="31" y2="24" stroke="rgba(255,255,255,.4)" stroke-width="1.8" stroke-linecap="round"/>
            </svg>
            <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
        </a>

        <h1 class="headline">
            Start Your<br>
            <span class="acc">Freelancing</span><br>
            Journey Today
        </h1>

        <p class="subline">
            Whether you're building a career or scaling a business — WorkPort connects you to what matters, fast.
        </p>

        <div class="cards">
            <div class="card">
                <div class="cico cb"><i class="fa-solid fa-coins"></i></div>
                <div class="ctxt">
                    <strong>Earn on Your Terms</strong>
                    <span>Set your rate, pick your clients, work from anywhere</span>
                </div>
            </div>
            <div class="card">
                <div class="cico ct"><i class="fa-solid fa-magnifying-glass-chart"></i></div>
                <div class="ctxt">
                    <strong>Hire Expert Talent</strong>
                    <span>50,000+ vetted pros across 300+ in-demand skills</span>
                </div>
            </div>
            <div class="card">
                <div class="cico cg"><i class="fa-solid fa-shield-halved"></i></div>
                <div class="ctxt">
                    <strong>Payments Always Secured</strong>
                    <span>Escrow protection, milestone billing &amp; instant payouts</span>
                </div>
            </div>
        </div>

        <div class="proof">
            <div class="avs">
                <div class="av">AR</div>
                <div class="av">JK</div>
                <div class="av">MS</div>
                <div class="av">+</div>
            </div>
            <div class="pc">
                <strong>Trusted by 10,000+ users worldwide</strong>
                <span><span class="stars">★★★★★</span>&nbsp; 4.9 / 5 from 2,400+ reviews</span>
            </div>
        </div>

        <div class="testi">
            <p>"I landed my first ₹2.4L project within two weeks of joining. WorkoHub is genuinely different."</p>
            <div class="ta">
                <div class="ta-av">PK</div>
                <div class="ta-name">
                    <strong>Priya K.</strong>
                    <span>UI Designer · Mumbai</span>
                </div>
            </div>
        </div>
    </div>

    <!-- ══ RIGHT PANEL (40%) — starts exactly at 60% mark ══ -->
    <div class="right">
        <div class="form-inner">

            <!-- 3-step progress -->
            <div class="steps">
                <div class="step active" id="s1">
                    <div class="step-c">1</div>
                    <div class="step-l">Account</div>
                </div>
                <div class="step" id="s2">
                    <div class="step-c">2</div>
                    <div class="step-l">Profile</div>
                </div>
                <div class="step" id="s3">
                    <div class="step-c"><i class="fa-solid fa-check" style="font-size:9px;"></i></div>
                    <div class="step-l">Done</div>
                </div>
            </div>

            <!-- Role toggle -->
            <div class="rtoggle">
                <a href="signup.jsp?type=freelancer" class="<%= role.equals("freelancer") ? "active" : "" %>">
                    <i class="fa-solid fa-briefcase" style="margin-right:5px;font-size:11px;"></i> Freelancer
                </a>
                <a href="signup.jsp?type=client" class="<%= role.equals("client") ? "active" : "" %>">
                    <i class="fa-solid fa-building" style="margin-right:5px;font-size:11px;"></i> Client
                </a>
            </div>

            <h2 class="ftitle">Create account</h2>
            <p class="fsub">Join thousands of <%= role.equals("freelancer") ? "top freelancers" : "growing businesses" %> — it's free.</p>

            <% String error = (String) request.getAttribute("error");
               if (error != null) { %>
                <div class="aerr"><i class="fa-solid fa-triangle-exclamation"></i> <%= error %></div>
            <% } %>

            <!-- Social -->
            <div class="soc">
                <a href="#" class="sbtn"><i class="fa-brands fa-google"></i> Google</a>
                <a href="#" class="sbtn"><i class="fa-brands fa-linkedin"></i> LinkedIn</a>
            </div>
            <div class="divr"><span>or sign up with email</span></div>

            <!-- SIGNUP FORM — original logic untouched -->
            <form action="SignupServlet" method="post" novalidate id="sform">
                <input type="hidden" name="role" value="<%= role %>">

                <div class="fld">
                    <label>Full Name</label>
                    <div class="iw">
                        <i class="fa-regular fa-user ico"></i>
                        <input type="text" name="name" placeholder="Jane Doe" required>
                    </div>
                </div>

                <div class="fld">
                    <label>Email Address</label>
                    <div class="iw">
                        <i class="fa-regular fa-envelope ico"></i>
                        <input type="email" name="email" placeholder="jane@example.com" required>
                    </div>
                </div>

                <div class="fld">
                    <label>Password</label>
                    <div class="iw">
                        <i class="fa-solid fa-lock ico"></i>
                        <input type="password" id="spw" name="password" placeholder="Min. 8 characters" required oninput="chkStr(this.value)">
                        <button type="button" class="tpw" onclick="tpw('spw',this)">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>
                    <div class="sbar" id="sbar">
                        <span></span><span></span><span></span><span></span>
                    </div>
                    <div class="slabel" id="slabel">Enter a password</div>
                </div>

                <button type="submit" class="bsub">
                    <i class="fa-solid fa-user-plus"></i> Create Free Account
                </button>
            </form>

            <p class="terms">
                By signing up you agree to our <a href="#">Terms</a> and <a href="#">Privacy Policy</a>.
            </p>

            <div class="ffoot">
                Already have an account? <a href="login.jsp?type=<%= role %>">Sign in →</a>
            </div>

        </div><!-- /form-inner -->
    </div><!-- /right -->
</div><!-- /wrapper -->

<script>
function tpw(id, btn) {
    const f = document.getElementById(id);
    const i = btn.querySelector('i');
    f.type = f.type === 'password' ? 'text' : 'password';
    i.classList.toggle('fa-eye');
    i.classList.toggle('fa-eye-slash');
}

const COLS = ['','#f43f5e','#f97316','#eab308','#22c55e'];
const LBLS = ['','Weak','Fair','Good','Strong'];

function chkStr(v) {
    let s = 0;
    if (v.length >= 8)           s++;
    if (/[A-Z]/.test(v))        s++;
    if (/[0-9]/.test(v))        s++;
    if (/[^A-Za-z0-9]/.test(v)) s++;
    document.querySelectorAll('#sbar span').forEach((b,i) => {
        b.style.background = i < s ? COLS[s] : 'var(--border-lt)';
    });
    const lbl = document.getElementById('slabel');
    lbl.textContent = v.length === 0 ? 'Enter a password' : LBLS[s];
    lbl.style.color  = v.length === 0 ? 'var(--muted)' : COLS[s];
}

document.getElementById('sform').addEventListener('submit', function() {
    document.getElementById('s1').classList.remove('active');
    document.getElementById('s1').classList.add('done');
    document.getElementById('s1').querySelector('.step-c').style.background = 'var(--blue)';
    document.getElementById('s2').classList.add('active');
});
</script>
</body>
</html>
