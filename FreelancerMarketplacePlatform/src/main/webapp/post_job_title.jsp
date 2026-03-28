<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Post Job – Title | WorkPort</title>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
:root{
  --blue:#2563eb;--blue2:#1d4ed8;--blue3:#3b82f6;
  --bluelt:#eff6ff;--blue1:#dbeafe;
  --dark:#0c1a3a;
  --g50:#f9fafb;--g100:#f3f4f6;--g200:#e5e7eb;
  --g400:#9ca3af;--g600:#4b5563;--g800:#1f2937;
  --ok:#10b981;
  --r:14px;--rs:9px;
  --s2:0 10px 32px rgba(37,99,235,.13),0 2px 8px rgba(0,0,0,.06);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
html{height:100%;}
body{
  font-family:'DM Sans',sans-serif;
  background:#f1f5f9;
  color:var(--g800);
  min-height:100vh;
  display:flex;
  flex-direction:column;
}
h1,h2,h3{font-family:'Plus Jakarta Sans',sans-serif;}

/* ── TOPBAR ── */
.topbar{
  height:64px;
  background:rgba(255,255,255,.95);
  backdrop-filter:blur(16px);
  border-bottom:1px solid var(--g200);
  display:flex;align-items:center;
  padding:0 2.5%;
  gap:16px;
  position:sticky;top:0;z-index:100;
}
.logo{display:flex;align-items:center;gap:8px;text-decoration:none;}
.logo-txt{font-family:'Plus Jakarta Sans',sans-serif;font-size:1.4rem;font-weight:800;}
.logo-txt .w{color:var(--g800);}.logo-txt .p{color:var(--blue);}
.topbar-right{margin-left:auto;}
.ghost-btn{
  display:inline-flex;align-items:center;gap:6px;
  padding:8px 14px;
  background:#fff;border:1.5px solid var(--g200);
  border-radius:var(--rs);font-size:13px;font-weight:700;
  color:var(--g600);cursor:pointer;text-decoration:none;
  font-family:'DM Sans',sans-serif;
  transition:all .18s;
}
.ghost-btn:hover{border-color:var(--blue);color:var(--blue);background:var(--bluelt);}

/* ── PROGRESS BAR ── */
.progress-wrap{
  background:#fff;
  border-bottom:1px solid var(--g200);
  padding:14px 2.5%;
}
.progress-steps{
  display:flex;align-items:center;
  gap:0;
  max-width:680px;margin:0 auto;
}
.step{
  display:flex;flex-direction:column;align-items:center;gap:5px;
  flex:1;position:relative;
}
.step:not(:last-child)::after{
  content:'';
  position:absolute;
  top:14px;left:50%;
  width:100%;height:2px;
  background:var(--g200);
  z-index:0;
  transition:background .3s;
}
.step.done:not(:last-child)::after{background:var(--blue);}
.step-circle{
  width:28px;height:28px;border-radius:50%;
  display:flex;align-items:center;justify-content:center;
  font-size:12px;font-weight:800;
  border:2px solid var(--g200);
  background:#fff;color:var(--g400);
  position:relative;z-index:1;
  transition:all .3s;
}
.step.active .step-circle{border-color:var(--blue);background:var(--blue);color:#fff;}
.step.done .step-circle{border-color:var(--blue);background:var(--blue);color:#fff;}
.step-label{font-size:10px;font-weight:700;color:var(--g400);text-align:center;white-space:nowrap;}
.step.active .step-label{color:var(--blue);}
.step.done .step-label{color:var(--blue);}

/* ── MAIN CARD ── */
.main{
  flex:1;
  display:flex;align-items:center;justify-content:center;
  padding:40px 2.5%;
}
.card{
  background:#fff;
  border:1.5px solid var(--g200);
  border-radius:20px;
  padding:44px 48px;
  width:100%;max-width:680px;
  box-shadow:var(--s2);
}
.step-tag{
  display:inline-flex;align-items:center;gap:6px;
  padding:4px 12px;
  background:var(--bluelt);
  border:1px solid var(--blue1);
  border-radius:20px;
  font-size:11px;font-weight:800;
  color:var(--blue);
  text-transform:uppercase;letter-spacing:.6px;
  margin-bottom:18px;
}
.card h2{
  font-size:1.75rem;font-weight:800;
  color:var(--dark);
  line-height:1.2;
  margin-bottom:8px;
}
.card .sub{
  font-size:14px;color:var(--g400);
  line-height:1.7;margin-bottom:32px;
}

/* ── INPUT ── */
.input-wrap{position:relative;margin-bottom:10px;}
.input-wrap i{
  position:absolute;left:14px;top:50%;
  transform:translateY(-50%);
  color:var(--g400);font-size:17px;
  pointer-events:none;transition:color .2s;
}
.input-wrap:focus-within i{color:var(--blue);}
.title-input{
  width:100%;
  padding:16px 16px 16px 44px;
  font-size:15px;font-family:'DM Sans',sans-serif;
  border:2px solid var(--g200);border-radius:12px;
  color:var(--g800);background:#fff;
  outline:none;
  transition:border-color .2s,box-shadow .2s;
}
.title-input:focus{
  border-color:var(--blue);
  box-shadow:0 0 0 4px rgba(37,99,235,.1);
}
.title-input::placeholder{color:var(--g400);}
.char-count{
  font-size:12px;color:var(--g400);
  text-align:right;margin-bottom:28px;
  transition:color .2s;
}
.char-count.ok{color:var(--ok);}

/* ── TIPS ── */
.tips{
  background:var(--g50);border:1.5px solid var(--g200);
  border-radius:12px;padding:16px 18px;
  margin-bottom:32px;
}
.tips-title{
  font-size:12px;font-weight:800;color:var(--g600);
  text-transform:uppercase;letter-spacing:.5px;
  margin-bottom:10px;
  display:flex;align-items:center;gap:6px;
}
.tips-title i{color:var(--blue);font-size:13px;}
.tip{display:flex;align-items:flex-start;gap:8px;margin-bottom:7px;font-size:13px;color:var(--g600);line-height:1.5;}
.tip:last-child{margin-bottom:0;}
.tip i{color:var(--ok);font-size:13px;margin-top:1px;flex-shrink:0;}

/* ── ACTIONS ── */
.actions{display:flex;align-items:center;justify-content:space-between;gap:12px;}
.btn-next{
  display:inline-flex;align-items:center;gap:7px;
  padding:13px 28px;
  background:var(--blue);color:#fff;
  border:none;border-radius:10px;
  font-size:14px;font-weight:800;
  font-family:'Plus Jakarta Sans',sans-serif;
  cursor:pointer;
  box-shadow:0 4px 14px rgba(37,99,235,.4);
  transition:all .22s;
}
.btn-next:hover:not(:disabled){
  background:var(--blue2);
  transform:translateY(-2px);
  box-shadow:0 8px 22px rgba(37,99,235,.5);
}
.btn-next:disabled{
  background:#cbd5e1;color:#94a3b8;
  box-shadow:none;cursor:not-allowed;
}

@media(max-width:600px){
  .card{padding:28px 20px;}
  .card h2{font-size:1.35rem;}
  .step-label{display:none;}
  .actions{flex-direction:column-reverse;align-items:stretch;}
  .btn-next{justify-content:center;}
  .ghost-btn{justify-content:center;}
}
</style>
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
  <a href="<%= request.getContextPath() %>/GoHomeServlet" class="logo">
    <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;flex-shrink:0;">
      <rect width="34" height="34" rx="9" fill="#2563eb"/>
      <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
      <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
  </a>
  <div class="topbar-right">
    <a href="<%= request.getContextPath() %>/GoHomeServlet" class="ghost-btn">
      <i class="bi bi-x-lg"></i> Exit
    </a>
  </div>
</div>

<!-- PROGRESS STEPS -->
<div class="progress-wrap">
  <div class="progress-steps">
    <div class="step active done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Title</div>
    </div>
    <div class="step">
      <div class="step-circle">2</div>
      <div class="step-label">Skills</div>
    </div>
    <div class="step">
      <div class="step-circle">3</div>
      <div class="step-label">Scope</div>
    </div>
    <div class="step">
      <div class="step-circle">4</div>
      <div class="step-label">Budget</div>
    </div>
    <div class="step">
      <div class="step-circle">5</div>
      <div class="step-label">Review</div>
    </div>
  </div>
</div>

<!-- MAIN -->
<div class="main">
  <div class="card">
    <div class="step-tag"><i class="bi bi-pencil-square"></i> Step 1 of 5</div>
    <h2>Let's start with a strong title</h2>
    <p class="sub">Your title is the first thing freelancers see — make it clear and specific so the right people apply.</p>

    <form action="<%= request.getContextPath() %>/PostJobTitleServlet" method="post">
      <div class="input-wrap">
        <i class="bi bi-briefcase"></i>
        <input
          type="text"
          name="title"
          id="title"
          class="title-input"
          value="<%= request.getAttribute("title") == null ? "" : request.getAttribute("title") %>"
          placeholder="e.g. Build a responsive e-commerce website"
          onkeyup="enableNext()"
          maxlength="120"
          required
        >
      </div>
      <div class="char-count" id="charCount">0 / 120 characters</div>

      <div class="tips">
        <div class="tips-title"><i class="bi bi-lightbulb-fill"></i> Tips for a great title</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> Be specific about what you need built or designed</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> Mention the key technology or platform if relevant</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> Keep it under 80 characters for best readability</div>
      </div>

      <div class="actions">
        <a href="<%= request.getContextPath() %>/GoHomeServlet" class="ghost-btn">
          <i class="bi bi-arrow-left"></i> Back to DashBoard
        </a>
        <button type="submit" class="btn-next" id="nextBtn" disabled>
          Continue <i class="bi bi-arrow-right"></i>
        </button>
      </div>
    </form>
  </div>
</div>

<script>
function enableNext() {
  var val = document.getElementById("title").value.trim();
  var len = document.getElementById("title").value.length;
  var cc  = document.getElementById("charCount");
  cc.textContent = len + " / 120 characters";
  cc.classList.toggle("ok", val.length >= 10);
  document.getElementById("nextBtn").disabled = val.length < 10;
}
// init on load if value pre-filled
window.onload = function(){ enableNext(); };
</script>
</body>
</html>