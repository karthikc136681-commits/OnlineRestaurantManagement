
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Online Restaurant</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: Arial, sans-serif;

            /* Different food-themed background */
            background:
                linear-gradient(
                    rgba(25, 18, 10, 0.55),
                    rgba(25, 18, 10, 0.68)
                ),
                url('https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=1920&q=85');

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px 15px;
        }

        .login-container {
            width: 100%;
            max-width: 430px;
            padding: 38px 35px;
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
            margin: 0 0 30px;
        }

        h2 {
            text-align: center;
            color: #292920;
            margin: 0 0 28px;
            font-size: 24px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-size: 14px;
            font-weight: bold;
        }

        input[type="email"],
        input[type="password"] {
            display: block;
            width: 100%;
            padding: 13px 14px;
            margin-bottom: 21px;
            border: 1px solid #d5d0cc;
            border-radius: 8px;
            font-family: Arial, sans-serif;
            font-size: 15px;
            background: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #8B0000;
            box-shadow: 0 0 0 3px rgba(102, 115, 61, 0.15);
        }

        input[type="submit"] {
            display: block;
            width: 100%;
            padding: 14px;
            margin-top: 8px;
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

        .register-link {
            text-align: center;
            margin: 25px 0 0;
            color: #555;
            font-size: 14px;
        }

        .register-link a {
            color: #8B0000;
            font-weight: bold;
            text-decoration: none;
        }

        .register-link a:hover {
            color: #4E5A2D;
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .login-container {
                padding: 28px 22px;
            }

            .restaurant-name {
                font-size: 26px;
            }
        }
    </style>
</head>

<body>

    <div class="login-container">

        <h1 class="restaurant-name">Online Restaurant</h1>

        <p class="tagline">
            Delicious food, delivered with care.
        </p>

        <h2>Login</h2>

        <form action="login" method="post">

            <label for="email">Email Address</label>
            <input
                type="email"
                id="email"
                name="email"
                placeholder="Enter your email"
                required
            >

            <label for="password">Password</label>
            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                required
            >

            <input type="submit" value="Login">

        </form>

        <p class="register-link">
            Don't have an account?
            <a href="register.jsp">Create Account</a>
        </p>

    </div>

</body>
</html>
