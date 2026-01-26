<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
<title>Post Job – Title</title>

<script>
function enableNext() {
    document.getElementById("nextBtn").disabled =
        document.getElementById("title").value.trim().length < 10;
}
</script>
</head>

<body>

<h2>STEP 1 OF 5</h2>

<form action="<%= request.getContextPath() %>/PostJobTitleServlet" method="post">


    <input type="text"
           name="title"
           id="title"
           value="<%= request.getAttribute("title") == null ? "" : request.getAttribute("title") %>"
           placeholder="Example: Build an e-commerce website"
           onkeyup="enableNext()"
           required>

    <button id="nextBtn" disabled>Next →</button>
   <a href="<%= request.getContextPath() %>/GoHomeServlet">
    <button type="button">Go to Home</button>
</a>

</form>

</body>
</html>
