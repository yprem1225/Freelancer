<%@ page contentType="text/html;charset=UTF-8" %>

<%
Integer jobId = (Integer) session.getAttribute("jobId");
if (jobId == null) {
    response.sendRedirect("home.jsp");
    return;
}
%>

<html>
<head>
<title>Post Job – Skills</title>
</head>

<body>

<h2>STEP 2 OF 5</h2>
<p>Job ID: <%= jobId %></p>

<form action="<%= request.getContextPath() %>/PostJobSkillsServlet" method="post">

    <input type="checkbox" name="skills" value="Java"> Java
    <input type="checkbox" name="skills" value="Spring"> Spring
    <input type="checkbox" name="skills" value="SQL"> SQL

    <br><br>
    <button type="submit">Next →</button>
</form>

<a href="<%= request.getContextPath() %>/PostJobTitleServlet">← Back</a>





</body>
</html>
