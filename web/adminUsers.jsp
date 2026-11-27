<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.restaurant.model.User"%>

<%
    // Check login
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Only ADMIN can access
    String role = (String) session.getAttribute("role");

    if (!"ADMIN".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<User> userList =
            (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>

<html>

<head>

    <title>View Users</title>

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

        .container {
            width: 95%;
            margin: auto;
        }

        table {
            width: 100%;
            background-color: white;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th {
            background-color: #8B0000;
            color: white;
            padding: 12px;
        }

        td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .customer {
            color: green;
            font-weight: bold;
        }

        .admin {
            color: #8B0000;
            font-weight: bold;
        }

        .delivery {
            color: blue;
            font-weight: bold;
        }

        a {
            color: #8B0000;
            font-weight: bold;
            text-decoration: none;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Registered Users</h1>

    <a href="adminDashboard.jsp">
        ← Back to Admin Dashboard
    </a>

    <table>

        <tr>

            <th>User ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Role</th>
            <th>Created At</th>

        </tr>

<%
    if (userList != null && !userList.isEmpty()) {

        for (User user : userList) {
%>

        <tr>

            <td>
                <%= user.getUserId() %>
            </td>

            <td>
                <%= user.getName() %>
            </td>

            <td>
                <%= user.getEmail() %>
            </td>

            <td>
                <%= user.getPhone() %>
            </td>

            <td>
                <%= user.getAddress() %>
            </td>

            <td>

                <%
                    if ("CUSTOMER".equals(user.getRole())) {
                %>

                    <span class="customer">
                        CUSTOMER
                    </span>

                <%
                    } else if ("ADMIN".equals(user.getRole())) {
                %>

                    <span class="admin">
                        ADMIN
                    </span>

                <%
                    } else if ("DELIVERY".equals(user.getRole())) {
                %>

                    <span class="delivery">
                        DELIVERY
                    </span>

                <%
                    } else {
                %>

                    <%= user.getRole() %>

                <%
                    }
                %>

            </td>

            <td>
                <%= user.getCreatedAt() %>
            </td>

        </tr>

<%
        }

    } else {
%>

        <tr>

            <td colspan="7">
                No users found.
            </td>

        </tr>

<%
    }
%>

    </table>

</div>

</body>

</html>