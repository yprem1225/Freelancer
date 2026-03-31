<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.model.Job, com.model.JobSkill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Jobs Dashboard | WorkPort</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;0,9..40,600;1,9..40,300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --primary: #0066ff;
            --primary-dim: rgba(0, 102, 255, 0.12);
            --active: #00c48c;
            --active-dim: rgba(0, 196, 140, 0.12);
            --ongoing: #ff9f43;
            --ongoing-dim: rgba(255, 159, 67, 0.12);
            --completed: #4e8eff;
            --completed-dim: rgba(78, 142, 255, 0.12);
            --bg: #f0f3fa;
            --surface: #ffffff;
            --surface-2: #f7f9fc;
            --text-primary: #0a0f1e;
            --text-secondary: #6b7a99;
            --text-tertiary: #a0aec0;
            --border: rgba(0,0,0,0.07);
            --border-strong: rgba(0,0,0,0.12);
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.04), 0 4px 16px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 24px rgba(0,0,0,0.07), 0 1px 4px rgba(0,0,0,0.04);
            --shadow-hover: 0 12px 40px rgba(0, 102, 255, 0.14), 0 2px 8px rgba(0,0,0,0.06);
            --radius-sm: 10px;
            --radius-md: 16px;
            --radius-lg: 22px;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text-primary);
            min-height: 100vh;
            padding-bottom: 80px;
            position: relative;
        }

        /* Noise texture overlay */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 512 512' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.75' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.025'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
            opacity: 0.4;
        }

        /* Ambient background blobs */
        body::after {
            content: '';
            position: fixed;
            top: -200px; right: -200px;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(0,102,255,0.07) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }

        .page-wrap {
            position: relative;
            z-index: 1;
        }

        /* ─── HEADER ─── */
        .header {
            background: rgba(255,255,255,0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .header-inner {
            max-width: 1280px;
            margin: 0 auto;
            padding: 0 2rem;
            height: 68px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .wordmark {
            font-family: 'Syne', sans-serif;
            font-size: 20px;
            font-weight: 800;
            color: var(--text-primary);
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .wordmark-dot {
            width: 8px; height: 8px;
            background: var(--primary);
            border-radius: 50%;
            display: inline-block;
        }

        .btn-back {
            display: flex; align-items: center; gap: 7px;
            padding: 9px 18px;
            background: var(--surface);
            border: 1px solid var(--border-strong);
            border-radius: 100px;
            font-size: 13px; font-weight: 600;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.22s ease;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-back:hover {
            background: var(--primary);
            border-color: var(--primary);
            color: #fff;
            box-shadow: 0 4px 16px rgba(0,102,255,0.28);
            transform: translateY(-1px);
        }
        .btn-back i { font-size: 14px; }

        /* ─── MAIN CONTAINER ─── */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2.5rem 2rem;
        }

        /* ─── PAGE HERO ─── */
        .page-hero {
            margin-bottom: 2.5rem;
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            animation: fadeUp 0.5s ease both;
        }
        .page-hero-label {
            font-size: 12px;
            font-weight: 600;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--primary);
            margin-bottom: 6px;
        }
        .page-hero h1 {
            font-family: 'Syne', sans-serif;
            font-size: 32px;
            font-weight: 800;
            color: var(--text-primary);
            letter-spacing: -0.8px;
            line-height: 1.1;
        }
        .page-hero p {
            font-size: 14px;
            color: var(--text-secondary);
            margin-top: 5px;
        }
        .live-indicator {
            display: flex;
            align-items: center;
            gap: 7px;
            font-size: 13px;
            color: var(--active);
            font-weight: 500;
            background: var(--active-dim);
            padding: 7px 14px;
            border-radius: 100px;
        }
        .pulse-dot {
            width: 8px; height: 8px;
            background: var(--active);
            border-radius: 50%;
            animation: pulse 2s ease infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(0.75); }
        }

        /* ─── KPI GRID ─── */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.25rem;
            margin-bottom: 2rem;
        }
        .kpi-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            animation: fadeUp 0.5s ease both;
        }
        .kpi-card:nth-child(1) { animation-delay: 0.05s; }
        .kpi-card:nth-child(2) { animation-delay: 0.10s; }
        .kpi-card:nth-child(3) { animation-delay: 0.15s; }
        .kpi-card:nth-child(4) { animation-delay: 0.20s; }

        .kpi-card:hover { box-shadow: var(--shadow-md); transform: translateY(-3px); }

        /* Colored top border accent */
        .kpi-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            border-radius: 3px 3px 0 0;
        }
        .kpi-card.total::before    { background: linear-gradient(90deg, #818cf8, #6366f1); }
        .kpi-card.active::before   { background: linear-gradient(90deg, #34d399, #10b981); }
        .kpi-card.ongoing::before  { background: linear-gradient(90deg, #fbbf24, #f59e0b); }
        .kpi-card.completed::before { background: linear-gradient(90deg, #60a5fa, #3b82f6); }

        .kpi-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 1rem;
        }
        .kpi-icon {
            width: 46px; height: 46px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
        }
        .kpi-trend {
            font-size: 12px;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 6px;
            color: var(--active);
            background: var(--active-dim);
        }
        .kpi-num {
            font-family: 'Syne', sans-serif;
            font-size: 36px;
            font-weight: 800;
            letter-spacing: -1px;
            line-height: 1;
            margin-bottom: 3px;
        }
        .kpi-lbl {
            font-size: 13px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        /* ─── ANALYTICS ROW ─── */
        .analytics-row {
            display: grid;
            grid-template-columns: 1.7fr 1fr;
            gap: 1.25rem;
            margin-bottom: 2rem;
            animation: fadeUp 0.5s 0.25s ease both;
        }
        .chart-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 1.75rem;
            box-shadow: var(--shadow-sm);
            transition: box-shadow 0.3s;
        }
        .chart-card:hover { box-shadow: var(--shadow-md); }
        .chart-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        .chart-title {
            font-family: 'Syne', sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: var(--text-primary);
        }
        .chart-sub {
            font-size: 12px;
            color: var(--text-secondary);
            margin-top: 2px;
        }
        .chart-badge {
            font-size: 11px;
            font-weight: 600;
            padding: 4px 10px;
            background: var(--surface-2);
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text-secondary);
        }

        /* ─── SECTION HEADER ─── */
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.25rem;
            animation: fadeUp 0.5s 0.3s ease both;
        }
        .section-title {
            font-family: 'Syne', sans-serif;
            font-size: 18px;
            font-weight: 800;
            color: var(--text-primary);
            letter-spacing: -0.4px;
        }
        .section-count {
            font-size: 13px;
            color: var(--text-secondary);
            font-weight: 500;
            margin-top: 1px;
        }

        /* ─── FILTER TABS ─── */
        .filter-tabs {
            display: flex;
            gap: 6px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 100px;
            padding: 4px;
        }
        .tab {
            padding: 7px 18px;
            border-radius: 100px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-secondary);
            cursor: pointer;
            transition: all 0.22s ease;
            border: none;
            background: transparent;
            font-family: 'DM Sans', sans-serif;
            white-space: nowrap;
        }
        .tab:hover { color: var(--text-primary); }
        .tab.active {
            background: var(--primary);
            color: #fff;
            box-shadow: 0 2px 8px rgba(0,102,255,0.30);
        }

        /* ─── JOB GRID ─── */
        .job-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 1.25rem;
            animation: fadeUp 0.5s 0.35s ease both;
        }

        .job-card {
            background: var(--surface);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            position: relative;
        }
        .job-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
            border-color: rgba(0,102,255,0.25);
        }
        .job-card:hover .job-arrow { opacity: 1; transform: translateX(0); }

        /* Left accent bar */
        .job-card .accent-bar {
            width: 4px;
            position: absolute;
            top: 0; left: 0; bottom: 0;
            border-radius: 0 4px 4px 0;
        }
        .job-active   .accent-bar { background: var(--active); }
        .job-working  .accent-bar { background: var(--ongoing); }
        .job-completed .accent-bar { background: var(--completed); }

        .job-inner { padding: 1.5rem 1.5rem 1.5rem 1.9rem; display: flex; flex-direction: column; flex: 1; }

        .job-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 10px;
        }
        .job-title {
            font-family: 'Syne', sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.2px;
            line-height: 1.35;
            flex: 1;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 8px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            white-space: nowrap;
        }
        .status-badge::before {
            content: '';
            width: 5px; height: 5px;
            border-radius: 50%;
        }
        .active-badge   { background: var(--active-dim);    color: #057a55; }
        .active-badge::before { background: var(--active); }
        .ongoing-badge  { background: var(--ongoing-dim);   color: #b45309; }
        .ongoing-badge::before { background: var(--ongoing); }
        .completed-badge { background: var(--completed-dim); color: #1e40af; }
        .completed-badge::before { background: var(--completed); }

        .job-meta {
            display: flex;
            gap: 16px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }
        .job-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13px;
            color: var(--text-secondary);
        }
        .job-meta-item i { font-size: 13px; color: var(--text-tertiary); }
        .job-meta-item strong { color: var(--text-primary); font-weight: 600; }

        .divider {
            height: 1px;
            background: var(--border);
            margin: 12px 0;
        }

        .job-desc {
            font-size: 13.5px;
            color: var(--text-secondary);
            line-height: 1.65;
            margin-bottom: 14px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }

        .job-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: auto;
        }

        .skills-wrap { display: flex; flex-wrap: wrap; gap: 5px; }
        .skill-tag {
            font-size: 11.5px;
            font-weight: 600;
            padding: 4px 10px;
            background: var(--surface-2);
            border: 1px solid var(--border);
            border-radius: 7px;
            color: var(--text-secondary);
            transition: all 0.2s;
        }
        .skill-tag:hover {
            background: var(--primary-dim);
            border-color: rgba(0,102,255,0.25);
            color: var(--primary);
        }

        .job-arrow {
            width: 32px; height: 32px;
            border-radius: 10px;
            background: var(--surface-2);
            border: 1px solid var(--border);
            display: flex; align-items: center; justify-content: center;
            color: var(--text-secondary);
            font-size: 14px;
            opacity: 0;
            transform: translateX(-6px);
            transition: all 0.25s ease;
            flex-shrink: 0;
        }

        /* ─── EMPTY STATE ─── */
        .empty-state {
            grid-column: 1 / -1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 5rem 2rem;
            color: var(--text-tertiary);
            text-align: center;
        }
        .empty-state i { font-size: 48px; margin-bottom: 16px; }
        .empty-state p { font-size: 15px; }

        /* ─── ANIMATIONS ─── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(18px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* ─── RESPONSIVE ─── */
        @media (max-width: 1100px) {
            .kpi-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 900px) {
            .analytics-row { grid-template-columns: 1fr; }
            .kpi-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 600px) {
            .kpi-grid { grid-template-columns: 1fr; }
            .job-grid { grid-template-columns: 1fr; }
            .page-hero { flex-direction: column; align-items: flex-start; gap: 12px; }
            .section-header { flex-direction: column; align-items: flex-start; gap: 10px; }
            .container { padding: 1.5rem 1rem; }
        }
    </style>
</head>
<body>

<%
  List<Job> activeJobs    = (List<Job>) request.getAttribute("activeJobs");
  List<Job> workingJobs   = (List<Job>) request.getAttribute("workingJobs");
  List<Job> completedJobs = (List<Job>) request.getAttribute("completedJobs");

  int activeCount    = (activeJobs != null) ? activeJobs.size() : 0;
  int ongoingCount   = (workingJobs != null) ? workingJobs.size() : 0;
  int completedCount = (completedJobs != null) ? completedJobs.size() : 0;
  int total = activeCount + ongoingCount + completedCount;
%>

<div class="page-wrap">

    <!-- HEADER -->
    <header class="header">
        <div class="header-inner">
            <div class="wordmark">
                <span class="wordmark-dot"></span>
                WorkPort
            </div>
            <a href="javascript:history.back()" class="btn-back">
                <i class="bi bi-arrow-left"></i> Back
            </a>
        </div>
    </header>

    <!-- MAIN -->
    <main class="container">

        <!-- PAGE HERO -->
        <div class="page-hero">
            <div>
                <div class="page-hero-label">Client Dashboard</div>
                <h1>Your Jobs Overview</h1>
                <p>Track, manage and monitor all your posted jobs in one place.</p>
            </div>
            <div class="live-indicator">
                <span class="pulse-dot"></span>
                Live Data
            </div>
        </div>

        <!-- KPI CARDS -->
        <div class="kpi-grid">
            <div class="kpi-card total">
                <div class="kpi-top">
                    <div class="kpi-icon" style="background:#eef2ff; color:#6366f1;">
                        <i class="bi bi-briefcase-fill"></i>
                    </div>
                    <span class="kpi-trend">All</span>
                </div>
                <div class="kpi-num"><%= total %></div>
                <div class="kpi-lbl">Total Jobs Posted</div>
            </div>
            <div class="kpi-card active">
                <div class="kpi-top">
                    <div class="kpi-icon" style="background:var(--active-dim); color:var(--active);">
                        <i class="bi bi-broadcast"></i>
                    </div>
                    <span class="kpi-trend" style="color:var(--active); background:var(--active-dim);">Live</span>
                </div>
                <div class="kpi-num" style="color:var(--active);"><%= activeCount %></div>
                <div class="kpi-lbl">Active Listings</div>
            </div>
            <div class="kpi-card ongoing">
                <div class="kpi-top">
                    <div class="kpi-icon" style="background:var(--ongoing-dim); color:var(--ongoing);">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    <span class="kpi-trend" style="color:var(--ongoing); background:var(--ongoing-dim);">In Progress</span>
                </div>
                <div class="kpi-num" style="color:var(--ongoing);"><%= ongoingCount %></div>
                <div class="kpi-lbl">Ongoing Projects</div>
            </div>
            <div class="kpi-card completed">
                <div class="kpi-top">
                    <div class="kpi-icon" style="background:var(--completed-dim); color:var(--completed);">
                        <i class="bi bi-check2-circle"></i>
                    </div>
                    <span class="kpi-trend" style="color:var(--completed); background:var(--completed-dim);">Done</span>
                </div>
                <div class="kpi-num" style="color:var(--completed);"><%= completedCount %></div>
                <div class="kpi-lbl">Completed Jobs</div>
            </div>
        </div>

        <!-- CHARTS -->
        <div class="analytics-row">
            <div class="chart-card">
                <div class="chart-header">
                    <div>
                        <div class="chart-title">Jobs Posted Over Time</div>
                        <div class="chart-sub">Monthly activity trend</div>
                    </div>
                    <span class="chart-badge">Last 6 months</span>
                </div>
                <canvas id="lineChart" height="130"></canvas>
            </div>
            <div class="chart-card">
                <div class="chart-header">
                    <div>
                        <div class="chart-title">Job Distribution</div>
                        <div class="chart-sub">Status breakdown</div>
                    </div>
                </div>
                <canvas id="donutChart"></canvas>
            </div>
        </div>

        <!-- JOB LISTINGS -->
        <div class="section-header">
            <div>
                <div class="section-title">Job Listings</div>
                <div class="section-count"><%= total %> jobs total</div>
            </div>
            <div class="filter-tabs">
                <div class="tab active" onclick="filterJobs('all', this)">All</div>
                <div class="tab" onclick="filterJobs('active', this)">Active</div>
                <div class="tab" onclick="filterJobs('working', this)">Ongoing</div>
                <div class="tab" onclick="filterJobs('completed', this)">Completed</div>
            </div>
        </div>

        <div class="job-grid" id="jobGrid">

            <!-- Active Jobs -->
            <% if (activeJobs != null) { for (Job job : activeJobs) { %>
            <div class="job-card job-active">
                <div class="accent-bar"></div>
                <div class="job-inner">
                    <div class="job-header">
                        <span class="job-title"><%= job.getTitle() %></span>
                        <span class="status-badge active-badge">Active</span>
                    </div>
                    <div class="job-meta">
                        <div class="job-meta-item">
                            <i class="bi bi-currency-dollar"></i>
                            <span>Budget: <strong><%= job.getBudget() %></strong></span>
                        </div>
                        <div class="job-meta-item">
                            <i class="bi bi-bar-chart-line"></i>
                            <span>Level: <strong><%= job.getFreelancerLevel() %></strong></span>
                        </div>
                    </div>
                    <div class="divider"></div>
                    <p class="job-desc"><%= job.getDescription() %></p>
                    <div class="job-footer">
                        <div class="skills-wrap">
                            <% for (JobSkill skill : job.getSkills()) { %>
                            <span class="skill-tag"><%= skill.getSkillName() %></span>
                            <% } %>
                        </div>
                        <div class="job-arrow"><i class="bi bi-arrow-right"></i></div>
                    </div>
                </div>
            </div>
            <% }} %>

            <!-- Ongoing Jobs -->
            <% if (workingJobs != null) { for (Job job : workingJobs) { %>
            <div class="job-card job-working">
                <div class="accent-bar"></div>
                <div class="job-inner">
                    <div class="job-header">
                        <span class="job-title"><%= job.getTitle() %></span>
                        <span class="status-badge ongoing-badge">Ongoing</span>
                    </div>
                    <div class="job-meta">
                        <div class="job-meta-item">
                            <i class="bi bi-currency-dollar"></i>
                            <span>Budget: <strong><%= job.getBudget() %></strong></span>
                        </div>
                        <div class="job-meta-item">
                            <i class="bi bi-person-check"></i>
                            <span>Freelancer Assigned</span>
                        </div>
                    </div>
                    <div class="divider"></div>
                    <p class="job-desc">This project is currently in progress with the assigned freelancer.</p>
                    <div class="job-footer">
                        <div class="skills-wrap"></div>
                        <div class="job-arrow"><i class="bi bi-arrow-right"></i></div>
                    </div>
                </div>
            </div>
            <% }} %>

            <!-- Completed Jobs -->
            <% if (completedJobs != null) { for (Job job : completedJobs) { %>
            <div class="job-card job-completed">
                <div class="accent-bar"></div>
                <div class="job-inner">
                    <div class="job-header">
                        <span class="job-title"><%= job.getTitle() %></span>
                        <span class="status-badge completed-badge">Completed</span>
                    </div>
                    <div class="job-meta">
                        <div class="job-meta-item">
                            <i class="bi bi-currency-dollar"></i>
                            <span>Final Budget: <strong><%= job.getBudget() %></strong></span>
                        </div>
                        <div class="job-meta-item">
                            <i class="bi bi-shield-check"></i>
                            <span>Payment Released</span>
                        </div>
                    </div>
                    <div class="divider"></div>
                    <p class="job-desc">Successfully completed and payment released to the freelancer.</p>
                    <div class="job-footer">
                        <div class="skills-wrap"></div>
                        <div class="job-arrow"><i class="bi bi-arrow-right"></i></div>
                    </div>
                </div>
            </div>
            <% }} %>

            <% if (total == 0) { %>
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <p>No jobs found. Start by posting your first job.</p>
            </div>
            <% } %>

        </div>
    </main>
</div>

<script>
    // ── Line Chart ──────────────────────────────────────────
    const ctxLine = document.getElementById('lineChart').getContext('2d');
    new Chart(ctxLine, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Jobs Posted',
                data: [2, 5, 3, 8, 4, <%= total %>],
                borderColor: '#0066ff',
                backgroundColor: (ctx) => {
                    const g = ctx.chart.ctx.createLinearGradient(0, 0, 0, 220);
                    g.addColorStop(0, 'rgba(0,102,255,0.18)');
                    g.addColorStop(1, 'rgba(0,102,255,0)');
                    return g;
                },
                fill: true,
                tension: 0.45,
                borderWidth: 2.5,
                pointBackgroundColor: '#fff',
                pointBorderColor: '#0066ff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#0a0f1e',
                    titleColor: '#fff',
                    bodyColor: 'rgba(255,255,255,0.7)',
                    padding: 12,
                    cornerRadius: 10,
                    displayColors: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(0,0,0,0.04)', drawBorder: false },
                    ticks: { color: '#a0aec0', font: { family: 'DM Sans', size: 12 }, stepSize: 2 }
                },
                x: {
                    grid: { display: false },
                    ticks: { color: '#a0aec0', font: { family: 'DM Sans', size: 12 } }
                }
            }
        }
    });

    // ── Donut Chart ─────────────────────────────────────────
    const ctxDonut = document.getElementById('donutChart').getContext('2d');
    new Chart(ctxDonut, {
        type: 'doughnut',
        data: {
            labels: ['Active', 'Ongoing', 'Completed'],
            datasets: [{
                data: [<%= activeCount %>, <%= ongoingCount %>, <%= completedCount %>],
                backgroundColor: ['#00c48c', '#ff9f43', '#4e8eff'],
                borderWidth: 0,
                hoverOffset: 12,
                borderRadius: 6
            }]
        },
        options: {
            cutout: '72%',
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 18,
                        font: { family: 'DM Sans', size: 13, weight: '600' },
                        color: '#6b7a99',
                        usePointStyle: true,
                        pointStyleWidth: 8
                    }
                },
                tooltip: {
                    backgroundColor: '#0a0f1e',
                    titleColor: '#fff',
                    bodyColor: 'rgba(255,255,255,0.7)',
                    padding: 12,
                    cornerRadius: 10
                }
            }
        }
    });

    // ── Tab Filtering ────────────────────────────────────────
    function filterJobs(type, el) {
        const cards = document.querySelectorAll('.job-card');
        const tabs  = document.querySelectorAll('.tab');
        tabs.forEach(t => t.classList.remove('active'));
        el.classList.add('active');
        cards.forEach(card => {
            const show = type === 'all' || card.classList.contains('job-' + type);
            card.style.display = show ? 'flex' : 'none';
        });
    }
</script>
</body>
</html>
