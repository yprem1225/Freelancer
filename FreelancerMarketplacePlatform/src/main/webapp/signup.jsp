<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Signup | Freelancer Marketplace</title>

    <!-- MDB / Bootstrap CSS -->
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.css"
        rel="stylesheet"
    />

    <!-- Font Awesome -->
    <link
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        rel="stylesheet"
    />

    <style>
        .background-radial-gradient {
            background-color: hsl(218, 41%, 15%);
            background-image: radial-gradient(650px circle at 0% 0%,
                hsl(218, 41%, 35%) 15%,
                hsl(218, 41%, 30%) 35%,
                hsl(218, 41%, 20%) 75%,
                hsl(218, 41%, 19%) 80%,
                transparent 100%),
            radial-gradient(1250px circle at 100% 100%,
                hsl(218, 41%, 45%) 15%,
                hsl(218, 41%, 30%) 35%,
                hsl(218, 41%, 20%) 75%,
                hsl(218, 41%, 19%) 80%,
                transparent 100%);
        }

        #radius-shape-1 {
            height: 220px;
            width: 220px;
            top: -60px;
            left: -130px;
            background: radial-gradient(#44006b, #ad1fff);
        }

        #radius-shape-2 {
            border-radius: 38% 62% 63% 37% / 70% 33% 67% 30%;
            bottom: -60px;
            right: -110px;
            width: 300px;
            height: 300px;
            background: radial-gradient(#44006b, #ad1fff);
        }

        .bg-glass {
            background-color: hsla(0, 0%, 100%, 0.9) !important;
            backdrop-filter: saturate(200%) blur(25px);
        }
    </style>
</head>

<body>

<%
    String role = request.getParameter("type");
    if (role == null) {
        role = "freelancer";
    }
%>

<section class="background-radial-gradient overflow-hidden">
    <div class="container px-4 py-5 px-md-5 text-center text-lg-start my-5">
        <div class="row gx-lg-5 align-items-center mb-5">

            <!-- LEFT CONTENT -->
            <div class="col-lg-6 mb-5 mb-lg-0">
                <h1 class="my-5 display-5 fw-bold ls-tight text-light">
                    Join as a <br />
                    <span style="color: hsl(218, 81%, 75%)"><%= role %></span>
                </h1>
                <p class="opacity-70 text-light">
                    Create your account and start your journey today.
                </p>
            </div>

            <!-- RIGHT CARD -->
            <div class="col-lg-6 mb-5 mb-lg-0 position-relative">
                <div id="radius-shape-1" class="position-absolute rounded-circle"></div>
                <div id="radius-shape-2" class="position-absolute"></div>

                <div class="card bg-glass">
                    <div class="card-body px-4 py-5 px-md-5">

                        <!-- ERROR MESSAGE -->
                        <%
                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                        %>
                            <div class="alert alert-danger"><%= error %></div>
                        <%
                            }
                        %>

                        <!-- SIGNUP FORM -->
                        <form action="SignupServlet" method="post">

                            <!-- ROLE -->
                            <input type="hidden" name="role" value="<%= role %>">

                            <!-- NAME -->
                            <div class="form-outline mb-4">
                                <input type="text" name="name" class="form-control" required />
                                <label class="form-label">Full Name</label>
                            </div>

                            <!-- EMAIL -->
                            <div class="form-outline mb-4">
                                <input type="email" name="email" class="form-control" required />
                                <label class="form-label">Email address</label>
                            </div>

                            <!-- PASSWORD -->
                            <div class="form-outline mb-4">
                                <input type="password" name="password" class="form-control" required />
                                <label class="form-label">Password</label>
                            </div>

                            <button type="submit" class="btn btn-primary btn-block mb-4">
                                Sign up
                            </button>

                            <div class="text-center">
                                <p>Already have an account?
                                    <a href="login.jsp?type=<%= role %>">Login</a>
                                </p>
                            </div>

                        </form>

                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.0/mdb.min.js"></script>

</body>
</html>
