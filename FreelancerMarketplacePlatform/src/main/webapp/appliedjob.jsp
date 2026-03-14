<%@ page import="java.util.List" %>
<%@ page import="com.model.AppliedJob" %>

<!DOCTYPE html>
<html>
<head>

<title>Applied Jobs</title>

<style>

body{
font-family: Arial;
background:#f4f6f9;
}

.container{
width:80%;
margin:auto;
margin-top:40px;
}

.job-card{
background:white;
padding:20px;
margin-bottom:20px;
border-radius:10px;
box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

.status{
padding:5px 10px;
border-radius:5px;
background:#28a745;
color:white;
}

</style>

</head>

<body>

<div class="container">

<h2>Jobs You Applied For</h2>

<%
List<AppliedJob> jobs = (List<AppliedJob>)request.getAttribute("appliedJobs");

if(jobs!=null && jobs.size()>0){

for(AppliedJob job: jobs){
%>

<div class="job-card">

<h3><%= job.getTitle() %></h3>

<p><b>Description:</b> <%= job.getDescription() %></p>

<p><b>Budget:</b> ₹<%= job.getBudget() %></p>

<p><b>Your Proposal:</b> <%= job.getProposal() %></p>

<p><b>Status:</b>
<span class="status">
<%= job.getStatus() %>
</span>
</p>

</div>

<%
}
}else{
%>

<p>No jobs applied yet.</p>

<%
}
%>

</div>

</body>
</html>