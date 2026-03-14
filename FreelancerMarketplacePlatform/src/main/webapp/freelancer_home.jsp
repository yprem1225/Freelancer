<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.model.FreelancerProfile" %>

<%
FreelancerProfile profile = (FreelancerProfile) request.getAttribute("profile");

if(profile == null){
    response.sendRedirect("login.jsp");
    return;
}

int completed = 30;

if(profile.getPhone()!=null && !profile.getPhone().trim().isEmpty()) completed += 10;
if(profile.getTitle()!=null && !profile.getTitle().trim().isEmpty()) completed += 15;
if(profile.getSkills()!=null && !profile.getSkills().trim().isEmpty()) completed += 15;
if(profile.getExperienceYears()>0) completed += 10;
if(profile.getHourlyRate()>0) completed += 10;
if(profile.getBio()!=null && !profile.getBio().trim().isEmpty()) completed += 10;

boolean profileComplete = completed == 100;
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Freelancer Dashboard | WorkPort</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

:root{
--primary-blue:#2563eb;
--border-light:#e2e8f0;
--text-dark:#1e293b;
--text-muted:#64748b;
--nav-bg:#f8fafc;
}

body{
margin:0;
font-family:'Inter',sans-serif;
background:#ffffff;
color:var(--text-dark);
}

/* NAVBAR */

.navbar{
display:flex;
align-items:center;
padding:0 5%;
background:var(--nav-bg);
border-bottom:1px solid var(--border-light);
height:75px;
}

.logo{
font-size:1.7rem;
font-weight:800;
text-decoration:none;
margin-right:35px;
}

.logo .work{color:#000;}
.logo .port{color:var(--primary-blue);}

.nav-links{
display:flex;
gap:8px;
height:100%;
align-items:center;
}

.nav-item{
position:relative;
height:100%;
display:flex;
align-items:center;
}

.nav-link{
text-decoration:none;
color:var(--text-dark);
font-size:14px;
font-weight:500;
padding:0 12px;
display:flex;
align-items:center;
height:100%;
cursor:pointer;
}

.dropdown-content{
display:none;
position:absolute;
top:75px;
left:0;
background:#fff;
min-width:220px;
box-shadow:0 12px 24px rgba(0,0,0,0.1);
border:1px solid var(--border-light);
border-radius:0 0 10px 10px;
padding:12px 0;
}

.nav-item:hover .dropdown-content{
display:block;
}

.dropdown-content a{
display:block;
padding:12px 24px;
text-decoration:none;
color:var(--text-dark);
}

.dropdown-content a:hover{
background:#f8fafc;
color:var(--primary-blue);
}

/* SEARCH */

.search-container{
flex-grow:1;
max-width:400px;
margin:0 30px;
position:relative;
}

.search-input{
width:100%;
padding:10px 15px 10px 40px;
border-radius:25px;
border:1px solid var(--border-light);
font-size:14px;
}

.search-icon{
position:absolute;
left:15px;
top:50%;
transform:translateY(-50%);
color:var(--text-muted);
}

/* RIGHT SIDE */

.nav-right{
margin-left:auto;
display:flex;
align-items:center;
gap:20px;
}

.profile-box{
display:flex;
align-items:center;
gap:12px;
text-decoration:none;
}

.user-name-small{
font-weight:700;
font-size:14px;
margin:0;
color:var(--text-dark);
}

.user-role-badge{
background:#eff6ff;
color:var(--primary-blue);
font-size:10px;
font-weight:700;
padding:2px 8px;
border-radius:6px;
text-transform:uppercase;
}

.logout-btn{
border:1.5px solid var(--primary-blue);
color:var(--primary-blue);
background:transparent;
padding:7px 16px;
border-radius:8px;
font-weight:600;
cursor:pointer;
}

.logout-btn:hover{
background:var(--primary-blue);
color:white;
}

/* DASHBOARD CONTENT */

.container{
width:90%;
max-width:1000px;
margin:40px auto;
}

.card{
background:white;
padding:25px;
margin-bottom:20px;
border-radius:10px;
border:1px solid var(--border-light);
}

.card h3{
margin-top:0;
}

.btn{
background:var(--primary-blue);
color:white;
padding:10px 18px;
border-radius:6px;
text-decoration:none;
font-size:14px;
}

.warning{
background:#fffbeb;
border:1px solid #fde68a;
padding:20px;
border-radius:10px;
margin-bottom:25px;
color:#92400e;
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar">

<a href="FreelancerHomeServlet" class="logo">
<span class="work">Work</span><span class="port">Port</span>
</a>

<div class="nav-links">

<div class="nav-item">
<a class="nav-link">Find Work ▼</a>

<div class="dropdown-content">
<a href="BrowseJobsServlet">Find Jobs</a>
<a href="MyApplicationsServlet">My Applications</a>
</div>
</div>


<div class="nav-item">
<a class="nav-link">Deliver Work ▼</a>

<div class="dropdown-content">
<a href="#">My Projects</a>
</div>
</div>


<div class="nav-item">
<a class="nav-link">Manage Finances ▼</a>

<div class="dropdown-content">
<a href="WalletServlet">My Earnings</a>
</div>
</div>

<a href="#" class="nav-link">Messages</a>

</div>


<div class="search-container">
<span class="search-icon">🔍</span>
<input type="text" class="search-input" placeholder="Search for jobs...">
</div>


<div class="nav-right">

<a href="WalletServlet" class="nav-link">💰 Wallet</a>

<a href="FreelancerProfileServlet" class="profile-box">

<div style="text-align:right">

<p class="user-name-small"><%= profile.getName() %></p>
<span class="user-role-badge">Freelancer</span>

</div>

<div style="width:40px;height:40px;border-radius:50%;background:var(--primary-blue);color:white;display:flex;align-items:center;justify-content:center;font-weight:bold;">

<%= profile.getName().substring(0,1).toUpperCase() %>

</div>

</a>

<form action="LogoutServlet" method="post" style="margin:0">

<button type="submit" class="logout-btn">Logout</button>

</form>

</div>

</nav>

<!-- DASHBOARD -->

<div class="container">

<% if(!profileComplete){ %>

<div class="warning">

<b>Profile incomplete (<%= completed %>%)</b> — Complete your profile to apply for jobs.

</div>

<% } %>

<div class="card">

<h3>Browse Jobs</h3>

<p>Find projects posted by clients.</p>

<a class="btn" href="BrowseJobsServlet">View Jobs</a>

</div>


<div class="card">

<h3>My Applications</h3>

<p>See jobs you applied for.</p>

<a class="btn" href="MyApplicationsServlet">View Applications</a>

</div>


<div class="card">

<h3>My Earnings</h3>

<p>Check your wallet balance.</p>

<a class="btn" href="WalletServlet">My Wallet</a>

</div>


<div class="card">

<h3>Profile</h3>

<p>Update freelancer profile.</p>

<a class="btn" href="FreelancerProfileServlet">Edit Profile</a>

</div>

</div>

</body>
</html>