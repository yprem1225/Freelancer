<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Wallet Analytics | WorkPort</title>
    
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --blue: #2563eb; --blue-lt: #eff6ff;
            --success: #10b981; --success-lt: #ecfdf5;
            --danger: #ef4444; --danger-lt: #fef2f2;
            --warn: #f59e0b; --warn-lt: #fffbeb;
            --slate-50: #f8fafc; --slate-200: #e2e8f0; --slate-900: #0f172a;
            --navh: 64px; --r: 20px; --rs: 12px;
            --shadow: 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            font-family: 'Inter', sans-serif; 
            background: #f1f5f9; 
            color: var(--slate-900); 
            line-height: 1.6;
        }

        /* ══ NAVBAR (Matching Home.jsp) ══ */
        .nav {
            height: var(--navh); background: rgba(255,255,255,.9);
            backdrop-filter: blur(16px); border-bottom: 1px solid var(--slate-200);
            display: flex; align-items: center; padding: 0 5%;
            position: sticky; top: 0; z-index: 1000;
        }
        .logo { display: flex; align-items: center; gap: 8px; text-decoration: none; }
        .logo-txt { font-family: 'Plus Jakarta Sans', sans-serif; font-size: 1.4rem; font-weight: 800; }
        .logo-txt .w { color: var(--slate-900); } .logo-txt .p { color: var(--blue); }

        .btn-back {
            margin-left: auto; display: inline-flex; align-items: center; gap: 8px;
            padding: 10px 20px; background: #fff; border: 1.5px solid var(--slate-200);
            border-radius: var(--rs); font-size: 14px; font-weight: 700;
            color: var(--slate-900); text-decoration: none; transition: 0.2s;
        }
        .btn-back:hover { border-color: var(--blue); color: var(--blue); background: var(--blue-lt); transform: translateY(-1px); }

        /* ══ CONTENT WRAPPER ══ */
        .container { max-width: 1200px; margin: 40px auto; padding: 0 24px; }

        .page-header { margin-bottom: 32px; display: flex; justify-content: space-between; align-items: flex-end; }
        .page-header h1 { font-family: 'Plus Jakarta Sans'; font-size: 1.85rem; font-weight: 800; }
        .page-header p { color: #64748b; font-size: 15px; margin-top: 4px; }

        /* ══ KPI CARDS ══ */
        .kpi-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 32px; }
        .kpi-card {
            background: #fff; padding: 24px; border-radius: var(--r); border: 1px solid var(--slate-200);
            box-shadow: var(--shadow); transition: transform 0.3s ease;
        }
        .kpi-card:hover { transform: translateY(-5px); }
        .kpi-icon {
            width: 44px; height: 44px; border-radius: 12px; display: flex; 
            align-items: center; justify-content: center; font-size: 20px; margin-bottom: 16px;
        }
        .kpi-val { font-size: 1.5rem; font-weight: 800; display: block; color: var(--slate-900); }
        .kpi-lbl { font-size: 13px; color: #64748b; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }

        /* ══ ANALYTICS SECTION ══ */
        .charts-row { display: grid; grid-template-columns: 2fr 1fr; gap: 24px; margin-bottom: 32px; }
        .chart-card {
            background: #fff; padding: 28px; border-radius: var(--r); border: 1px solid var(--slate-200); box-shadow: var(--shadow);
        }
        .chart-title { font-weight: 800; font-family: 'Plus Jakarta Sans'; margin-bottom: 24px; font-size: 1.1rem; display: flex; align-items: center; gap: 10px; }
        
        /* ══ TRANSACTION TABLE ══ */
        .table-card {
            background: #fff; border-radius: var(--r); border: 1px solid var(--slate-200);
            box-shadow: var(--shadow); overflow: hidden;
        }
        .table-header { padding: 24px; border-bottom: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center; }
        .search-wrap { position: relative; width: 320px; }
        .search-wrap i { position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; }
        .search-wrap input { width: 100%; padding: 12px 12px 12px 42px; border-radius: 12px; border: 1.5px solid #f1f5f9; background: #f8fafc; outline: none; transition: 0.2s; }
        .search-wrap input:focus { border-color: var(--blue); background: #fff; }

        table { width: 100%; border-collapse: collapse; }
        th { background: #f8fafc; padding: 16px 24px; text-align: left; font-size: 11px; text-transform: uppercase; font-weight: 700; color: #64748b; letter-spacing: 1px; }
        td { padding: 20px 24px; border-bottom: 1px solid #f1f5f9; font-size: 14px; font-weight: 500; }
        
        .status { padding: 6px 12px; border-radius: 8px; font-size: 11px; font-weight: 800; }
        .status-success { background: var(--success-lt); color: var(--success); }
        .status-pending { background: var(--warn-lt); color: var(--warn); }
        
        .type-pill { display: inline-flex; align-items: center; gap: 6px; font-weight: 700; font-size: 13px; }
        .type-up { color: var(--success); } .type-down { color: var(--danger); }

        @media (max-width: 1024px) {
            .kpi-grid { grid-template-columns: repeat(2, 1fr); }
            .charts-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<nav class="nav">
    <a href="home.jsp" class="logo">
        <svg viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg" style="width:32px;height:32px;">
            <rect width="34" height="34" rx="9" fill="#2563eb"/>
            <path d="M6 11.5L10 23L14 15.5L18 23L22 11.5" stroke="white" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
            <circle cx="27" cy="13" r="3" fill="#06b6d4"/>
        </svg>
        <span class="logo-txt"><span class="w">Work</span><span class="p">Port</span></span>
    </a>
    <a href="ClientHomeServlet" class="btn-back">
        <i class="bi bi-grid-1x2-fill"></i> Back to Dashboard
    </a>
</nav>

<div class="container">
    
    <%
    BigDecimal credit = (BigDecimal) request.getAttribute("totalCredit");
    BigDecimal debit = (BigDecimal) request.getAttribute("totalDebit");
    int creditCount = (int) request.getAttribute("creditCount");
    int debitCount = (int) request.getAttribute("debitCount");
    BigDecimal balance = credit.subtract(debit);
    %>

    <header class="page-header">
        <div>
            <h1>Financial Overview</h1>
            <p>Manage your wallet balance and review transaction history.</p>
        </div>
        <button style="background:var(--blue); color:#fff; border:none; padding:12px 24px; border-radius:12px; font-weight:700; cursor:pointer; box-shadow: 0 4px 14px rgba(37,99,235,0.3);">
            <i class="bi bi-wallet2"></i> &nbsp;Add Funds
        </button>
    </header>

    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-icon" style="background:var(--blue-lt); color:var(--blue);"><i class="bi bi-cash-stack"></i></div>
            <span class="kpi-lbl">Total Balance</span>
            <span class="kpi-val">$ <%= balance %></span>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:var(--success-lt); color:var(--success);"><i class="bi bi-arrow-down-left"></i></div>
            <span class="kpi-lbl">Total Credits</span>
            <span class="kpi-val">$ <%= credit %></span>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:var(--danger-lt); color:var(--danger);"><i class="bi bi-arrow-up-right"></i></div>
            <span class="kpi-lbl">Total Debits</span>
            <span class="kpi-val">$ <%= debit %></span>
        </div>
        <div class="kpi-card">
            <div class="kpi-icon" style="background:var(--warn-lt); color:var(--warn);"><i class="bi bi-clock-history"></i></div>
            <span class="kpi-lbl">Transactions</span>
            <span class="kpi-val"><%= creditCount + debitCount %></span>
        </div>
    </div>

    <div class="charts-row">
        <div class="chart-card">
            <div class="chart-title"><i class="bi bi-graph-up color-blue"></i> Spending vs Credit Trend</div>
            <canvas id="lineChart" height="120"></canvas>
        </div>
        <div class="chart-card">
            <div class="chart-title"><i class="bi bi-pie-chart color-blue"></i> Allocation</div>
            <canvas id="donutChart"></canvas>
        </div>
    </div>

    <div class="table-card">
        <div class="table-header">
            <h3 style="font-family:'Plus Jakarta Sans'; font-size:1.1rem; font-weight:800;">Recent Transactions</h3>
            <div class="search-wrap">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Search by transaction ID...">
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Date & Time</th>
                    <th>Amount</th>
                    <th>Type</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Map<String,Object>> txs = (List<Map<String,Object>>) request.getAttribute("transactions");
                if(txs != null){
                    for(Map<String,Object> tx : txs){
                        String type = (String) tx.get("type");
                %>
                <tr>
                    <td><span style="font-weight:700; color:var(--blue);">#<%= tx.get("transaction_id") %></span></td>
                    <td style="color:#64748b;">March 31, 2026</td>
                    <td style="font-weight:800;">$ <%= tx.get("amount") %></td>
                    <td>
                        <% if("CREDIT".equalsIgnoreCase(type)){ %>
                            <span class="type-pill type-up"><i class="bi bi-plus-circle-fill"></i> CREDIT</span>
                        <% } else { %>
                            <span class="type-pill type-down"><i class="bi bi-dash-circle-fill"></i> DEBIT</span>
                        <% } %>
                    </td>
                    <td><span class="status status-success">SUCCESS</span></td>
                </tr>
                <% }} %>
            </tbody>
        </table>
    </div>

</div>

<script>
    // Line Chart
    new Chart(document.getElementById('lineChart'), {
        type: 'line',
        data: {
            labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
            datasets: [{
                label: 'Credit',
                data: [5000, 7000, 4500, <%= credit %>],
                borderColor: '#10b981',
                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                fill: true,
                tension: 0.4
            }, {
                label: 'Debit',
                data: [3000, 2000, 4000, <%= debit %>],
                borderColor: '#ef4444',
                backgroundColor: 'rgba(239, 68, 68, 0.1)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            scales: { y: { grid: { color: '#f1f5f9' } }, x: { grid: { display: false } } }
        }
    });

    // Donut Chart
    new Chart(document.getElementById('donutChart'), {
        type: 'doughnut',
        data: {
            labels: ['Credit', 'Debit'],
            datasets: [{
                data: [<%= credit %>, <%= debit %>],
                backgroundColor: ['#10b981', '#ef4444'],
                hoverOffset: 10,
                borderWidth: 0
            }]
        },
        options: {
            cutout: '75%',
            plugins: { legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } } }
        }
    });
</script>

</body>
</html>