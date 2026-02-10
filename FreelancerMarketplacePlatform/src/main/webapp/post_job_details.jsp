<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <title>Post Job - Details</title>
    <style>
        body { font-family: Arial; background:#f7f7f7; }
        .container { width: 800px; margin: auto; background: #fff; padding: 30px; }
        h2 { margin-bottom: 5px; }
        .card-group { display: flex; gap: 15px; margin-bottom: 25px; }
        .card {
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            flex: 1;
            cursor: pointer;
        }
        .card input { margin-right: 10px; }
        .card:hover { border-color: green; }
        textarea { width: 100%; height: 80px; }
        .actions { display:flex; justify-content: space-between; margin-top: 20px; }
        .btn { padding:10px 20px; border:none; cursor:pointer; }
        .btn-next { background:green; color:white; }
        .btn-back { background:#ddd; }
    </style>
</head>

<body>
<div class="container">
    <h2>STEP 3 OF 5</h2>
    <p><b>Job ID:</b> ${job.jobId}</p>

    <form method="post">

        <h3>1. Estimate the scope of your work</h3>
        <div class="card-group">
            <label class="card">
                <input type="radio" name="complexity" value="Small"
                    ${job.complexity == 'Small' ? 'checked' : ''}
                    required>
                <b>Small</b><br>
                Quick and straightforward tasks
            </label>

            <label class="card">
                <input type="radio" name="complexity" value="Medium"
                    ${job.complexity == 'Medium' ? 'checked' : ''}>
                <b>Medium</b><br>
                Well-defined projects with multiple deliverables
            </label>

            <label class="card">
                <input type="radio" name="complexity" value="Large"
                    ${job.complexity == 'Large' ? 'checked' : ''}>
                <b>Large</b><br>
                Long-term or complex initiatives
            </label>
        </div>

        <h3>2. Project duration</h3>
        <div class="card-group">
            <label class="card">
                <input type="radio" name="duration" value="Less than 1 month"
                    ${job.duration == 'Less than 1 month' ? 'checked' : ''}
                    required>
                Less than 1 month
            </label>

            <label class="card">
                <input type="radio" name="duration" value="1 to 3 months"
                    ${job.duration == '1 to 3 months' ? 'checked' : ''}>
                1 to 3 months
            </label>

            <label class="card">
                <input type="radio" name="duration" value="3 to 6 months"
                    ${job.duration == '3 to 6 months' ? 'checked' : ''}>
                3 to 6 months
            </label>
        </div>

        <h3>3. Experience level required</h3>
        <div class="card-group">
            <label class="card">
                <input type="radio" name="freelancerLevel" value="Fresher"
                    ${job.freelancerLevel == 'Fresher' ? 'checked' : ''}
                    required>
                Fresher – Entry level
            </label>

            <label class="card">
                <input type="radio" name="freelancerLevel" value="Intermediate"
                    ${job.freelancerLevel == 'Intermediate' ? 'checked' : ''}>
                Intermediate – Some experience
            </label>

            <label class="card">
                <input type="radio" name="freelancerLevel" value="Expert"
                    ${job.freelancerLevel == 'Expert' ? 'checked' : ''}>
                Expert – Highly experienced
            </label>
        </div>

        

        <div class="actions">
            <a href="PostJobSkillsServlet">
                <button type="button" class="btn btn-back">← Back</button>
            </a>
            <button type="submit" class="btn btn-next">Next →</button>
        </div>

    </form>
</div>
</body>
</html>
