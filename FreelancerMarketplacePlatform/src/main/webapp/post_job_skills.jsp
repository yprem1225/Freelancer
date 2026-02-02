<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Post Job – Skills</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #ffffff;
            margin: 40px;
            color: #1f2937;
        }

        .step {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .step span {
            background: #e5edff;
            color: #2563eb;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 12px;
            margin-left: 6px;
        }

        .title {
            font-size: 28px;
            font-weight: 600;
            max-width: 500px;
            margin-bottom: 10px;
        }

        .job-id {
            font-size: 14px;
            color: #4b5563;
            margin-bottom: 30px;
        }

        .container {
            max-width: 600px;
        }

        .skills label {
            display: block;
            margin: 8px 0;
            font-size: 15px;
            cursor: pointer;
        }

        .skills input {
            margin-right: 8px;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 40px;
        }

        .back-btn {
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }

        .next-btn {
            background: #22c55e;
            border: none;
            padding: 10px 22px;
            color: white;
            font-size: 14px;
            border-radius: 6px;
            cursor: pointer;
        }

        .next-btn:hover {
            background: #16a34a;
        }
    </style>
</head>

<body>

    <div class="step">
        2/5 <span>Job post</span>
    </div>

    <div class="title">
        What are the main skills required for your work?
    </div>

    <p class="job-id"><b>Job ID:</b> ${jobId}</p>

    <div class="container">
        <form action="${pageContext.request.contextPath}/PostJobSkillsServlet" method="post">

            <div class="skills">
                <label><input type="checkbox" name="skills" value="Web Design"> Web Design</label>
                <label><input type="checkbox" name="skills" value="Java"> Java</label>
                <label><input type="checkbox" name="skills" value="Spring"> Spring</label>
                <label><input type="checkbox" name="skills" value="SQL"> SQL</label>
                <label><input type="checkbox" name="skills" value="JavaScript"> JavaScript</label>
                <label><input type="checkbox" name="skills" value="HTML"> HTML</label>
                <label><input type="checkbox" name="skills" value="CSS"> CSS</label>
            </div>

            <div class="actions">
                <!-- BACK BUTTON (logic unchanged) -->
                <a class="back-btn"
                   href="${pageContext.request.contextPath}/PostJobTitleServlet">
                    ← Back
                </a>

                <button class="next-btn" type="submit">
                    Next → Scope
                </button>
            </div>

        </form>
    </div>

</body>
</html>
