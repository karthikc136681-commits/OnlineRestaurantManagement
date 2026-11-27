<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Order" %>
<%@ page import="com.restaurant.model.OrderItem" %>

<%
    List<Order> orderList =
            (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>

<html>

<head>

    <title>Staff Orders</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 40px;
        }

        .welcome {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.15);
            margin-bottom: 30px;
        }

        .welcome h1 {
            color: #a00000;
            margin-top: 0;
        }

        h2 {
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0,0,0,0.15);
        }

        th {
            background: #a00000;
            color: white;
            padding: 15px;
            text-align: center;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        tr:hover {
            background: #f9f9f9;
        }

        select {
            padding: 9px;
            border-radius: 6px;
            border: 1px solid #aaa;
        }

        button {
            background: #a00000;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background: #700000;
        }

        button:disabled {
            background: #999;
            cursor: not-allowed;
        }

        .delivered {
            color: green;
            font-weight: bold;
        }

        .preparing {
            color: orange;
            font-weight: bold;
        }

        .ready {
            color: blue;
            font-weight: bold;
        }

        .pending {
            color: #555;
            font-weight: bold;
        }

        .logout {
            margin-top: 25px;
            background: #333;
        }

        .food-item {
            margin: 5px 0;
        }

    </style>

</head>


<body>


<div class="welcome">

    <h1>Welcome, Restaurant Staff!</h1>

    <p>
        You are logged in as Restaurant Staff.
    </p>

    <p>
        Manage food preparation and update order status.
    </p>

</div>


<h2>Customer Orders</h2>


<table>

    <tr>

        <th>Order ID</th>

        <th>Food Name</th>

        <th>Quantity</th>

        <th>Current Status</th>

        <th>Update Status</th>

    </tr>


<%

    if (orderList != null && !orderList.isEmpty()) {

        for (Order order : orderList) {

            String status = order.getOrderStatus();

            boolean delivered =
                    "Delivered".equalsIgnoreCase(status);

%>


    <tr>

        <!-- ORDER ID -->

        <td>

            <%= order.getOrderId() %>

        </td>


        <!-- FOOD NAME -->

        <td>

            <%
                List<OrderItem> items =
                        order.getOrderItems();

                if (items != null && !items.isEmpty()) {

                    for (OrderItem item : items) {
            %>

                <div class="food-item">

                    <%= item.getFoodName() %>

                </div>

            <%
                    }

                } else {
            %>

                No food items

            <%
                }
            %>

        </td>


        <!-- QUANTITY -->

        <td>

            <%
                if (items != null && !items.isEmpty()) {

                    for (OrderItem item : items) {
            %>

                <div class="food-item">

                    <%= item.getQuantity() %>

                </div>

            <%
                    }

                } else {
            %>

                -

            <%
                }
            %>

        </td>


        <!-- CURRENT STATUS -->

        <td>

            <%
                if ("Delivered".equalsIgnoreCase(status)) {
            %>

                <span class="delivered">
                    Delivered
                </span>

            <%
                } else if ("Ready for Delivery"
                        .equalsIgnoreCase(status)) {
            %>

                <span class="ready">
                    Ready for Delivery
                </span>

            <%
                } else if ("Preparing"
                        .equalsIgnoreCase(status)) {
            %>

                <span class="preparing">
                    Preparing
                </span>

            <%
                } else {
            %>

                <span class="pending">
                    <%= status %>
                </span>

            <%
                }
            %>

        </td>


        <!-- UPDATE -->

        <td>

            <%
                if (delivered) {
            %>

                <button disabled>
                    Delivered
                </button>

            <%
                } else {
            %>


            <form
                action="<%= request.getContextPath() %>/staffOrders"
                method="post">


                <input
                    type="hidden"
                    name="action"
                    value="updateStatus">


                <input
                    type="hidden"
                    name="orderId"
                    value="<%= order.getOrderId() %>">


                <select name="status">

                    <option value="Pending"
                        <%= "Pending".equalsIgnoreCase(status)
                        ? "selected" : "" %>>
                        Pending
                    </option>


                    <option value="Preparing"
                        <%= "Preparing".equalsIgnoreCase(status)
                        ? "selected" : "" %>>
                        Preparing
                    </option>


                    <option value="Ready for Delivery"
                        <%= "Ready for Delivery".equalsIgnoreCase(status)
                        ? "selected" : "" %>>
                        Ready for Delivery
                    </option>

                </select>


                <button type="submit">
                    Update
                </button>


            </form>


            <%
                }
            %>

        </td>


    </tr>


<%
        }

    } else {
%>


    <tr>

        <td colspan="5">

            No customer orders found.

        </td>

    </tr>


<%
    }
%>


</table>


<form
    action="<%= request.getContextPath() %>/logout"
    method="post">

    <button
        type="submit"
        class="logout">

        Logout

    </button>

</form>


</body>

</html>