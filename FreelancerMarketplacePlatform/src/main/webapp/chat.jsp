<%@ page import="java.util.List" %>
<%@ page import="com.model.ChatMessage" %>

<h2>Project Chat</h2>

<div style="border:1px solid #ccc;height:400px;overflow-y:scroll;padding:10px">

<%

List<ChatMessage> list = (List<ChatMessage>)request.getAttribute("messages");

if(list!=null){

for(ChatMessage m : list){

%>

<div style="margin-bottom:10px">

<b>User <%=m.getSenderId()%> :</b>

<%=m.getMessage()%>

<br>

<small><%=m.getTime()%></small>

</div>

<%
}
}
%>

</div>

<br>

<form action="SendMessageServlet" method="post">

<input type="hidden" name="chatId" value="<%=request.getAttribute("chatId")%>">

<input type="hidden" name="jobId" value="<%=request.getAttribute("jobId")%>">

<input type="text" name="message" style="width:80%" required>

<button type="submit">Send</button>

</form>