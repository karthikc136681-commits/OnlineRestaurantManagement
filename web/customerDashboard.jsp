<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check whether the user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    // Only CUSTOMER can access this page
    if (!"CUSTOMER".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <title>Customer Dashboard</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            color: #333333;
        }

        /* HEADER */

        .header {
            background-color: #8B0000;
            color: white;
            padding: 25px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
        }

        .logout {
            color: white;
            text-decoration: none;
            background-color: #a52a2a;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .logout:hover {
            background-color: #b83232;
        }

        /* MAIN */

        .container {
            width: 90%;
            max-width: 1100px;
            margin: 40px auto;
        }

        .welcome {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px #cccccc;
            margin-bottom: 30px;
        }

        .welcome h1 {
            margin-top: 0;
            color: #8B0000;
        }

        .welcome p {
            color: #666666;
            font-size: 16px;
        }

        /* CARDS */

        .menu-title {
            color: #8B0000;
            margin-bottom: 20px;
        }

        .cards {
            display: flex;
            gap: 25px;
            flex-wrap: wrap;
        }

        .card {
            background-color: white;
            width: 300px;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px #cccccc;
            text-align: center;
            transition: 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px #bbbbbb;
        }

        .icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .card h3 {
            color: #8B0000;
            margin-bottom: 10px;
        }

        .card p {
            color: #666666;
            min-height: 45px;
        }

        .button {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 20px;
            background-color: #8B0000;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .button:hover {
            background-color: #a00000;
        }

        /* FOOTER */

        .footer {
            text-align: center;
            margin-top: 60px;
            padding: 20px;
            color: #777777;
        }

    </style>

</head>

<body>

    <!-- HEADER -->

    <div class="header">

        <div class="logo">
            🍴 Online Restaurant
        </div>

        <a href="logout" class="logout">
            Logout
        </a>

    </div>


    <!-- MAIN CONTENT -->

    <div class="container">

        <div class="welcome">

            <h1>
                Welcome, <%= name %>! 👋
            </h1>

            <p>
                You are logged in as a Customer.
            </p>

            <p>
                Explore our delicious menu and manage your orders easily.
            </p>

        </div>


        <h2 class="menu-title">
            Customer Menu
        </h2>


        <div class="cards">


            <!-- VIEW FOOD MENU -->

            <div class="card">

                <div class="icon">
                    🍽️
                </div>

                <h3>
                    Food Menu
                </h3>

                <p>
                    Browse delicious food and add your favorite items to your cart.
                </p>

                <a href="foods" class="button">
                    View Food Menu
                </a>

            </div>


            <!-- MY ORDERS -->

            <div class="card">

                <div class="icon">
                    📦
                </div>

                <h3>
                    My Orders
                </h3>

                <p>
                    View your previous orders and check their current status.
                </p>

                <a href="myOrders" class="button">
                    View My Orders
                </a>

            </div>


        </div>

    </div>


    <!-- FOOTER -->

    <div class="footer">

        Online Restaurant Management System

    </div>

</body>
</html>