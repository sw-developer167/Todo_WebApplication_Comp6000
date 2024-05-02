<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - To-Do List Project</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(45deg, #3498db, #8e44ad);
            color: #f4f4f4;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .login-container {
            max-width: 400px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.3);
            border-radius: 15px;
            transition: transform 0.3s;
        }

        .login-container:hover {
            transform: translateY(-10px);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            color: #555;
            font-weight: 700;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #3498db;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .form-links {
            margin-top: 20px;
            color: #555;
        }

        .form-links a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }

        .form-links a:hover {
            color: #2980b9;
        }

    </style>
</head>
<body>
<div class="login-container">
    <h2>Login to Your Account</h2>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
        <p style="color: red;"><%= errorMessage %></p>
    <% } %>
    <form action="LoginServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" placeholder="Enter your username">

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" placeholder="Enter your password">

        <input type="submit" value="Login">
    </form>

    <div class="form-links">
        <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
    </div>
</div>
</body>
</html>
