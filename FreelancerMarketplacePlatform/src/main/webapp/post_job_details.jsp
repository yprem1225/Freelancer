<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Scope</title>

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

    .step {
        font-size: 14px;
        color: #666;
        margin-bottom: 10px;
    }

    h1 {
        font-size: 30px;
        margin: 0 0 10px;
    }

    .subtitle {
        font-size: 15px;
        color: #666;
        max-width: 420px;
    }

    .layout {
        display: flex;
        gap: 60px;
        margin-top: 30px;
        height: calc(100% - 120px);
    }

    .left {
        width: 35%;
    }

    .right {
        width: 65%;
        display: grid;
        grid-template-columns: 1fr 1fr;
        column-gap: 40px;
        row-gap: 25px;
    }

    .section-title {
        font-size: 17px;
        font-weight: bold;
        margin-bottom: 12px;
    }

    .option-box {
        border: 1px solid #ddd;
        border-radius: 10px;
        padding: 14px 16px;
        margin-bottom: 10px;
        display: flex;
        gap: 12px;
        cursor: pointer;
        transition: 0.2s;
    }

    .option-box:hover {
        border-color: #14a800;
        background: #f4fff7;
    }

    .option-box input {
        margin-top: 4px;
    }

    .option-title {
        font-size: 15px;
        font-weight: bold;
    }

    .option-desc {
        font-size: 13px;
        color: #666;
        margin-top: 3px;
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

    <div class="step">3/5 &nbsp; Job post</div>

    <div class="layout">

        <!-- LEFT -->
        <div class="left">
            <h1>Next, estimate the scope of your work</h1>
            <p class="subtitle">
                Consider the size of your project and the time it will take.
            </p>
        </div>

        <!-- RIGHT -->
        <form action="post_job_budget.jsp" method="post" class="right">

            <!-- PROJECT COMPLEXITY -->
            <div>
                <div class="section-title">Project complexity</div>

                <label class="option-box">
                    <input type="radio" name="complexity" value="Large" required>
                    <div>
                        <div class="option-title">Large</div>
                        <div class="option-desc">Long-term or complex initiatives</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="complexity" value="Medium">
                    <div>
                        <div class="option-title">Medium</div>
                        <div class="option-desc">Well-defined projects with clear goals</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="complexity" value="Small">
                    <div>
                        <div class="option-title">Small</div>
                        <div class="option-desc">Quick tasks or minor improvements</div>
                    </div>
                </label>
            </div>

            <!-- DURATION -->
            <div>
                <div class="section-title">Estimated duration</div>

                <label class="option-box">
                    <input type="radio" name="duration" value="More than 6 months" required>
                    <div>
                        <div class="option-title">More than 6 months</div>
                        <div class="option-desc">Ongoing or long-term engagement</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="duration" value="3 to 6 months">
                    <div>
                        <div class="option-title">3 to 6 months</div>
                        <div class="option-desc">Mid-sized project with milestones</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="duration" value="1 to 3 months">
                    <div>
                        <div class="option-title">1 to 3 months</div>
                        <div class="option-desc">Short-term deliverables</div>
                    </div>
                </label>

                <div class="section-title" style="margin-top:18px;">Freelancer experience</div>

                <label class="option-box">
                    <input type="radio" name="experience" value="Fresher" required>
                    <div>
                        <div class="option-title">Fresher</div>
                        <div class="option-desc">New to freelancing, eager to learn</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="experience" value="Intermediate">
                    <div>
                        <div class="option-title">Intermediate</div>
                        <div class="option-desc">Some experience with similar projects</div>
                    </div>
                </label>

                <label class="option-box">
                    <input type="radio" name="experience" value="Expert">
                    <div>
                        <div class="option-title">Expert</div>
                        <div class="option-desc">Highly skilled specialist</div>
                    </div>
                </label>
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
