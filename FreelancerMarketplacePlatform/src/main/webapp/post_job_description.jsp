<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Post Job – Description | WorkPort</title>
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
  --ok:#10b981;--oklt:#ecfdf5;--ok1:#d1fae5;
  --red:#ef4444;--redlt:#fef2f2;--red1:#fecaca;
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
  max-width:860px;margin:0 auto;
}
.step{
  display:flex;flex-direction:column;align-items:center;gap:5px;
  flex:1;position:relative;
}
.step:not(:last-child)::after{
  content:'';position:absolute;
  top:14px;left:50%;
  width:100%;height:2px;
  background:var(--g200);z-index:0;
  transition:background .3s;
}
.step.done:not(:last-child)::after{background:var(--blue);}
.step-circle{
  width:28px;height:28px;border-radius:50%;
  display:flex;align-items:center;justify-content:center;
  font-size:12px;font-weight:800;
  border:2px solid var(--g200);
  background:#fff;color:var(--g400);
  position:relative;z-index:1;transition:all .3s;
}
.step.active .step-circle{border-color:var(--blue);background:var(--blue);color:#fff;}
.step.done .step-circle{border-color:var(--blue);background:var(--blue);color:#fff;}
.step-label{font-size:10px;font-weight:700;color:var(--g400);text-align:center;white-space:nowrap;}
.step.active .step-label,.step.done .step-label{color:var(--blue);}

/* ── MAIN ── */
.main{
  flex:1;
  display:flex;align-items:flex-start;justify-content:center;
  padding:40px 2.5%;
}
.wide-card{
  background:#fff;
  border:1.5px solid var(--g200);
  border-radius:20px;
  padding:44px 48px;
  width:100%;max-width:860px;
  box-shadow:var(--s2);
}
.step-tag{
  display:inline-flex;align-items:center;gap:6px;
  padding:4px 12px;
  background:var(--bluelt);border:1px solid var(--blue1);
  border-radius:20px;font-size:11px;font-weight:800;
  color:var(--blue);text-transform:uppercase;letter-spacing:.6px;
  margin-bottom:18px;
}
.wide-card h2{
  font-size:1.75rem;font-weight:800;
  color:var(--dark);line-height:1.2;margin-bottom:8px;
}
.wide-card .sub{
  font-size:14px;color:var(--g400);
  line-height:1.7;margin-bottom:32px;
}
.job-id-badge{
  display:inline-flex;align-items:center;gap:6px;
  padding:5px 12px;
  background:var(--g50);border:1.5px solid var(--g200);
  border-radius:8px;font-size:12px;font-weight:600;color:var(--g600);
  margin-bottom:28px;
}
.job-id-badge i{color:var(--g400);font-size:12px;}

/* ── TWO-COL LAYOUT ── */
.two-col{display:flex;gap:36px;align-items:flex-start;}

/* LEFT PANEL */
.left-panel{
  width:38%;flex-shrink:0;
}
.checklist-box{
  background:var(--g50);border:1.5px solid var(--g200);
  border-radius:14px;padding:20px 22px;
  margin-bottom:20px;
}
.checklist-box .box-title{
  font-size:12px;font-weight:800;color:var(--g600);
  text-transform:uppercase;letter-spacing:.5px;
  margin-bottom:14px;
  display:flex;align-items:center;gap:6px;
}
.checklist-box .box-title i{color:var(--blue);font-size:13px;}
.check-item{
  display:flex;align-items:flex-start;gap:9px;
  margin-bottom:10px;font-size:13px;color:var(--g600);line-height:1.55;
}
.check-item:last-child{margin-bottom:0;}
.check-item i{color:var(--ok);font-size:13px;margin-top:1px;flex-shrink:0;}

/* Profile warning panel */
.profile-alert{
  display:flex;align-items:flex-start;gap:10px;
  background:var(--redlt);border:1.5px solid var(--red1);
  border-radius:12px;padding:14px 16px;
}
.profile-alert i{color:var(--red);font-size:16px;margin-top:1px;flex-shrink:0;}
.profile-alert-body{font-size:13px;color:#b91c1c;line-height:1.55;}
.profile-alert-body strong{font-weight:700;display:block;margin-bottom:2px;}

/* Profile complete panel */
.profile-ok{
  display:flex;align-items:flex-start;gap:10px;
  background:var(--oklt);border:1.5px solid var(--ok1);
  border-radius:12px;padding:14px 16px;
}
.profile-ok i{color:var(--ok);font-size:16px;margin-top:1px;flex-shrink:0;}
.profile-ok-body{font-size:13px;color:#065f46;line-height:1.55;}
.profile-ok-body strong{font-weight:700;display:block;margin-bottom:2px;}

/* RIGHT PANEL */
.right-panel{flex:1;}

.textarea-label{
  font-size:12px;font-weight:800;color:var(--g600);
  text-transform:uppercase;letter-spacing:.5px;
  margin-bottom:8px;display:block;
}
.desc-textarea{
  width:100%;height:260px;
  padding:16px;
  font-size:14px;font-family:'DM Sans',sans-serif;
  border:2px solid var(--g200);border-radius:12px;
  color:var(--g800);background:#fff;
  outline:none;resize:vertical;
  transition:border-color .2s,box-shadow .2s;
  line-height:1.7;
}
.desc-textarea:focus{
  border-color:var(--blue);
  box-shadow:0 0 0 4px rgba(37,99,235,.1);
}
.desc-textarea::placeholder{color:var(--g400);}
.char-count{
  font-size:12px;color:var(--g400);
  text-align:right;margin-top:6px;margin-bottom:28px;
  transition:color .2s;
}
.char-count.ok{color:var(--ok);}

/* ── ACTIONS ── */
.actions{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-top:4px;}
.btn-post{
  display:inline-flex;align-items:center;gap:7px;
  padding:13px 28px;
  background:var(--ok);color:#fff;
  border:none;border-radius:10px;
  font-size:14px;font-weight:800;
  font-family:'Plus Jakarta Sans',sans-serif;
  cursor:pointer;
  box-shadow:0 4px 14px rgba(16,185,129,.4);
  transition:all .22s;
}
.btn-post:hover:not(:disabled){
  background:#059669;
  transform:translateY(-2px);
  box-shadow:0 8px 22px rgba(16,185,129,.5);
}
.btn-post:disabled{
  background:#cbd5e1;color:#94a3b8;
  box-shadow:none;cursor:not-allowed;
}

@media(max-width:700px){
  .wide-card{padding:28px 20px;}
  .wide-card h2{font-size:1.35rem;}
  .step-label{display:none;}
  .two-col{flex-direction:column;}
  .left-panel{width:100%;}
  .actions{flex-direction:column-reverse;align-items:stretch;}
  .btn-post{justify-content:center;}
  .ghost-btn{justify-content:center;}
}
</style>
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
  <a href="${pageContext.request.contextPath}/GoHomeServlet" class="logo">
    <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;flex-shrink:0;">
      <rect width="34" height="34" rx="9" fill="#2563eb"/>
      <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
      <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
      <line x1="24" y1="19.5" x2="30" y2="19.5" stroke="white" stroke-width="2" stroke-linecap="round"/>
    </svg>
    <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
  </a>
  <div class="topbar-right">
    <a href="${pageContext.request.contextPath}/GoHomeServlet" class="ghost-btn">
      <i class="bi bi-x-lg"></i> Exit
    </a>
  </div>
</div>

<!-- PROGRESS STEPS -->
<div class="progress-wrap">
  <div class="progress-steps">
    <div class="step done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Title</div>
    </div>
    <div class="step done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Skills</div>
    </div>
    <div class="step done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Scope</div>
    </div>
    <div class="step done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Budget</div>
    </div>
    <div class="step active done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Review</div>
    </div>
  </div>
</div>

<!-- MAIN -->
<div class="main">
  <div class="wide-card">
    <div class="step-tag"><i class="bi bi-send"></i> Step 5 of 5</div>
    <h2>Start the conversation</h2>
    <p class="sub">Write a clear description so freelancers understand exactly what you need and can send their best proposals.</p>

    <div class="job-id-badge">
      <i class="bi bi-hash"></i> Job ID: ${jobId}
    </div>

    <div class="two-col">

      <!-- LEFT: guidance + profile status -->
      <div class="left-panel">
        <div class="checklist-box">
          <div class="box-title"><i class="bi bi-people-fill"></i> Talent are looking for</div>
          <div class="check-item"><i class="bi bi-check-circle-fill"></i> Clear expectations about your task or deliverables</div>
          <div class="check-item"><i class="bi bi-check-circle-fill"></i> The skills required for your work</div>
          <div class="check-item"><i class="bi bi-check-circle-fill"></i> Good communication from the client</div>
          <div class="check-item"><i class="bi bi-check-circle-fill"></i> Details about how you or your team like to work</div>
        </div>

        <c:choose>
          <c:when test="${profileCompleted != true}">
            <div class="profile-alert">
              <i class="bi bi-exclamation-triangle-fill"></i>
              <div class="profile-alert-body">
                <strong>Profile incomplete</strong>
                Your profile must be 100% complete before you can post a job.
              </div>
            </div>
          </c:when>
          <c:otherwise>
            <div class="profile-ok">
              <i class="bi bi-shield-fill-check"></i>
              <div class="profile-ok-body">
                <strong>Profile verified</strong>
                Your profile is complete — you're ready to post!
              </div>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- RIGHT: form -->
      <div class="right-panel">
        <form action="${pageContext.request.contextPath}/PostJobDescriptionServlet" method="post">

          <label class="textarea-label">Describe what you need</label>
          <textarea
            name="description"
            id="description"
            class="desc-textarea"
            placeholder="e.g. I need a full-stack developer to build a responsive e-commerce site with cart, checkout, and payment integration..."
            required
            onkeyup="countChars()"
          >${description}</textarea>
          <div class="char-count" id="charCount">0 characters</div>

          <div class="actions">
            <a class="ghost-btn" href="${pageContext.request.contextPath}/PostJobBudgetServlet">
              <i class="bi bi-arrow-left"></i> Back
            </a>
            <button type="submit" class="btn-post" ${profileCompleted != true ? "disabled" : ""}>
              <i class="bi bi-send-fill"></i> Post Job
            </button>
          </div>

        </form>
      </div>

    </div>
  </div>
</div>

<script>
function countChars() {
  var val = document.getElementById("description").value;
  var cc  = document.getElementById("charCount");
  cc.textContent = val.length + " characters";
  cc.classList.toggle("ok", val.trim().length >= 50);
}
window.onload = function(){ countChars(); };
</script>

</body>
</html>
