
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.FoodItem" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>

    <title>Restaurant Menu</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }

        .header {
            background-color: #8B0000;
            color: white;
            text-align: center;
            padding: 25px;
        }

        .header h1 {
            margin: 0;
        }

        .container {
            width: 90%;
            margin: 30px auto;
        }

        .category {
            margin-bottom: 40px;
        }

        .category-title {
            color: #8B0000;
            border-bottom: 2px solid #8B0000;
            padding-bottom: 8px;
            margin-bottom: 20px;
        }

        .menu {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .food-card {
            background-color: white;
            width: 280px;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 8px #cccccc;
        }

        .food-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
        }

        .food-card h3 {
            margin-bottom: 5px;
        }

        .description {
            color: #666666;
        }

        .price {
            font-size: 18px;
            font-weight: bold;
        }

        .available {
            color: green;
            font-weight: bold;
        }

        .unavailable {
            color: red;
            font-weight: bold;
        }

        .cart-button {
            background-color: #8B0000;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .cart-button:hover {
            background-color: #a00000;
        }

        .cart-link {
            display: inline-block;
            margin-bottom: 25px;
            text-decoration: none;
            color: #8B0000;
            font-weight: bold;
        }

        /* Back to Dashboard button */
        .back-button {
            display: inline-block;
            margin: 0 0 20px 0;
            padding: 10px 18px;
            background-color: #8B0000;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #b22222;
        }

    </style>

</head>

<body>

<div class="header">

    <h1>Online Restaurant</h1>

    <p>Delicious Food • Freshly Prepared</p>

</div>


<div class="container">

    <%
        /*
         * Check logged-in user's role
         */
        HttpSession sessionObj = request.getSession(false);

        String role = null;

        if (sessionObj != null) {
            role = (String) sessionObj.getAttribute("role");
        }

        // Select the correct dashboard
        String dashboardPage = "customerDashboard.jsp";

        if ("ADMIN".equals(role)) {
            dashboardPage = "adminDashboard.jsp";
        }
    %>

    <!-- BACK TO DASHBOARD BUTTON -->

    <% if ("ADMIN".equals(role) || "CUSTOMER".equals(role)) { %>

        <a href="<%= request.getContextPath() %>/<%= dashboardPage %>"
           class="back-button">
            &#8592; Back to Dashboard
        </a>

    <% } %>


    <h2>Our Menu</h2>


    <!-- VIEW MY CART ONLY FOR CUSTOMER -->

    <% if ("CUSTOMER".equals(role)) { %>

        <a href="<%= request.getContextPath() %>/cart" class="cart-link">
            🛒 View My Cart
        </a>

    <% } %>


    <%

        List<FoodItem> foodList =
                (List<FoodItem>) request.getAttribute("foodList");

        String currentCategory = "";

        if (foodList != null && !foodList.isEmpty()) {

            for (FoodItem food : foodList) {

                String categoryName = food.getCategoryName();

                if (categoryName == null) {
                    categoryName = "Other";
                }

                if (!categoryName.equals(currentCategory)) {

                    if (!currentCategory.equals("")) {
    %>

                        </div>
                    </div>

    <%
                    }

                    currentCategory = categoryName;
    %>

                    <div class="category">

                        <h2 class="category-title">
                            <%= categoryName %>
                        </h2>

                        <div class="menu">

    <%
                }
    %>


                <div class="food-card">


                    <% if (food.getImagePath() != null
                            && !food.getImagePath().trim().isEmpty()) { %>

                        <img src="<%= request.getContextPath() %>/<%= food.getImagePath() %>"
                             alt="<%= food.getFoodName() %>">

                    <% } %>


                    <h3>
                        <%= food.getFoodName() %>
                    </h3>


                    <p class="description">
                        <%= food.getDescription() %>
                    </p>


                    <p class="price">
                        ₹<%= food.getPrice() %>
                    </p>


                    <% if (food.getAvailability() == 1) { %>

                        <p class="available">
                            Available
                        </p>


                        <!-- ADD TO CART ONLY FOR CUSTOMER -->

                        <% if ("CUSTOMER".equals(role)) { %>

                            <form action="<%= request.getContextPath() %>/cart"
                                  method="post">

                                <input type="hidden"
                                       name="action"
                                       value="add">

                                <input type="hidden"
                                       name="foodId"
                                       value="<%= food.getFoodId() %>">

                                <input type="number"
                                       name="quantity"
                                       value="1"
                                       min="1"
                                       required>

                                <button type="submit"
                                        class="cart-button">

                                    Add to Cart

                                </button>

                            </form>

                        <% } %>


                    <% } else { %>

                        <p class="unavailable">
                            Currently Unavailable
                        </p>

                    <% } %>


                </div>


    <%
            }

            if (!currentCategory.equals("")) {
    %>

                </div>
            </div>

    <%
            }

        } else {
    %>

        <h3>No food items found.</h3>

    <%
        }
    %>

</div>

</body>
</html>