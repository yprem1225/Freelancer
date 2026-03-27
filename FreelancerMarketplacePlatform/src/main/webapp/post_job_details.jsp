<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Post Job – Scope | WorkPort</title>
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
  --ok:#10b981;--oklt:#f0fdf4;--okbr:#bbf7d0;
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
  max-width:760px;margin:0 auto;
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
  display:flex;align-items:flex-start;justify-content:center;
  padding:40px 2.5%;
}
.card{
  background:#fff;
  border:1.5px solid var(--g200);
  border-radius:20px;
  padding:44px 48px;
  width:100%;max-width:760px;
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
  line-height:1.7;margin-bottom:36px;
}

/* ── SECTION HEADING ── */
.section-heading{
  display:flex;align-items:center;gap:8px;
  font-size:13px;font-weight:800;
  color:var(--g800);
  text-transform:uppercase;letter-spacing:.5px;
  margin-bottom:14px;
  margin-top:32px;
}
.section-heading:first-of-type{margin-top:0;}
.section-heading .snum{
  width:22px;height:22px;border-radius:50%;
  background:var(--blue);color:#fff;
  font-size:11px;font-weight:800;
  display:flex;align-items:center;justify-content:center;
  flex-shrink:0;
}

/* ── OPTION CARDS ── */
.option-group{
  display:grid;
  gap:12px;
  margin-bottom:6px;
}
.option-group.cols-3{grid-template-columns:repeat(3,1fr);}
.option-group.cols-3-dur{grid-template-columns:repeat(3,1fr);}

.option-label{
  display:flex;flex-direction:column;
  border:2px solid var(--g200);
  border-radius:14px;
  padding:16px 18px;
  cursor:pointer;
  position:relative;
  transition:border-color .2s,background .2s,box-shadow .2s,transform .15s;
  background:#fff;
  gap:6px;
}
.option-label:hover{
  border-color:var(--blue3);
  background:var(--bluelt);
  transform:translateY(-2px);
  box-shadow:0 4px 16px rgba(37,99,235,.12);
}
.option-label input[type="radio"]{
  position:absolute;opacity:0;width:0;height:0;
}
.option-label.selected,
.option-label:has(input:checked){
  border-color:var(--blue);
  background:var(--bluelt);
  box-shadow:0 0 0 3px rgba(37,99,235,.1);
}
.option-icon{
  width:36px;height:36px;border-radius:10px;
  display:flex;align-items:center;justify-content:center;
  font-size:18px;
  margin-bottom:4px;
  background:var(--g100);
  transition:background .2s,color .2s;
}
.option-label:has(input:checked) .option-icon,
.option-label.selected .option-icon{
  background:var(--blue1);
  color:var(--blue);
}
.option-title{
  font-size:14px;font-weight:800;
  color:var(--g800);
  font-family:'Plus Jakarta Sans',sans-serif;
}
.option-desc{
  font-size:12px;color:var(--g400);
  line-height:1.5;
}
.option-check{
  position:absolute;top:12px;right:12px;
  width:18px;height:18px;border-radius:50%;
  border:2px solid var(--g200);
  background:#fff;
  display:flex;align-items:center;justify-content:center;
  transition:all .2s;
  font-size:10px;color:transparent;
}
.option-label:has(input:checked) .option-check,
.option-label.selected .option-check{
  border-color:var(--blue);background:var(--blue);color:#fff;
}

/* Duration & level use slightly compact layout */
.option-label.compact{
  flex-direction:row;
  align-items:center;
  gap:12px;
  padding:14px 16px;
}
.option-label.compact .option-icon{
  margin-bottom:0;flex-shrink:0;
  width:32px;height:32px;font-size:16px;
}
.option-label.compact .option-check{
  position:static;margin-left:auto;flex-shrink:0;
}
.option-label.compact .ot{display:flex;flex-direction:column;gap:2px;flex:1;}

/* ── DIVIDER ── */
.sec-divider{
  border:none;border-top:1.5px solid var(--g200);
  margin:28px 0;
}

/* ── ACTIONS ── */
.actions{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-top:36px;}
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

/* ── HINT ROW ── */
.hint-row{
  display:flex;align-items:flex-start;gap:8px;
  background:var(--g50);border:1.5px solid var(--g200);
  border-radius:12px;padding:13px 16px;
  font-size:12.5px;color:var(--g600);
  line-height:1.55;
  margin-top:14px;
}
.hint-row i{color:var(--blue);font-size:14px;margin-top:1px;flex-shrink:0;}

@media(max-width:700px){
  .card{padding:28px 18px;}
  .card h2{font-size:1.3rem;}
  .step-label{display:none;}
  .option-group.cols-3,
  .option-group.cols-3-dur{grid-template-columns:1fr;}
  .actions{flex-direction:column-reverse;align-items:stretch;}
  .btn-next{justify-content:center;}
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
    <div class="step active">
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
    <div class="step-tag"><i class="bi bi-rulers"></i> Step 3 of 5</div>
    <h2>Define the scope of your project</h2>
    <p class="sub">Help freelancers understand the size, timeline, and experience level your project requires.</p>

    <form method="post">

      <!-- ── SECTION 1: COMPLEXITY ── -->
      <div class="section-heading">
        <span class="snum">1</span>
        Estimate the scope of work
      </div>

      <div class="option-group cols-3">

        <label class="option-label" onclick="markSelected(this,'complexity')">
          <input type="radio" name="complexity" value="Small"
            ${job.complexity == 'Small' ? 'checked' : ''} required>
          <div class="option-icon"><i class="bi bi-lightning-charge"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Small</div>
          <div class="option-desc">Quick, straightforward tasks with a clear deliverable</div>
        </label>

        <label class="option-label" onclick="markSelected(this,'complexity')">
          <input type="radio" name="complexity" value="Medium"
            ${job.complexity == 'Medium' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-layers"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Medium</div>
          <div class="option-desc">Well-defined projects with multiple deliverables</div>
        </label>

        <label class="option-label" onclick="markSelected(this,'complexity')">
          <input type="radio" name="complexity" value="Large"
            ${job.complexity == 'Large' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-building"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Large</div>
          <div class="option-desc">Long-term or complex initiatives with multiple phases</div>
        </label>

      </div>

      <div class="hint-row">
        <i class="bi bi-info-circle-fill"></i>
        Not sure? Choose <strong>Medium</strong> — you can always refine the scope once you connect with a freelancer.
      </div>

      <hr class="sec-divider">

      <!-- ── SECTION 2: DURATION ── -->
      <div class="section-heading">
        <span class="snum">2</span>
        Project duration
      </div>

      <div class="option-group cols-3-dur">

        <label class="option-label compact" onclick="markSelected(this,'duration')">
          <input type="radio" name="duration" value="Less than 1 month"
            ${job.duration == 'Less than 1 month' ? 'checked' : ''} required>
          <div class="option-icon"><i class="bi bi-calendar-check"></i></div>
          <div class="ot">
            <div class="option-title">Short-term</div>
            <div class="option-desc">Less than 1 month</div>
          </div>
          <div class="option-check"><i class="bi bi-check"></i></div>
        </label>

        <label class="option-label compact" onclick="markSelected(this,'duration')">
          <input type="radio" name="duration" value="1 to 3 months"
            ${job.duration == '1 to 3 months' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-calendar-range"></i></div>
          <div class="ot">
            <div class="option-title">Mid-term</div>
            <div class="option-desc">1 to 3 months</div>
          </div>
          <div class="option-check"><i class="bi bi-check"></i></div>
        </label>

        <label class="option-label compact" onclick="markSelected(this,'duration')">
          <input type="radio" name="duration" value="3 to 6 months"
            ${job.duration == '3 to 6 months' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-calendar4-range"></i></div>
          <div class="ot">
            <div class="option-title">Long-term</div>
            <div class="option-desc">3 to 6 months</div>
          </div>
          <div class="option-check"><i class="bi bi-check"></i></div>
        </label>

      </div>

      <hr class="sec-divider">

      <!-- ── SECTION 3: EXPERIENCE LEVEL ── -->
      <div class="section-heading">
        <span class="snum">3</span>
        Experience level required
      </div>

      <div class="option-group cols-3">

        <label class="option-label" onclick="markSelected(this,'freelancerLevel')">
          <input type="radio" name="freelancerLevel" value="Fresher"
            ${job.freelancerLevel == 'Fresher' ? 'checked' : ''} required>
          <div class="option-icon"><i class="bi bi-mortarboard"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Fresher</div>
          <div class="option-desc">Entry level — great for simpler tasks at a lower rate</div>
        </label>

        <label class="option-label" onclick="markSelected(this,'freelancerLevel')">
          <input type="radio" name="freelancerLevel" value="Intermediate"
            ${job.freelancerLevel == 'Intermediate' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-award"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Intermediate</div>
          <div class="option-desc">Some experience — a reliable balance of skill and cost</div>
        </label>

        <label class="option-label" onclick="markSelected(this,'freelancerLevel')">
          <input type="radio" name="freelancerLevel" value="Expert"
            ${job.freelancerLevel == 'Expert' ? 'checked' : ''}>
          <div class="option-icon"><i class="bi bi-trophy"></i></div>
          <div class="option-check"><i class="bi bi-check"></i></div>
          <div class="option-title">Expert</div>
          <div class="option-desc">Highly experienced — for complex or critical work</div>
        </label>

      </div>

      <!-- ── ACTIONS ── -->
      <div class="actions">
        <a href="PostJobSkillsServlet" class="ghost-btn">
          <i class="bi bi-arrow-left"></i> Back
        </a>
        <button type="submit" class="btn-next">
          Continue <i class="bi bi-arrow-right"></i>
        </button>
      </div>

    </form>
  </div>
</div>

<script>
/* Mark the clicked label as selected within its radio group */
function markSelected(clickedLabel, groupName) {
  // Remove 'selected' from all labels in this group
  document.querySelectorAll('input[name="' + groupName + '"]').forEach(function(input) {
    input.closest('.option-label').classList.remove('selected');
  });
  // Add 'selected' to the clicked one
  clickedLabel.classList.add('selected');
}

/* On page load, mark any pre-checked options (for back-navigation state restore) */
window.addEventListener('DOMContentLoaded', function () {
  ['complexity', 'duration', 'freelancerLevel'].forEach(function(groupName) {
    var checked = document.querySelector('input[name="' + groupName + '"]:checked');
    if (checked) {
      checked.closest('.option-label').classList.add('selected');
    }
  });
});
</script>
</body>
</html>
