<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Post Job – Skills</title>

<style>
    body {
        font-family: Arial, sans-serif;
        background: #fff;
        margin: 0;
    }

    .container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 20px;
    }

    .step {
        font-size: 14px;
        color: #666;
    }

    h1 {
        font-size: 32px;
        margin: 10px 0 25px;
    }

    .layout {
        display: flex;
        gap: 60px;
    }

    .left { flex: 1; }
    .right { flex: 1; }

    /* SEARCH */
    .search {
        position: relative;
        margin-bottom: 10px;
    }

    .search input {
        width: 100%;
        padding: 12px 40px;
        border-radius: 25px;
        border: 1px solid #ccc;
        font-size: 16px;
    }

    .search::before {
        content: "🔍";
        position: absolute;
        left: 14px;
        top: 11px;
    }

    .hint {
        font-size: 14px;
        color: #777;
        margin-bottom: 15px;
    }

    /* SELECTED SKILLS */
    .selected-title {
        font-weight: bold;
        margin: 20px 0 10px;
    }

    .selected-skills {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-bottom: 25px;
    }

    .selected-skill {
        background: #000;
        color: #fff;
        padding: 8px 14px;
        border-radius: 20px;
        font-size: 14px;
        cursor: pointer;
    }

    /* POPULAR SKILLS */
    .skills {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .skill {
        border: 1px solid #ccc;
        border-radius: 20px;
        padding: 8px 14px;
        cursor: pointer;
        font-size: 14px;
    }

    .skill:hover {
        border-color: #14a800;
        background: #f3fff7;
    }

    .footer {
        margin-top: 40px;
        display: flex;
        justify-content: space-between;
    }

    button {
        padding: 12px 26px;
        border-radius: 25px;
        border: none;
        cursor: pointer;
        font-size: 16px;
    }

    .back {
        background: #eee;
    }

    .next {
        background: #14a800;
        color: #fff;
    }
</style>

<script>
    let selected = [];

    function addSkill(skill) {
        if (selected.includes(skill)) return;

        if (selected.length >= 5) {
            alert("Please select up to 5 skills only");
            return;
        }

        selected.push(skill);
        updateUI();
    }

    function removeSkill(skill) {
        selected = selected.filter(s => s !== skill);
        updateUI();
    }

    function updateUI() {
        const container = document.getElementById("selectedSkills");
        container.innerHTML = "";

        selected.forEach(skill => {
            const div = document.createElement("div");
            div.className = "selected-skill";
            div.innerHTML = skill + " ✕";
            div.onclick = () => removeSkill(skill);
            container.appendChild(div);
        });

        document.getElementById("skillsInput").value = selected.join(",");
    }

    function addCustomSkill(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            const val = e.target.value.trim();
            if (val !== "") {
                addSkill(val);
                e.target.value = "";
            }
        }
    }
</script>
</head>

<body>

<div class="container">

    <div class="step">2/5 &nbsp; Job post</div>

    <div class="layout">

        <!-- LEFT -->
        <div class="left">
            <h1>What are the main skills required for your work?</h1>
        </div>

        <!-- RIGHT -->
        <div class="right">

            <div class="search">
                <input type="text" placeholder="Search skills or add your own"
                       onkeydown="addCustomSkill(event)">
            </div>

            <div class="hint">For the best results, add 3–5 skills</div>

            <div class="selected-title">Selected skills</div>
            <div class="selected-skills" id="selectedSkills"></div>

            <div class="selected-title">Popular skills</div>

            <div class="skills">
                <div class="skill" onclick="addSkill('Graphic Design')">Graphic Design +</div>
                <div class="skill" onclick="addSkill('Adobe Photoshop')">Adobe Photoshop +</div>
                <div class="skill" onclick="addSkill('Content Writing')">Content Writing +</div>
                <div class="skill" onclick="addSkill('Web Design')">Web Design +</div>
                <div class="skill" onclick="addSkill('HTML')">HTML +</div>
                <div class="skill" onclick="addSkill('CSS')">CSS +</div>
                <div class="skill" onclick="addSkill('JavaScript')">JavaScript +</div>
                <div class="skill" onclick="addSkill('WordPress')">WordPress +</div>
                <div class="skill" onclick="addSkill('PHP')">PHP +</div>
            </div>

            <form action="post_job_details.jsp" method="post">
                <input type="hidden" name="skills" id="skillsInput">

                <div class="footer">
                    <button type="button" class="back" onclick="history.back()">Back</button>
                    <button type="submit" class="next">Next</button>
                </div>
            </form>

        </div>
    </div>
</div>

</body>
</html>
