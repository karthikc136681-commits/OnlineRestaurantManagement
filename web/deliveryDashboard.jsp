
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Check whether the user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");

    // Only DELIVERY can access this page
    if (!"DELIVERY".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delivery Dashboard</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #fff3e0, #ffe0b2, #ffccbc);
            color: #333;
        }

        .header {
            background-color: #8B0000;
            color: white;
            padding: 22px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 30px;
        }

        .container {
            max-width: 850px;
            margin: 60px auto;
            padding: 20px;
        }

        .welcome-card {
            background-color: white;
            padding: 35px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.12);
        }

        .welcome-card h2 {
            color: #8B0000;
            margin-top: 0;
        }

        .welcome-card p {
            font-size: 16px;
            line-height: 1.6;
        }

        .panel {
            margin-top: 30px;
            padding: 25px;
            background-color: #fffaf5;
            border-radius: 12px;
            border: 1px solid #f0d5c5;
        }

        .panel h3 {
            color: #8B0000;
            margin-top: 0;
        }

        .button {
            display: inline-block;
            padding: 13px 22px;
            margin: 10px 8px 0;
            text-decoration: none;
            color: white;
            background-color: #8B0000;
            border-radius: 7px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #b22222;
        }

        .logout {
            background-color: #555;
        }

        .logout:hover {
            background-color: #333;
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #555;
        }

        @media (max-width: 600px) {
            .container {
                margin: 25px auto;
                padding: 15px;
            }

            .welcome-card {
                padding: 25px 15px;
            }

            .button {
                display: block;
                margin: 12px 0;
            }
        }
    </style>
</head>

<body>

    <div class="header">
        <h1>Online Restaurant</h1>
        <p>Delivery Staff Dashboard</p>
    </div>

    <div class="container">

        <div class="welcome-card">
            <h2>Welcome, <%= name %>!</h2>

            <p>
                You are logged in as Delivery Staff.
            </p>

            <p>
                Manage your assigned deliveries and check the orders
                that are ready for delivery.
            </p>

            <div class="panel">
                <h3>Delivery Panel</h3>

                <p>
                    View the orders assigned for delivery.
                </p>

                <a class="button"
                   href="<%= request.getContextPath() %>/deliveryOrders">
                    View Orders for Delivery
                </a>

                <a class="button logout"
                   href="<%= request.getContextPath() %>/logout">
                    Logout
                </a>
            </div>
        </div>

    </div>

    <div class="footer">
        &copy; 2026 Online Restaurant Management System
    </div>

</body>
</html>