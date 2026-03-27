<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Budget | WorkPort</title>
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

/* ── JOB ID BADGE ── */
.job-id-badge{
  display:inline-flex;align-items:center;gap:6px;
  padding:5px 12px;
  background:var(--g50);
  border:1.5px solid var(--g200);
  border-radius:8px;
  font-size:12px;font-weight:600;color:var(--g600);
  margin-bottom:28px;
}
.job-id-badge i{color:var(--g400);font-size:12px;}

/* ── BUDGET CARD ── */
.budget-card{
  border:2px solid var(--ok);
  border-radius:14px;
  padding:22px 24px;
  background:var(--oklt);
  margin-bottom:28px;
  transition:box-shadow .2s;
}
.budget-card:focus-within{
  box-shadow:0 0 0 4px rgba(16,185,129,.12);
}
.budget-card-header{
  display:flex;align-items:center;gap:10px;
  margin-bottom:6px;
}
.budget-card-header .check-badge{
  width:22px;height:22px;border-radius:50%;
  background:var(--ok);
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}
.budget-card-header .check-badge i{color:#fff;font-size:12px;}
.budget-card-header h4{
  font-family:'Plus Jakarta Sans',sans-serif;
  font-size:15px;font-weight:800;color:var(--dark);
}
.budget-card p.desc{
  font-size:13px;color:var(--g600);
  line-height:1.6;
  margin-bottom:20px;
  padding-left:32px;
}

/* ── AMOUNT INPUT ── */
.amount-label{
  display:block;
  font-size:12px;font-weight:800;
  color:var(--g600);
  text-transform:uppercase;letter-spacing:.5px;
  margin-bottom:8px;
  padding-left:32px;
}
.amount-input-wrap{
  position:relative;
  max-width:220px;
  margin-left:32px;
}
.amount-input-wrap .currency-symbol{
  position:absolute;left:14px;top:50%;
  transform:translateY(-50%);
  font-size:17px;font-weight:700;
  color:var(--g400);
  pointer-events:none;
  transition:color .2s;
}
.amount-input-wrap:focus-within .currency-symbol{color:var(--ok);}
.budget-input{
  width:100%;
  padding:14px 14px 14px 36px;
  font-size:18px;font-weight:700;
  font-family:'Plus Jakarta Sans',sans-serif;
  border:2px solid var(--ok);
  border-radius:10px;
  color:var(--g800);
  background:#fff;
  outline:none;
  transition:border-color .2s,box-shadow .2s;
}
.budget-input:focus{
  border-color:var(--ok);
  box-shadow:0 0 0 4px rgba(16,185,129,.15);
}
.budget-input::placeholder{color:var(--g400);}

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
.btn-next:hover{
  background:var(--blue2);
  transform:translateY(-2px);
  box-shadow:0 8px 22px rgba(37,99,235,.5);
}

@media(max-width:600px){
  .card{padding:28px 20px;}
  .card h2{font-size:1.35rem;}
  .step-label{display:none;}
  .actions{flex-direction:column-reverse;align-items:stretch;}
  .btn-next{justify-content:center;}
  .ghost-btn{justify-content:center;}
  .amount-input-wrap{margin-left:0;max-width:100%;}
  .amount-label{padding-left:0;}
  .budget-card p.desc{padding-left:0;}
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
    <div class="step active done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
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
    <div class="step-tag"><i class="bi bi-wallet2"></i> Step 4 of 5</div>
    <h2>Tell us about your budget</h2>
    <p class="sub">This helps us match you to the right talent within your range. You can always adjust it later.</p>

    <div class="job-id-badge">
      <i class="bi bi-hash"></i> Job ID: ${jobId}
    </div>

    <form action="${pageContext.request.contextPath}/PostJobBudgetServlet" method="post">

      <div class="budget-card">
        <div class="budget-card-header">
          <div class="check-badge"><i class="bi bi-check-lg"></i></div>
          <h4>Fixed Price</h4>
        </div>
        <p class="desc">Set a one-time price for the entire project and pay when it's done.</p>

        <label class="amount-label">Budget amount (USD)</label>
        <div class="amount-input-wrap">
          <span class="currency-symbol">$</span>
          <input
            type="number"
            name="budget"
            id="budget"
            class="budget-input"
            value="${budget != null ? budget : ''}"
            placeholder="0"
            min="1"
            required
          >
        </div>
      </div>

      <div class="tips">
        <div class="tips-title"><i class="bi bi-lightbulb-fill"></i> Tips for setting a budget</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> Research typical rates for your project type before setting an amount</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> A realistic budget attracts higher-quality, serious freelancers</div>
        <div class="tip"><i class="bi bi-check-circle-fill"></i> You can negotiate the final price after reviewing proposals</div>
      </div>

      <div class="actions">
        <a class="ghost-btn" href="${pageContext.request.contextPath}/PostJobDetailsServlet">
          <i class="bi bi-arrow-left"></i> Back
        </a>
        <button class="btn-next" type="submit">
          Continue <i class="bi bi-arrow-right"></i>
        </button>
      </div>

    </form>
  </div>
</div>

</body>
</html>
