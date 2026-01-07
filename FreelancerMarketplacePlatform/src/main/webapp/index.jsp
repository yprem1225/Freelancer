<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Join | Freelancer Marketplace</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            text-align: center;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-top: 80px;
        }

        h1 {
            font-size: 32px;
            margin-bottom: 40px;
        }

        .cards {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .card {
            width: 260px;
            height: 160px;
            border: 2px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .card:hover {
            border-color: #14a800;
        }

        .card.selected {
            border-color: #14a800;
        }

        .radio {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 18px;
            height: 18px;
            border: 2px solid #999;
            border-radius: 50%;
        }

        .card.selected .radio {
            border-color: #14a800;
            background-color: #14a800;
        }

        .card h3 {
            margin-top: 40px;
            font-size: 18px;
        }

        .join-btn {
            margin-top: 40px;
            padding: 12px 30px;
            background-color: #14a800;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .join-btn:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .login-link {
            margin-top: 20px;
            font-size: 14px;
        }

        .login-link a {
            color: #14a800;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">

    <h1>Join as a client or freelancer</h1>

    <div class="cards">

        <div class="card" onclick="selectRole('client')" id="clientCard">
            <div class="radio"></div>
            <h3>I’m a client, hiring for a project</h3>
        </div>

        <div class="card" onclick="selectRole('freelancer')" id="freelancerCard">
            <div class="radio"></div>
            <h3>I’m a freelancer, looking for work</h3>
        </div>

    </div>

    <button class="join-btn" id="joinBtn" onclick="goSignup()" disabled>
        Join
    </button>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Log In</a>
    </div>

</div>

<script>
    let selectedRole = "";

    function selectRole(role) {
        selectedRole = role;

        document.getElementById("clientCard").classList.remove("selected");
        document.getElementById("freelancerCard").classList.remove("selected");

        document.getElementById(role + "Card").classList.add("selected");

        document.getElementById("joinBtn").disabled = false;
        document.getElementById("joinBtn").innerText =
            role === "client" ? "Join as a Client" : "Join as a Freelancer";
    }

    function goSignup() {
        if (selectedRole !== "") {
            window.location.href = "signup.jsp?type=" + selectedRole;
        }
    }
</script>

</body>
</html>
