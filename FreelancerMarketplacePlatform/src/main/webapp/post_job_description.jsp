<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Post Job - Project Description</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            margin-bottom: 10px;
        }

        p {
            color: #555;
            font-size: 14px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 20px;
        }

        textarea, input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .btn-container {
            text-align: right;
            margin-top: 30px;
        }

        .submit-btn {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 25px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Project Description</h2>
    <p>
        Describe your project clearly so freelancers understand your requirements.
        (Clear description = better proposals 👍)
    </p>

    <form action="home.jsp" method="post">

        <label for="description">Project Description</label>
        <textarea id="description" name="description"
                  placeholder="Explain your project in detail..."></textarea>

        <label for="requirements">Key Requirements</label>
        <textarea id="requirements" name="requirements"
                  placeholder="Mention skills, tools, technologies, or expectations"></textarea>

        <label for="deliverables">Expected Deliverables</label>
        <textarea id="deliverables" name="deliverables"
                  placeholder="What should be delivered at the end of the project?"></textarea>

        <div class="btn-container">
            <button type="submit" class="submit-btn">Submit Job</button>
        </div>

    </form>
</div>

</body>
</html>
