<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Budget</title>

<style>
    body {
        margin: 0;
        font-family: Arial, sans-serif;
        background: #fff;
    }

    .container {
        max-width: 1200px;
        margin: auto;
        padding: 30px 40px;
        height: 100vh;
        box-sizing: border-box;
    }

    .reminder {
        background: #eef6ff;
        padding: 12px 16px;
        border-radius: 8px;
        color: #004aad;
        font-size: 14px;
        margin-bottom: 25px;
    }

    .step {
        font-size: 14px;
        color: #666;
        margin-bottom: 10px;
    }

    h1 {
        font-size: 30px;
        margin-bottom: 8px;
    }

    .subtitle {
        color: #666;
        font-size: 15px;
        max-width: 420px;
    }

    .layout {
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

    .budget-card {
        border: 2px solid #14a800;
        border-radius: 12px;
        padding: 20px;
        width: 260px;
        margin-bottom: 30px;
        font-weight: bold;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .inputs {
        display: flex;
        gap: 30px;
        margin-bottom: 12px;
    }

    .input-group label {
        font-size: 14px;
        color: #555;
        display: block;
        margin-bottom: 6px;
    }

    .input-group input {
        width: 160px;
        padding: 10px;
        border-radius: 8px;
        border: 1px solid #ccc;
        font-size: 15px;
    }

    .note {
        font-size: 14px;
        color: #666;
        max-width: 450px;
        line-height: 1.4;
    }

    .footer {
        position: absolute;
        bottom: 30px;
        left: 40px;
        right: 40px;
        display: flex;
        justify-content: space-between;
    }

    button {
        padding: 12px 32px;
        border-radius: 25px;
        border: none;
        font-size: 15px;
        cursor: pointer;
    }

    .back {
        background: #eee;
    }

    .next {
        background: #14a800;
        color: white;
    }
</style>

</head>
<body>

<div class="container">

    <div class="reminder">
        💡 Just a reminder to publish your job post, you'll need to verify your phone number
    </div>

    <div class="step">4/5 &nbsp; Job post</div>

    <div class="layout">

        <!-- LEFT -->
        <div class="left">
            <h1>Tell us about your budget.</h1>
            <p class="subtitle">
                Set a fixed price for the entire project.
            </p>
        </div>

        <!-- RIGHT -->
        <form action="post_job_description.jsp" method="post" class="right">

            <div class="budget-card">
                🏷 Fixed Price Project
            </div>

            <div class="inputs">
                <div class="input-group">
                    <label>Minimum budget</label>
                    <input type="number" name="minBudget" placeholder="₹10,000" required>
                </div>

                <div class="input-group">
                    <label>Maximum budget</label>
                    <input type="number" name="maxBudget" placeholder="₹25,000" required>
                </div>
            </div>

            <div class="note">
                This helps freelancers understand your budget expectations.<br>
                Higher budgets generally attract more experienced professionals.
            </div>

            <div class="footer">
                <button type="button" class="back" onclick="history.back()">Back</button>
                <button type="submit" class="next">Next</button>
            </div>

        </form>

    </div>
</div>

</body>
</html>
