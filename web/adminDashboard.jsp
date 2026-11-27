<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
// Check login
if (session.getAttribute("user") == null) {
response.sendRedirect("login.jsp");
return;
}


String name = (String) session.getAttribute("name");
String role = (String) session.getAttribute("role");

// Only ADMIN can access
if (!"ADMIN".equals(role)) {
    response.sendRedirect("login.jsp");
    return;
}


%>

<!DOCTYPE html>

<html>
<head>
    <title>Admin Dashboard</title>


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
        width: 80%;
        margin: 30px auto;
    }

    .card {
        background-color: white;
        padding: 20px;
        margin: 15px 0;
        border-radius: 10px;
        box-shadow: 0 2px 8px #cccccc;
    }

    a {
        text-decoration: none;
        color: #8B0000;
        font-weight: bold;
    }

    .logout {
        color: red;
    }
</style>


</head>

<body>

<div class="header">
    <h1>Online Restaurant</h1>
    <h2>Welcome, Admin <%= name %>!</h2>
    <p>You are logged in as an Administrator.</p>
</div>

<div class="container">

<div class="card">
    <h3>Food Management</h3>

    <p>
        <a href="adminFood">
    </p>
    
    <p>
        <a href="foods">View Food Menu</a>
    </p>

    <p>
        <a href="addFood.jsp">Add Food Item</a>
    </p>

    <p>
        <a href="adminFood">Update / Delete Food Items</a>
    </p>
</div>

<div class="card">
    <h3>Other Management</h3>

    <p>
        <a href="categories">
    Manage Categories
</a>
    </p>

    <p>
    <a href="users">View Users</a>
</p>

    <p>
    <a href="adminOrders">Manage Orders</a>
</p>

    <p>
    <a href="adminDelivery">Manage Delivery</a>
</p>
</div>

<div class="card">
    <p>
        <a class="logout" href="logout">Logout</a>
    </p>
</div>


</div>

</body>
</html>
