<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.Order"%>

<%
    // Check login
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

    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Delivery Orders</title>

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

        select {
            padding: 7px;
        }

        button {
            padding: 7px 12px;
            background-color: #8B0000;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #600000;
        }

        .empty {
            background-color: white;
            padding: 30px;
            text-align: center;
            box-shadow: 0 2px 8px #cccccc;
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

    </style>

</head>

<body>

<div class="header">

    <h1>Online Restaurant</h1>

    <h3>Welcome, <%= name %>!</h3>

    <p>Delivery Staff Panel</p>

</div>


<div class="container">

    <h2>Orders for Delivery</h2>

    <%
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
            <th>Current Status</th>
            <th>Update Status</th>

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

            <td>
                <%= order.getOrderStatus() %>
            </td>

            <td>

    <% if ("Ready for Delivery".equals(order.getOrderStatus())) { %>

        <form action="deliveryOrders" method="post">

            <input type="hidden"
                   name="action"
                   value="updateStatus">

            <input type="hidden"
                   name="orderId"
                   value="<%= order.getOrderId() %>">

            <input type="hidden"
                   name="status"
                   value="Out for Delivery">

            <button type="submit">
                Start Delivery
            </button>

        </form>

    <% } else if ("Out for Delivery".equals(order.getOrderStatus())) { %>

        <form action="deliveryOrders" method="post">

            <input type="hidden"
                   name="action"
                   value="updateStatus">

            <input type="hidden"
                   name="orderId"
                   value="<%= order.getOrderId() %>">

            <input type="hidden"
                   name="status"
                   value="Delivered">

            <button type="submit">
                Mark as Delivered
            </button>

        </form>

    <% } else if ("Delivered".equals(order.getOrderStatus())) { %>

        <strong>Delivered ✓</strong>

    <% } else { %>

        <span>Waiting for Staff</span>

    <% } %>

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

        <h3>No orders available.</h3>

        <p>
            There are currently no orders ready for delivery.
        </p>

    </div>

    <%
        }
    %>


    <a href="deliveryDashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

</body>

</html>