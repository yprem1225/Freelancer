<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Skills | WorkPort</title>
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

/* ── MAIN ── */
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
  width:100%;max-width:720px;
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
  font-size:1.65rem;font-weight:800;
  color:var(--dark);
  line-height:1.25;
  margin-bottom:8px;
}
.card .sub{
  font-size:14px;color:var(--g400);
  line-height:1.7;margin-bottom:28px;
}

/* ── SEARCH ── */
.search-wrap{position:relative;margin-bottom:22px;}
.search-wrap i{
  position:absolute;left:14px;top:50%;
  transform:translateY(-50%);
  color:var(--g400);font-size:16px;
  pointer-events:none;transition:color .2s;
}
.search-wrap:focus-within i{color:var(--blue);}
.search-wrap input{
  width:100%;
  padding:13px 14px 13px 42px;
  border:2px solid var(--g200);border-radius:12px;
  font-size:14px;font-family:'DM Sans',sans-serif;
  color:var(--g800);background:#fff;outline:none;
  transition:border-color .2s,box-shadow .2s;
}
.search-wrap input:focus{
  border-color:var(--blue);
  box-shadow:0 0 0 4px rgba(37,99,235,.1);
}
.search-wrap input::placeholder{color:var(--g400);}

/* ── CATEGORY LABEL ── */
.cat-label{
  font-size:11px;font-weight:800;color:var(--g400);
  text-transform:uppercase;letter-spacing:.7px;
  margin:18px 0 10px;
}

/* ── SKILL PILLS ── */
.skills{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:6px;}
.skill-pill{cursor:pointer;}
.skill-pill input{display:none;}
.skill-pill span{
  display:inline-flex;align-items:center;gap:5px;
  padding:8px 16px;
  border:1.5px solid var(--g200);border-radius:999px;
  font-size:13px;font-weight:600;
  background:#fff;color:var(--g600);
  transition:all .2s cubic-bezier(.22,1,.36,1);
  user-select:none;
}
.skill-pill span:hover{
  border-color:var(--blue3);
  color:var(--blue);
  background:var(--bluelt);
  transform:translateY(-1px);
}
.skill-pill input:checked + span{
  background:var(--blue);
  color:#fff;
  border-color:var(--blue);
  box-shadow:0 4px 12px rgba(37,99,235,.3);
  transform:translateY(-1px);
}
.skill-pill input:checked + span::before{
  content:'\F633';
  font-family:'bootstrap-icons';
  font-size:12px;
}

/* selected count badge */
.selected-count{
  display:inline-flex;align-items:center;gap:5px;
  font-size:12px;font-weight:700;
  color:var(--blue);
  background:var(--bluelt);
  border:1px solid var(--blue1);
  padding:3px 10px;border-radius:20px;
  margin-bottom:24px;
  transition:all .2s;
}

/* ── ACTIONS ── */
.actions{
  display:flex;align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-top:32px;
  padding-top:24px;
  border-top:1.5px solid var(--g100);
}
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
  .card{padding:28px 18px;}
  .card h2{font-size:1.3rem;}
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

<!-- PROGRESS -->
<div class="progress-wrap">
  <div class="progress-steps">
    <div class="step done">
      <div class="step-circle"><i class="bi bi-check-lg" style="font-size:13px;"></i></div>
      <div class="step-label">Title</div>
    </div>
    <div class="step active">
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
    <div class="step-tag"><i class="bi bi-stars"></i> Step 2 of 5</div>
    <h2>What skills does your project require?</h2>
    <p class="sub">Select all the relevant skills — freelancers with matching expertise will be recommended to you.</p>

    <!-- Search -->
    <div class="search-wrap">
      <i class="bi bi-search"></i>
      <input type="text" id="skillSearch" placeholder="Type anything e.g. 'machine learning', 'video editing'…">
    </div>
    
    <form action="${pageContext.request.contextPath}/PostJobSkillsServlet" method="post">

     <!-- Selected count -->
  <div class="selected-count" id="selectedCount">
    <i class="bi bi-check2-circle"></i> 0 skills selected
  </div>

  <!-- AI Suggestions -->
  <div id="aiSuggestions" style="display:none;margin-bottom:16px;">
    <div class="cat-label" style="margin-top:0;">
      <i class="bi bi-stars" style="color:var(--blue);"></i> AI Suggested Skills
    </div>
    <div class="skills" id="aiSkillsContainer"></div>
  </div>
	
      <!-- Design -->
      <div class="cat-label">Design</div>
      <div class="skills" id="skillsContainer">
        <label class="skill-pill"><input type="checkbox" name="skills" value="Web Design" onchange="updateCount()"><span>Web Design</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Graphic Design" onchange="updateCount()"><span>Graphic Design</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Logo Design" onchange="updateCount()"><span>Logo Design</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="UI/UX Design" onchange="updateCount()"><span>UI / UX Design</span></label>
      </div>

      <!-- Development -->
      <div class="cat-label">Development</div>
      <div class="skills">
        <label class="skill-pill"><input type="checkbox" name="skills" value="Java" onchange="updateCount()"><span>Java</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Spring" onchange="updateCount()"><span>Spring</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="SQL" onchange="updateCount()"><span>SQL</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="JavaScript" onchange="updateCount()"><span>JavaScript</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="HTML" onchange="updateCount()"><span>HTML</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="CSS" onchange="updateCount()"><span>CSS</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="React" onchange="updateCount()"><span>React</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Node.js" onchange="updateCount()"><span>Node.js</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Python" onchange="updateCount()"><span>Python</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Django" onchange="updateCount()"><span>Django</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Flask" onchange="updateCount()"><span>Flask</span></label>
      </div>

      <!-- Mobile -->
      <div class="cat-label">Mobile</div>
      <div class="skills">
        <label class="skill-pill"><input type="checkbox" name="skills" value="Android" onchange="updateCount()"><span>Android</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Kotlin" onchange="updateCount()"><span>Kotlin</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Flutter" onchange="updateCount()"><span>Flutter</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="iOS" onchange="updateCount()"><span>iOS</span></label>
      </div>

      <!-- Other -->
      <div class="cat-label">Marketing & Content</div>
      <div class="skills">
        <label class="skill-pill"><input type="checkbox" name="skills" value="WordPress" onchange="updateCount()"><span>WordPress</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="SEO" onchange="updateCount()"><span>SEO</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Content Writing" onchange="updateCount()"><span>Content Writing</span></label>
        <label class="skill-pill"><input type="checkbox" name="skills" value="Digital Marketing" onchange="updateCount()"><span>Digital Marketing</span></label>
      </div>

      <div class="actions">
        <a class="ghost-btn" href="${pageContext.request.contextPath}/PostJobTitleServlet">
          <i class="bi bi-arrow-left"></i> Back
        </a>
        <button class="btn-next" type="submit">
          Continue <i class="bi bi-arrow-right"></i>
        </button>
      </div>

    </form>
  </div>
</div>

<script>
let aiDebounce;

const searchInput = document.getElementById("skillSearch");
const allPills    = document.querySelectorAll(".skill-pill");

// ── Filter existing pills on search ───────────────────────
searchInput.addEventListener("keyup", function () {
    const val = this.value.toLowerCase().trim();

    allPills.forEach(pill => {
        pill.style.display =
            pill.innerText.toLowerCase().includes(val)
                ? "inline-block" : "none";
    });

    clearTimeout(aiDebounce);

    if (val.length < 3) {
        document.getElementById("aiSuggestions").style.display = "none";
        return;
    }

    // Wait 600ms after user stops typing
    aiDebounce = setTimeout(() => fetchAISkills(val), 600);
});

// ── Fetch AI skill suggestions ─────────────────────────────
async function fetchAISkills(query) {
    const container = document.getElementById("aiSkillsContainer");
    const box       = document.getElementById("aiSuggestions");

    // Show loading state
    container.innerHTML =
        '<span style="font-size:13px;color:var(--g400);">'
      + '<i class="bi bi-hourglass-split"></i> Thinking...</span>';
    box.style.display = "block";

    try {
        const res  = await fetch("AISkillServlet?query="
                               + encodeURIComponent(query));
        const data = await res.json();

        // Handle error from servlet
        if (data.error) {
            container.innerHTML =
                '<span style="font-size:13px;color:var(--g400);">'
              + 'Could not load suggestions.</span>';
            return;
        }

        // Parse the skills array from response
        let text = data.content[0].text.trim();

        // Strip backticks just in case
        text = text.replace(/```json/gi, "")
                   .replace(/```/g, "")
                   .trim();

        const skills = JSON.parse(text);

        if (!Array.isArray(skills) || skills.length === 0) {
            container.innerHTML =
                '<span style="font-size:13px;color:var(--g400);">'
              + 'No suggestions found.</span>';
            return;
        }

        // Render skill pills
        container.innerHTML = "";
        skills.forEach(function (skill) {
            const label       = document.createElement("label");
            label.className   = "skill-pill";
            label.innerHTML   =
                '<input type="checkbox" name="skills" '
              + 'value="' + skill + '" onchange="updateCount()">'
              + '<span>' + skill + '</span>';
            container.appendChild(label);
        });

    } catch (e) {
        console.error("AI skill fetch error:", e);
        container.innerHTML =
            '<span style="font-size:13px;color:var(--g400);">'
          + 'Could not load suggestions.</span>';
    }
}

// ── Update selected count badge ───────────────────────────
function updateCount() {
    const n = document.querySelectorAll(
                "input[name='skills']:checked").length;
    document.getElementById("selectedCount").innerHTML =
        '<i class="bi bi-check2-circle"></i> '
      + n + ' skill' + (n !== 1 ? 's' : '') + ' selected';
}
</script>

</body>
</html>