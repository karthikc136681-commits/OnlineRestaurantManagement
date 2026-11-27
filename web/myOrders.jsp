<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.Order"%>

<%
    // Check whether the user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");

    // Only CUSTOMER can access this page
    if (!"CUSTOMER".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>

<head>

    <title>My Orders</title>

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

        .back-dashboard {
            color: white;
            text-decoration: none;
            background-color: #a52a2a;
            padding: 10px 18px;
            border-radius: 6px;
        }

        .back-dashboard:hover {
            background-color: #b83232;
        }

        /* CONTAINER */

        .container {
            width: 92%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .title-section {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px #cccccc;
            margin-bottom: 25px;
        }

        .title-section h1 {
            margin-top: 0;
            color: #8B0000;
        }

        .title-section p {
            color: #666666;
        }

        /* ORDER CARD */

        .order-card {
            background-color: white;
            margin-bottom: 25px;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px #cccccc;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dddddd;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .order-id {
            color: #8B0000;
            font-size: 20px;
            font-weight: bold;
        }

        .status {
            padding: 8px 14px;
            border-radius: 20px;
            background-color: #fff3cd;
            color: #856404;
            font-weight: bold;
        }

        .details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .detail {
            background-color: #fafafa;
            padding: 15px;
            border-radius: 8px;
        }

        .detail strong {
            display: block;
            color: #8B0000;
            margin-bottom: 5px;
        }

        .amount {
            font-size: 20px;
            font-weight: bold;
        }

        /* EMPTY */

        .empty {
            background-color: white;
            padding: 50px;
            text-align: center;
            border-radius: 12px;
            box-shadow: 0 2px 10px #cccccc;
        }

        .empty h2 {
            color: #8B0000;
        }

        .menu-button {
            display: inline-block;
            margin-top: 15px;
            padding: 11px 20px;
            background-color: #8B0000;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .menu-button:hover {
            background-color: #a00000;
        }

        /* FOOTER */

        .footer {
            text-align: center;
            margin-top: 60px;
            padding: 20px;
            color: #777777;
        }

        /* MOBILE */

        @media (max-width: 700px) {

            .header {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

        }

    </style>

</head>

<body>


<!-- HEADER -->

<div class="header">

    <div class="logo">
        🍴 Online Restaurant
    </div>

    <a href="customerDashboard.jsp"
       class="back-dashboard">

        ← Dashboard

    </a>

</div>


<!-- MAIN -->

<div class="container">

    <div class="title-section">

        <h1>
            📦 My Orders
        </h1>

        <p>
            View your orders and check their current status.
        </p>

    </div>


<%

    if (orderList != null && !orderList.isEmpty()) {

        for (Order order : orderList) {

%>


    <!-- ORDER CARD -->

    <div class="order-card">

        <div class="order-header">

            <div class="order-id">

                Order #<%= order.getOrderId() %>

            </div>

            <div class="status">

                <%= order.getOrderStatus() %>

            </div>

        </div>


        <div class="details">


            <div class="detail">

                <strong>
                    Order Date
                </strong>

                <%= order.getOrderDate() %>

            </div>


            <div class="detail">

                <strong>
                    Total Amount
                </strong>

                <span class="amount">

                    ₹<%= order.getTotalAmount() %>

                </span>

            </div>


            <div class="detail">

                <strong>
                    Delivery Address
                </strong>

                <%= order.getDeliveryAddress() %>

            </div>


            <div class="detail">

                <strong>
                    Payment Method
                </strong>

                <%= order.getPaymentMethod() %>

            </div>


        </div>

    </div>


<%

        }

    } else {

%>


    <!-- NO ORDERS -->

    <div class="empty">

        <h2>
            📦 No Orders Yet
        </h2>

        <p>
            You haven't placed any orders yet.
        </p>

        <a href="foods" class="menu-button">
            🍽️ Browse Food Menu
        </a>

    </div>


<%

    }

%>


</div>


<!-- FOOTER -->

<div class="footer">

    Online Restaurant Management System

</div>


</body>

</html>
