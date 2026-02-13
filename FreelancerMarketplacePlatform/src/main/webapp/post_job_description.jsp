<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post Job – Description</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            color: #111827;
        }

        .step {
            font-size: 14px;
            color: #6b7280;
        }

        .title {
            font-size: 32px;
            margin-top: 10px;
        }

        .container {
            display: flex;
            gap: 60px;
            margin-top: 30px;
        }

        .left {
            width: 40%;
        }

        .right {
            width: 60%;
        }

        textarea {
            width: 100%;
            height: 250px;
            padding: 12px;
            font-size: 14px;
        }

        .post-btn {
            margin-top: 20px;
            padding: 10px 25px;
            background: #22c55e;
            border: none;
            color: white;
            border-radius: 6px;
            cursor: pointer;
        }

        .post-btn:disabled {
            background: gray;
            cursor: not-allowed;
        }

        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>

<body>

<div class="step">5/5 Job post</div>
<div class="title">Start the conversation.</div>

<p><b>Job ID (Temp Debug):</b> ${jobId}</p>

<div class="container">

    <div class="left">
        <p><b>Talent are looking for:</b></p>
        <ul>
            <li>Clear expectations about your task or deliverables</li>
            <li>The skills required for your work</li>
            <li>Good communication</li>
            <li>Details about how you or your team like to work</li>
        </ul>
    </div>

    <div class="right">
        <form action="${pageContext.request.contextPath}/PostJobDescriptionServlet" method="post">

            <label>Describe what you need</label><br>
            <textarea name="description" required>${description}</textarea>

            <br>

            <button type="submit" class="post-btn"
                ${profileCompleted != true ? "disabled" : ""}>
                Post Job
            </button>

            <c:if test="${profileCompleted != true}">
                <div class="error">
                    Your profile must be 100% completed to post a job.
                </div>
            </c:if>

        </form>
    </div>

</div>

</body>
</html>
