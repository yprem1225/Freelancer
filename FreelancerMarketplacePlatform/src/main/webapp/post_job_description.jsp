<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Description</title>

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

    .layout {
        display: flex;
        gap: 70px;
        margin-top: 25px;
    }

    .left {
        width: 40%;
    }

    .right {
        width: 60%;
    }

    h1 {
        font-size: 32px;
        margin-bottom: 12px;
    }

    textarea {
        width: 100%;
        height: 260px;
        padding: 14px;
        font-size: 15px;
        border-radius: 10px;
        border: 2px solid #ccc;
        resize: none;
    }

    textarea:focus {
        border-color: #14a800;
        outline: none;
    }

    .error {
        color: #d93025;
        font-size: 13px;
        display: none;
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
        padding: 12px 34px;
        border-radius: 25px;
        border: none;
        font-size: 15px;
        cursor: pointer;
    }

    .back {
        background: #eee;
    }

    .submit {
        background: #14a800;
        color: white;
    }
</style>

<script>
    function validateForm() {
        const desc = document.getElementById("description");
        const error = document.getElementById("error");

        if (desc.value.trim().length < 50) {
            error.style.display = "block";
            return false;
        }
        return true;
    }
</script>

</head>
<body>

<div class="container">

    <div class="reminder">
        💡 Just a reminder to publish your job post, you'll need to verify your phone number
    </div>

    <div class="step">5/5 &nbsp; Job post</div>

    <div class="layout">

        <!-- LEFT -->
        <div class="left">
            <h1>Start the conversation.</h1>
            <p>Describe your project clearly so freelancers understand your needs.</p>
        </div>

        <!-- RIGHT -->
        <form class="right" action="PostJobServlet" method="post" onsubmit="return validateForm()">

            <label><b>Describe what you need</b></label><br><br>

            <textarea id="description" name="description"
                placeholder="Describe your project here..."></textarea>

            <div id="error" class="error">
                Description must be at least 50 characters.
            </div>

            <div class="footer">
                <button type="button" class="back" onclick="history.back()">Back</button>
                <button type="submit" class="submit">Submit</button>
            </div>

        </form>

    </div>
</div>

</body>
</html>
