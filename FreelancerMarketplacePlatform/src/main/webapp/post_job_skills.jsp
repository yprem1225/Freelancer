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
            max-width: 700px;
        }

        /* 🔍 SEARCH BAR */
        .search-box {
            margin-bottom: 20px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 14px;
        }

        /* SKILLS */
        .skills {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .skill-pill {
            cursor: pointer;
        }

        .skill-pill input {
            display: none;
        }

        .skill-pill span {
            display: inline-block;
            padding: 8px 14px;
            border: 1px solid #d1d5db;
            border-radius: 999px;
            font-size: 14px;
            background: #ffffff;
            transition: all 0.2s ease;
        }

        /* 🖤 SELECTED = BLACK */
        .skill-pill input:checked + span {
            background: #000000;
            color: #ffffff;
            border-color: #000000;
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

        <!-- 🔍 SEARCH BAR (UI ONLY) -->
        <div class="search-box">
            <input type="text" id="skillSearch" placeholder="Search skills or add your own">
        </div>

        <!-- ⭐ POPULAR SKILLS -->
        <div class="skills" id="skillsContainer">

            <!-- DESIGN -->
            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Web Design">
                <span>Web Design</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Graphic Design">
                <span>Graphic Design</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Logo Design">
                <span>Logo Design</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="UI/UX Design">
                <span>UI / UX Design</span>
            </label>

            <!-- DEVELOPMENT -->
            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Java">
                <span>Java</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Spring">
                <span>Spring</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="SQL">
                <span>SQL</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="JavaScript">
                <span>JavaScript</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="HTML">
                <span>HTML</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="CSS">
                <span>CSS</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="React">
                <span>React</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Node.js">
                <span>Node.js</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Python">
                <span>Python</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Django">
                <span>Django</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Flask">
                <span>Flask</span>
            </label>

            <!-- MOBILE -->
            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Android">
                <span>Android</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Kotlin">
                <span>Kotlin</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Flutter">
                <span>Flutter</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="iOS">
                <span>iOS</span>
            </label>

            <!-- OTHER -->
            <label class="skill-pill">
                <input type="checkbox" name="skills" value="WordPress">
                <span>WordPress</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="SEO">
                <span>SEO</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Content Writing">
                <span>Content Writing</span>
            </label>

            <label class="skill-pill">
                <input type="checkbox" name="skills" value="Digital Marketing">
                <span>Digital Marketing</span>
            </label>

        </div>

        <div class="actions">
            <!-- BACK BUTTON (UNCHANGED) -->
            <a class="back-btn"
               href="${pageContext.request.contextPath}/PostJobTitleServlet">
                ← Back
            </a>

            <!-- NEXT BUTTON (UNCHANGED) -->
            <button class="next-btn" type="submit">
                Next → Scope
            </button>
        </div>

    </form>
</div>

<!-- 🔍 SIMPLE SEARCH FILTER (UI ONLY) -->
<script>
    const searchInput = document.getElementById("skillSearch");
    const skills = document.querySelectorAll(".skill-pill");

    searchInput.addEventListener("keyup", function () {
        const value = this.value.toLowerCase();

        skills.forEach(skill => {
            const text = skill.innerText.toLowerCase();
            skill.style.display = text.includes(value) ? "inline-block" : "none";
        });
    });
</script>

</body>
</html>
