
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Order" %>
<%@ page import="com.restaurant.model.User" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<User> deliveryStaff =
            (List<User>) request.getAttribute("deliveryStaff");

    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");

    int totalStaff = deliveryStaff == null ? 0 : deliveryStaff.size();
    int readyCount = 0;
    int outCount = 0;
    int deliveredCount = 0;

    if (orderList != null) {
        for (Order order : orderList) {
            if ("Ready for Delivery".equals(order.getOrderStatus())) {
                readyCount++;
            } else if ("Out for Delivery".equals(order.getOrderStatus())) {
                outCount++;
            } else if ("Delivered".equals(order.getOrderStatus())) {
                deliveredCount++;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Delivery</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #fff3e0, #ffccbc, #ffe0b2);
            color: #333;
        }

        .header {
            background: #8B0000;
            color: white;
            text-align: center;
            padding: 22px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 94%;
            max-width: 1250px;
            margin: 30px auto;
        }

        .back {
            display: inline-block;
            margin-bottom: 20px;
            padding: 11px 17px;
            background: #555;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back:hover {
            background: #333;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 18px;
            margin-bottom: 25px;
        }

        .summary-card {
            background: white;
            padding: 22px;
            border-radius: 10px;
            box-shadow: 0 3px 10px #00000018;
        }

        .summary-card h3 {
            margin: 0 0 10px;
            color: #666;
            font-size: 15px;
        }

        .summary-card p {
            margin: 0;
            color: #8B0000;
            font-size: 28px;
            font-weight: bold;
        }

        .section {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 10px #00000018;
            overflow-x: auto;
        }

        h2 {
            margin-top: 0;
            color: #8B0000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th {
            background: #8B0000;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #fff5f5;
        }

        .status {
            font-weight: bold;
        }

        .empty {
            padding: 20px;
            text-align: center;
            background: #fff8f3;
            border-radius: 7px;
        }

        @media (max-width: 600px) {
            .container {
                width: 96%;
            }

            .section {
                padding: 15px;
            }
        }
    </style>
</head>

<body>

<div class="header">
    <h1>Manage Delivery</h1>
    <p>Online Restaurant Management System</p>
</div>

<div class="container">

    <a class="back"
       href="<%= request.getContextPath() %>/adminDashboard.jsp">
        &#8592; Back to Admin Dashboard
    </a>

    <div class="summary">

        <div class="summary-card">
            <h3>Delivery Staff</h3>
            <p><%= totalStaff %></p>
        </div>

        <div class="summary-card">
            <h3>Ready for Delivery</h3>
            <p><%= readyCount %></p>
        </div>

        <div class="summary-card">
            <h3>Out for Delivery</h3>
            <p><%= outCount %></p>
        </div>

        <div class="summary-card">
            <h3>Delivered Orders</h3>
            <p><%= deliveredCount %></p>
        </div>

    </div>

    <div class="section">

        <h2>Registered Delivery Staff</h2>

        <% if (deliveryStaff != null && !deliveryStaff.isEmpty()) { %>

            <table>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                </tr>

                <% for (User staff : deliveryStaff) { %>
                    <tr>
                        <td><%= staff.getUserId() %></td>
                        <td><%= staff.getName() %></td>
                        <td><%= staff.getEmail() %></td>
                        <td><%= staff.getPhone() %></td>
                        <td><%= staff.getRole() %></td>
                    </tr>
                <% } %>
            </table>

        <% } else { %>

            <div class="empty">
                No delivery staff accounts were found.
            </div>

        <% } %>

    </div>

    <div class="section">

        <h2>Delivery Order Overview</h2>

        <% if (orderList != null && !orderList.isEmpty()) { %>

            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Customer ID</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Delivery Address</th>
                    <th>Payment Method</th>
                    <th>Current Status</th>
                </tr>

                <% for (Order order : orderList) { %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= order.getUserId() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td>₹<%= order.getTotalAmount() %></td>
                        <td><%= order.getDeliveryAddress() %></td>
                        <td><%= order.getPaymentMethod() %></td>
                        <td class="status">
                            <%= order.getOrderStatus() %>
                        </td>
                    </tr>
                <% } %>
            </table>

        <% } else { %>

            <div class="empty">
                No orders were found.
            </div>

        <% } %>

    </div>

</div>

</body>
</html>