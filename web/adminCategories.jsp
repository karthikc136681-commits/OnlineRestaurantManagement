<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.Category"%>

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

    List<Category> categoryList =
            (List<Category>) request.getAttribute("categoryList");
%>

<!DOCTYPE html>
<html>

<head>

    <title>Manage Categories</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 30px;
        }

        h1 {
            color: #8B0000;
        }

        .box {
            background: white;
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 10px;
        }

        input, select {
            padding: 8px;
            margin: 5px;
        }

        button {
            padding: 8px 15px;
            cursor: pointer;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #8B0000;
            color: white;
        }

        .delete {
            color: red;
        }

    </style>

</head>

<body>

<h1>Manage Categories</h1>

<a href="adminDashboard.jsp">← Back to Admin Dashboard</a>

<br><br>

<div class="box">

    <h2>Add New Category</h2>

    <form action="categories" method="post">

        <input type="hidden"
               name="action"
               value="add">

        <input type="text"
               name="categoryName"
               placeholder="Category Name"
               required>

        <input type="text"
               name="description"
               placeholder="Description"
               required>

        <select name="status">

            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>

        </select>

        <button type="submit">
            Add Category
        </button>

    </form>

</div>

<h2>Existing Categories</h2>

<table>

    <tr>

        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Status</th>
        <th>Actions</th>

    </tr>

<%
    if (categoryList != null) {

        for (Category category : categoryList) {
%>

    <tr>

        <form action="categories" method="post">

            <td>
                <%= category.getCategoryId() %>

                <input type="hidden"
                       name="categoryId"
                       value="<%= category.getCategoryId() %>">
            </td>

            <td>

                <input type="text"
                       name="categoryName"
                       value="<%= category.getCategoryName() %>"
                       required>

            </td>

            <td>

                <input type="text"
                       name="description"
                       value="<%= category.getDescription() %>"
                       required>

            </td>

            <td>

                <select name="status">

                    <option value="Active"
                        <%= "Active".equals(category.getStatus())
                            ? "selected" : "" %>>
                        Active
                    </option>

                    <option value="Inactive"
                        <%= "Inactive".equals(category.getStatus())
                            ? "selected" : "" %>>
                        Inactive
                    </option>

                </select>

            </td>

            <td>

                <input type="hidden"
                       name="action"
                       value="update">

                <button type="submit">
                    Update
                </button>

        </form>

                <form action="categories"
                      method="post"
                      style="display:inline;">

                    <input type="hidden"
                           name="action"
                           value="delete">

                    <input type="hidden"
                           name="categoryId"
                           value="<%= category.getCategoryId() %>">

                    <button type="submit"
                            class="delete"
                            onclick="return confirm('Delete this category?');">
                        Delete
                    </button>

                </form>

            </td>

    </tr>

<%
        }
    }
%>

</table>

</body>

</html>