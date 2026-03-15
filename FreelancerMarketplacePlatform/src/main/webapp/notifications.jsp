<%@ page import="java.util.List"%>
<%@ page import="com.model.Notification"%>

<h2>Notifications</h2>

<%
List<Notification> list = (List<Notification>)request.getAttribute("notifications");

if(list != null){
for(Notification n : list){
%>

<div style="border:1px solid #ddd;padding:20px;margin-bottom:15px">

<h3><%= n.getFreelancerName() %> applied to "<%= n.getJobTitle() %>"</h3>

<p><b>Title:</b> <%= n.getFreelancerTitle() %></p>

<p><b>Proposal:</b> <%= n.getProposal() %></p>

<p><small><%= n.getCreatedAt() %></small></p>

<a href="ViewFreelancerProfileServlet?id=<%=n.getFreelancerId()%>">
View Freelancer Profile
</a>

&nbsp;&nbsp;

<a href="ClientJobApplicationsServlet?jobId=<%=n.getJobId()%>">
View Application
</a>

</div>

<%
}
}
%>