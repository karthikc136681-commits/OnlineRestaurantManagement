<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <title>Order Successful</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
        }

        .container {
            width: 450px;
            margin: 100px auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #cccccc;
        }

        h1 {
            color: green;
        }

        .order-id {
            font-size: 20px;
            font-weight: bold;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #8B0000;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Order Placed Successfully!</h1>

    <p>Thank you for ordering from Online Restaurant.</p>

    <p class="order-id">
        Your Order ID:
        <%= request.getParameter("orderId") %>
    </p>

    <a href="foods">
        Continue Shopping
    </a>

</div>

</body>
</html>