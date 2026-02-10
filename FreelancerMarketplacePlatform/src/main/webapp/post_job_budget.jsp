<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post Job – Budget</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #fff;
            margin: 40px;
            color: #111827;
        }

        .step {
            font-size: 14px;
            color: #6b7280;
            margin-bottom: 10px;
        }

        .title {
            font-size: 30px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .sub {
            color: #6b7280;
            margin-bottom: 30px;
        }

        .budget-box {
            border: 2px solid #22c55e;
            border-radius: 8px;
            padding: 20px;
            max-width: 400px;
        }

        .budget-box h4 {
            margin: 0 0 10px;
        }

        .budget-input {
            margin-top: 15px;
        }

        .budget-input input {
            padding: 10px;
            width: 150px;
            font-size: 16px;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
            max-width: 400px;
        }

        .back-btn {
            text-decoration: none;
            color: #2563eb;
            font-weight: 500;
        }

        .next-btn {
            background: #22c55e;
            border: none;
            padding: 10px 24px;
            color: white;
            font-size: 15px;
            border-radius: 6px;
            cursor: pointer;
        }
    </style>
</head>

<body>

<div class="step">4/5 Job post</div>

<div class="title">Tell us about your budget.</div>
<p class="sub">This will help us match you to talent within your range.</p>

<p><b>Job ID:</b> ${jobId}</p>

<form action="${pageContext.request.contextPath}/PostJobBudgetServlet" method="post">

    <div class="budget-box">
        <h4>✔ Fixed price</h4>
        <p>Set a price for the project and pay at the end.</p>

        <div class="budget-input">
            <label>Budget amount</label><br>
            <input type="number" name="budget"
                   value="${budget != null ? budget : ''}"
                   required>
        </div>
    </div>

    <div class="actions">
        <a class="back-btn"
           href="${pageContext.request.contextPath}/PostJobDetailsServlet">
            ← Back
        </a>

        <button class="next-btn" type="submit">
            Next →
        </button>
    </div>

</form>

</body>
</html>
