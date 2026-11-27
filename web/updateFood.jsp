<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.restaurant.model.FoodItem"%>

<%
    // Check login
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Check ADMIN role
    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    FoodItem food =
            (FoodItem) request.getAttribute("food");

    if (food == null) {
        response.sendRedirect("adminFood");
        return;
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>Update Food</title>

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
            width: 500px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px #cccccc;
        }

        h2 {
            color: #8B0000;
            text-align: center;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            box-sizing: border-box;
        }

        textarea {
            height: 80px;
        }

        button {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background-color: #8B0000;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #600000;
        }

        .back {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #8B0000;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Online Restaurant</h1>

    <p>Admin Panel</p>

</div>

<div class="container">

    <h2>Update Food Item</h2>

    <form action="<%= request.getContextPath() %>/adminFood" method="post">

        <input type="hidden"
               name="action"
               value="update">

        <input type="hidden"
               name="foodId"
               value="<%= food.getFoodId() %>">

        <label>Food Name</label>

        <input type="text"
               name="foodName"
               value="<%= food.getFoodName() %>"
               required>


        <label>Description</label>

        <textarea name="description"
                  required><%= food.getDescription() %></textarea>


        <label>Price</label>

        <input type="number"
               step="0.01"
               name="price"
               value="<%= food.getPrice() %>"
               required>


        <label>Category ID</label>

        <input type="number"
               name="categoryId"
               value="<%= food.getCategoryId() %>"
               required>


        <label>Image Path</label>

        <input type="text"
               name="imagePath"
               value="<%= food.getImagePath() %>">


        <label>Availability</label>

        <select name="availability">

            <option value="1"
                <%= food.getAvailability() == 1 ? "selected" : "" %>>
                Available
            </option>

            <option value="0"
                <%= food.getAvailability() == 0 ? "selected" : "" %>>
                Not Available
            </option>

        </select>


        <button type="submit">
            Update Food
        </button>

    </form>

    <a href="<%= request.getContextPath() %>/adminFood" class="back">
    ← Back to Manage Food
    </a>

</div>

</body>

</html>