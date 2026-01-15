<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Post a Job – Title</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 40px;
            border-radius: 8px;
        }

        h1 {
            margin-bottom: 10px;
        }

        p {
            color: #555;
        }

        .example-box {
            background: #f8f9fa;
            padding: 15px;
            border-left: 4px solid #28a745;
            margin-top: 20px;
        }

        .example-box ul {
            margin: 0;
            padding-left: 20px;
        }

        input[type="text"] {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            margin-top: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .next-btn {
            background: #28a745;
            color: #fff;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .next-btn:disabled {
            background: #9ccc9c;
            cursor: not-allowed;
        }

        .step {
            font-size: 14px;
            color: #777;
            margin-bottom: 20px;
        }
    </style>

    <script>
        function enableNext() {
            const title = document.getElementById("jobTitle").value.trim();
            document.getElementById("nextBtn").disabled = (title.length < 10);
        }
    </script>
</head>

<body>

<div class="container">

    <div class="step">STEP 1 OF 5</div>

    <h1>Let’s start with a strong title</h1>
    <p>This helps your job post stand out to the right freelancers.</p>

    <input
        type="text"
        id="jobTitle"
        name="jobTitle"
        placeholder="Example: Build a responsive e-commerce website"
        onkeyup="enableNext()"
        required
    >

    <div class="example-box">
        <b>Example titles</b>
        <ul>
            <li>Need a Java developer for Spring Boot API</li>
            <li>Looking for UI/UX designer for mobile app</li>
            <li>Build an e-commerce website using React</li>
        </ul>
    </div>

    <div class="footer">
        <form action="post_job_skills.jsp" method="get">
            <input type="hidden" name="jobTitle" id="hiddenTitle">
            <button id="nextBtn" class="next-btn" disabled
                    onclick="document.getElementById('hiddenTitle').value=document.getElementById('jobTitle').value">
                Next →
            </button>
        </form>
    </div>

</div>

</body>
</html>
