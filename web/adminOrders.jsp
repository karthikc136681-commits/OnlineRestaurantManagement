<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Order" %>

<!DOCTYPE html>
<html>
<head>

    <title>Manage Orders</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
        }

        .header {
            background-color: #8B0000;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .container {
            width: 95%;
            margin: 30px auto;
        }

        h2 {
            color: #8B0000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px #cccccc;
        }

        th {
            background-color: #8B0000;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #dddddd;
        }

        tr:hover {
            background-color: #f9eeee;
        }

        .status {
            font-weight: bold;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 15px;
            background-color: #8B0000;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .empty {
            background-color: white;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 8px #cccccc;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Online Restaurant</h1>

    <p>Admin Order Management</p>

</div>


<div class="container">

    <h2>Manage Orders</h2>

    <%

        List<Order> orderList =
                (List<Order>) request.getAttribute("orderList");

        if (orderList != null && !orderList.isEmpty()) {

    %>

    <table>

        <tr>

            <th>Order ID</th>
            <th>Customer ID</th>
            <th>Order Date</th>
            <th>Total Amount</th>
            <th>Delivery Address</th>
            <th>Payment Method</th>
            <th>Order Status</th>

        </tr>

        <%

            for (Order order : orderList) {

        %>

        <tr>

            <td>
                <%= order.getOrderId() %>
            </td>

            <td>
                <%= order.getUserId() %>
            </td>

            <td>
                <%= order.getOrderDate() %>
            </td>

            <td>
                ₹<%= order.getTotalAmount() %>
            </td>

            <td>
                <%= order.getDeliveryAddress() %>
            </td>

            <td>
                <%= order.getPaymentMethod() %>
            </td>

            <td class="status">
                <%= order.getOrderStatus() %>
            </td>

        </tr>

        <%

            }

        %>

    </table>

    <%

        } else {

    %>

        <div class="empty">

            <h3>No orders found.</h3>

            <p>
                There are currently no customer orders.
            </p>

        </div>

    <%

        }

    %>


    <a href="adminDashboard.jsp" class="back">
        ← Back to Admin Dashboard
    </a>

</div>

</body>
</html>