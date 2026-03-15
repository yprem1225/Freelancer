<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.model.Notification"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Freelancer Notifications</title>

<style>

body{
font-family: Arial;
background:#f5f5f5;
margin:0;
padding:0;
}

.container{
width:70%;
margin:auto;
margin-top:40px;
}

h2{
text-align:center;
margin-bottom:30px;
}

.notification{
background:white;
padding:15px;
margin-bottom:15px;
border-left:5px solid #007bff;
box-shadow:0 2px 5px rgba(0,0,0,0.1);
}

.notification p{
margin:0;
font-size:16px;
}

.notification small{
color:gray;
}

.empty{
text-align:center;
font-size:18px;
color:gray;
}

.back{
margin-top:20px;
text-align:center;
}

.back a{
background:#007bff;
color:white;
padding:10px 20px;
text-decoration:none;
border-radius:5px;
}

</style>

</head>

<body>

<div class="container">

<h2>Freelancer Notifications</h2>

<%

List<Notification> list = (List<Notification>)request.getAttribute("notifications");

if(list == null || list.size()==0){
%>

<div class="empty">
No notifications available
</div>

<%
}else{

for(Notification n : list){
%>

<div class="notification">

<h3>Project : <%= n.getJobTitle() %></h3>

<p><b>Your Proposal:</b> <%= n.getProposal() %></p>

<p><b>Status:</b> <%= n.getMessage() %></p>

<br>

<small><%= n.getCreatedAt() %></small>

</div>

<%
}
}
%>

<div class="back">
<a href="freelancer_home.jsp">Back to Dashboard</a>
</div>

</div>

</body>
</html>