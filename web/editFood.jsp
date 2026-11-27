<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.restaurant.dao.FoodItemDAO"%>
<%@page import="com.restaurant.model.FoodItem"%>

<%
    // Only logged-in ADMIN can access this page
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idParameter = request.getParameter("foodId");

    if (idParameter == null) {
        out.println("<h3>Food ID is missing.</h3>");
        return;
    }

    int foodId = Integer.parseInt(idParameter);

    FoodItemDAO foodDAO = new FoodItemDAO();
    FoodItem food = foodDAO.getFoodById(foodId);

    if (food == null) {
        out.println("<h3>Food item not found.</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Food</title>
</head>

<body>

    <h1>Update Food Item</h1>

    <form action="foods" method="post">

        <input type="hidden"
               name="action"
               value="update">

        <input type="hidden"
               name="foodId"
               value="<%= food.getFoodId() %>">

        <label>Category ID:</label>
        <input type="number"
               name="categoryId"
               value="<%= food.getCategoryId() %>"
               required>
        <br><br>

        <label>Food Name:</label>
        <input type="text"
               name="foodName"
               value="<%= food.getFoodName() %>"
               required>
        <br><br>

        <label>Description:</label>
        <input type="text"
               name="description"
               value="<%= food.getDescription() %>">
        <br><br>

        <label>Price:</label>
        <input type="number"
               name="price"
               step="0.01"
               value="<%= food.getPrice() %>"
               required>
        <br><br>

        <label>Image Path:</label>
        <input type="text"
               name="imagePath"
               value="<%= food.getImagePath() %>">
        <br><br>

        <label>Availability:</label>

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

        <br><br>

        <input type="submit" value="Update Food">

    </form>

    <br>

    <a href="foods">Back to Menu</a>

</body>
</html>