
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Food - Online Restaurant</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;
            background: linear-gradient(
                135deg,
                #fff3e0,
                #ffccbc,
                #ffe0b2
            );
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
        }

        .form-card {
            width: 100%;
            max-width: 550px;
            background-color: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        h1 {
            color: #8B0000;
            text-align: center;
            margin-top: 0;
            margin-bottom: 25px;
        }

        .back-button {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #555;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-button:hover {
            background-color: #333;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            color: #444;
        }

        input[type="number"],
        input[type="text"],
        select {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #8B0000;
        }

        input[type="submit"] {
            width: 100%;
            padding: 13px;
            background-color: #8B0000;
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        input[type="submit"]:hover {
            background-color: #b22222;
        }

        @media (max-width: 500px) {
            .form-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>

<body>

    <div class="form-card">

        <a href="<%= request.getContextPath() %>/adminDashboard.jsp"
           class="back-button">
            &#8592; Back to Admin Dashboard
        </a>

        <h1>Add New Food Item</h1>

        <form action="<%= request.getContextPath() %>/foods" method="post">

            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="categoryId">Category ID:</label>
                <input type="number" id="categoryId"
                       name="categoryId" min="1" required>
            </div>

            <div class="form-group">
                <label for="foodName">Food Name:</label>
                <input type="text" id="foodName"
                       name="foodName" required>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <input type="text" id="description"
                       name="description">
            </div>

            <div class="form-group">
                <label for="price">Price (₹):</label>
                <input type="number" id="price"
                       name="price" min="0.01"
                       step="0.01" required>
            </div>

            <div class="form-group">
                <label for="imagePath">Image Path:</label>
                <input type="text" id="imagePath"
                       name="imagePath"
                       placeholder="images/food.jpg">
            </div>

            <div class="form-group">
                <label for="availability">Availability:</label>
                <select id="availability" name="availability">
                    <option value="1">Available</option>
                    <option value="0">Not Available</option>
                </select>
            </div>

            <input type="submit" value="Add Food">

        </form>

    </div>

</body>
</html>