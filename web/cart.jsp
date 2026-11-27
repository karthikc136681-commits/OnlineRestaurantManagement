<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.CartItem"%>

<!DOCTYPE html>
<html>
<head>

    <title>My Cart</title>

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
            padding: 20px;
        }

        .container {
            width: 90%;
            margin: 30px auto;
        }

        .cart-item {
            background-color: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #cccccc;
        }

        .quantity {
            width: 60px;
            padding: 5px;
        }

        button {
            padding: 7px 12px;
            cursor: pointer;
        }

        .remove {
            color: red;
        }

        .empty {
            text-align: center;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>My Cart</h1>

</div>


<div class="container">

    <%
        List<CartItem> cartItems =
                (List<CartItem>) request.getAttribute("cartItems");

        if (cartItems != null && !cartItems.isEmpty()) {

            for (CartItem item : cartItems) {
    %>

        <div class="cart-item">

            <h3>
               <%= item.getFoodName() %>
            </h3>

            <p>
               Price: ₹<%= item.getPrice() %>
            </p>

            <p>
    Quantity:
               <%= item.getQuantity() %>
            </p>

            <p>
               Total: ₹<%= item.getPrice() * item.getQuantity() %>
            </p>


            <!-- UPDATE QUANTITY -->

            <form action="cart" method="post">

                <input type="hidden"
                       name="action"
                       value="update">

                <input type="hidden"
                       name="cartItemId"
                       value="<%= item.getCartItemId() %>">

                <input type="number"
                       name="quantity"
                       value="<%= item.getQuantity() %>"
                       min="1"
                       class="quantity"
                       required>

                <button type="submit">
                    Update
                </button>
                
                

            </form>


            <br>


            <!-- REMOVE ITEM -->

            <form action="cart" method="post">

                <input type="hidden"
                       name="action"
                       value="remove">

                <input type="hidden"
                       name="cartItemId"
                       value="<%= item.getCartItemId() %>">

                <button type="submit"
                        class="remove">

                    Remove

                </button>

            </form>

        </div>

    <%
            }

        } else {
    %>

        <div class="empty">

            <h2>Your cart is empty.</h2>

            <a href="foods">
                Go to Food Menu
            </a>

        </div>

    <%
        }
    %>
        <%
        double cartTotal = 0;

        if (cartItems != null) {
            for (CartItem item : cartItems) {
                cartTotal += item.getPrice() * item.getQuantity();
            }
        }
    %>

    <h2>Cart Total: ₹<%= cartTotal %></h2>

    <form action="order.jsp" method="get">

        <input type="hidden"
               name="totalAmount"
               value="<%= cartTotal %>">

        <button type="submit">
            Place Order
        </button>

    </form>

    <br>
    <br>

    <a href="foods">
        ← Continue Shopping
    </a>

</div>

</body>
</html>