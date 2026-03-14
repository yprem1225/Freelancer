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
<html>
<head>
<title>Freelancer Profile</title>

<style>

body{
margin:0;
font-family:Arial;
background:#f4f6f9;
}

.navbar{
display:flex;
justify-content:space-between;
align-items:center;
padding:15px 40px;
background:#2c3e50;
color:white;
}

.nav-right{
display:flex;
align-items:center;
gap:20px;
}

.profile-icon{
width:35px;
height:35px;
border-radius:50%;
}

.container{
padding:50px;
display:flex;
justify-content:center;
}

.card{

background:white;
padding:40px;
width:600px;
border-radius:10px;
box-shadow:0px 4px 12px rgba(0,0,0,0.1);

}

.info-box{
background:#f1f5f9;
padding:15px;
border-radius:6px;
margin-bottom:25px;
}

.form-group{
margin-bottom:20px;
}

input, textarea{

width:100%;
padding:10px;
border:1px solid #ccc;
border-radius:6px;

}

textarea{
height:100px;
}

.btn{
background:#3498db;
color:white;
padding:12px;
border:none;
border-radius:6px;
width:100%;
cursor:pointer;
}

.completion{

margin-top:20px;
padding:10px;
border-radius:6px;
font-weight:bold;
text-align:center;

background:<%= profileComplete ? "#d1fae5" : "#fee2e2" %>;
color:<%= profileComplete ? "#065f46" : "#991b1b" %>;

}

.back{
margin-top:20px;
display:block;
text-align:center;
text-decoration:none;
}

</style>

<script>

window.onload=function(){



</script>

</head>

<body>

<div class="navbar">

<h2>WorkPort Freelancer</h2>

<div class="nav-right">

<a href="FreelancerProfileServlet">
<img class="profile-icon"
src="https://cdn-icons-png.flaticon.com/512/149/149071.png">
</a>

<a href="LogoutServlet" style="color:white;text-decoration:none;">Logout</a>

</div>

</div>

<div class="container">

<div class="card">

<h2>My Freelancer Profile</h2>

<div class="info-box">

<b>Name:</b> <%= profile.getName() %> <br>
<b>Email:</b> <%= profile.getEmail() %> <br>
<b>Role:</b> <%= profile.getRole() %>

</div>

<form action="FreelancerProfileServlet" method="post">

<div class="form-group">

<label>Phone</label>

<input type="text" name="phone"
value="<%= profile.getPhone()==null ? "" : profile.getPhone() %>">

</div>

<div class="form-group">

<label>Professional Title</label>

<input type="text" name="title"
placeholder="Example: Java Full Stack Developer"
value="<%= profile.getTitle()==null ? "" : profile.getTitle() %>">

</div>

<div class="form-group">

<label>Skills</label>

<input type="text" name="skills"
placeholder="Java, Spring Boot, MySQL"
value="<%= profile.getSkills()==null ? "" : profile.getSkills() %>">

</div>

<div class="form-group">

<label>Experience (Years)</label>

<input type="number" name="experience"
value="<%= profile.getExperienceYears() %>">

</div>

<div class="form-group">

<label>Hourly Rate (₹)</label>

<input type="number" name="rate"
value="<%= profile.getHourlyRate() %>">

</div>

<div class="form-group">

<label>Bio</label>

<textarea name="bio"
placeholder="Tell clients about your expertise..."><%= profile.getBio()==null ? "" : profile.getBio() %></textarea>

</div>

<button class="btn" type="submit">Save Profile</button>

</form>

<div class="completion">

Profile Completion : <%= completed %> %

<% if(!profileComplete){ %>

<div style="font-size:12px;font-weight:normal">
Complete all fields to reach 100% and apply for jobs
</div>

<% } %>

</div>

<a class="back" href="FreelancerHomeServlet">← Back to Dashboard</a>

</div>

</div>

</body>
</html>