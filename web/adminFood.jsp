<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.FoodItem"%>

<%
if (session.getAttribute("user") == null) {
response.sendRedirect("login.jsp");
return;
}


String role = (String) session.getAttribute("role");

if (!"ADMIN".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}

List<FoodItem> foodList =
        (List<FoodItem>) request.getAttribute("foodList");


%>

<!DOCTYPE html>

<html>

<head>


<title>Manage Food Items</title>

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

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: white;
    }

    th {
        background-color: #8B0000;
        color: white;
        padding: 12px;
    }

    td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    img {
        width: 80px;
        height: 60px;
        object-fit: cover;
        border-radius: 5px;
    }

    .update {
        background-color: #0066cc;
        color: white;
        padding: 7px 12px;
        text-decoration: none;
        border-radius: 5px;
    }

    .delete {
        background-color: red;
        color: white;
        padding: 7px 12px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .back {
        display: inline-block;
        margin-bottom: 20px;
        color: #8B0000;
        font-weight: bold;
    }

</style>


</head>

<body>

<div class="header">


<h1>Food Management</h1>

<p>Admin Panel</p>


</div>

<div class="container">


<a class="back" href="adminDashboard.jsp">
    ← Back to Admin Dashboard
</a>

<h2>Manage Food Items</h2>

<%
    if (foodList != null && !foodList.isEmpty()) {
%>

<table>

    <tr>

        <th>ID</th>
        <th>Image</th>
        <th>Food Name</th>
        <th>Category ID</th>
        <th>Description</th>
        <th>Price</th>
        <th>Availability</th>
        <th>Actions</th>

    </tr>

    <%
        for (FoodItem food : foodList) {
    %>

    <tr>

        <td>
            <%= food.getFoodId() %>
        </td>

        <td>

            <% if (food.getImagePath() != null &&
                   !food.getImagePath().isEmpty()) { %>

                <img src="<%= request.getContextPath() %>/<%= food.getImagePath() %>"
                     alt="<%= food.getFoodName() %>">

            <% } %>

        </td>

        <td>
            <%= food.getFoodName() %>
        </td>

        <td>
            <%= food.getCategoryId() %>
        </td>

        <td>
            <%= food.getDescription() %>
        </td>

        <td>
            ₹<%= food.getPrice() %>
        </td>

        <td>

            <% if (food.getAvailability() == 1) { %>

                Available

            <% } else { %>

                Not Available

            <% } %>

        </td>

        <td>

            <a class="update"
   href="adminFood?action=edit&foodId=<%= food.getFoodId() %>">
    Update
</a>

            <br><br>

            <form action="foods" method="post">

                <input type="hidden"
                       name="action"
                       value="delete">

                <input type="hidden"
                       name="foodId"
                       value="<%= food.getFoodId() %>">

                <button type="submit"
                        class="delete"
                        onclick="return confirm('Are you sure you want to delete this food item?');">

                    Delete

                </button>

            </form>

        </td>

    </tr>

    <%
        }
    %>

</table>

<%
    } else {
%>

    <h3>No food items found.</h3>

<%
    }
%>


</div>

</body>

</html>
