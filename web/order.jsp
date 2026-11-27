<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Place Order</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .container {
            width: 450px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #cccccc;
        }

        h1 {
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #8B0000;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Place Your Order</h1>

    <form action="order" method="post">

        <label>Delivery Address:</label>

        <input type="text"
               name="deliveryAddress"
               placeholder="Enter your delivery address"
               required>


        <label>Payment Method:</label>

        <select name="paymentMethod" required>

            <option value="">Select Payment Method</option>

            <option value="Cash on Delivery">
                Cash on Delivery
            </option>

        </select>

        <%
    String totalAmount = request.getParameter("totalAmount");

    if (totalAmount == null) {
        totalAmount = "0";
    }
%>

<h2>Order Total: ₹<%= totalAmount %></h2>

        <input type="hidden"
       name="totalAmount"
       value="<%= request.getParameter("totalAmount") %>">


        <input type="submit"
               value="Place Order">

    </form>

</div>

</body>
</html>