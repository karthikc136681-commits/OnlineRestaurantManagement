
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Registration | Online Restaurant</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;

            background:
                linear-gradient(
                    rgba(20, 10, 5, 0.65),
                    rgba(20, 10, 5, 0.78)
                ),
                url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=1920&q=85');

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        .register-container {
            width: 100%;
            max-width: 470px;
            padding: 35px;
            background: rgba(255, 255, 255, 0.97);
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
        }

        .restaurant-name {
            text-align: center;
            color: #8B0000;
            font-size: 30px;
            font-weight: bold;
            margin: 0 0 8px;
        }

        .tagline {
            text-align: center;
            color: #777;
            font-size: 14px;
            margin: 0 0 25px;
        }

        h2 {
            text-align: center;
            color: #292020;
            margin: 0 0 25px;
            font-size: 23px;
        }

        form {
            width: 100%;
        }

        label {
            display: block;
            margin-bottom: 7px;
            color: #333;
            font-size: 14px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        textarea {
            display: block;
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 18px;
            border: 1px solid #d5d0cc;
            border-radius: 8px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            background: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #8B0000;
            box-shadow: 0 0 0 3px rgba(139, 0, 0, 0.12);
        }

        textarea {
            min-height: 85px;
            resize: vertical;
        }

        input[type="submit"] {
            display: block;
            width: 100%;
            padding: 14px;
            margin-top: 5px;
            border: none;
            border-radius: 8px;
            background: #8B0000;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }

        input[type="submit"]:hover {
            background: #650000;
            transform: translateY(-1px);
        }

        .login-link {
            text-align: center;
            margin: 22px 0 0;
            color: #555;
            font-size: 14px;
        }

        .login-link a {
            color: #8B0000;
            font-weight: bold;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .register-container {
                padding: 25px 20px;
            }

            .restaurant-name {
                font-size: 26px;
            }
        }
    </style>
</head>

<body>

    <div class="register-container">

        <h1 class="restaurant-name">Online Restaurant</h1>
        <p class="tagline">Delicious food, delivered with care.</p>

        <h2>Create Account</h2>

        <form action="register" method="post">

            <label for="name">Full Name</label>
            <input type="text" id="name" name="name"
                   placeholder="Enter your full name" required>

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Create a password" required>

            <label for="phone">Phone Number</label>
            <input type="text" id="phone" name="phone"
                   placeholder="Enter your phone number" required>

            <label for="address">Address</label>
            <textarea id="address" name="address"
                      placeholder="Enter your delivery address"
                      required></textarea>

            <input type="submit" value="Create Account">

        </form>

        <p class="login-link">
            Already have an account?
            <a href="login.jsp">Login</a>
        </p>

    </div>

</body>
</html>
