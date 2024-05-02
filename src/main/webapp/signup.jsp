<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - To-Do List Project</title>
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

        .container {
            max-width: 400px;
            padding: 30px;
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), rgba(240, 240, 240, 0.9));
            box-shadow: 0 12px 24px 0 rgba(0, 0, 0, 0.25);
            border-radius: 20px;
            border: 1px solid #ddd;
            transition: transform 0.3s;
        }

        .container:hover {
            transform: translateY(-10px);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-weight: 700;
        }

        form {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        label {
            font-weight: 700;
            color: #555;
        }
        p{
            color:dimgrey;
        }

        input[type="text"], input[type="password"] {
            margin-bottom: 20px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #3498db;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
            padding: 12px;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .form-links {
            margin-top: 20px;
        }

        .form-links a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        .form-links a:hover {
            color: #2980b9;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Sign Up to TodoApplication</h2>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <p style="color: red;"><%= errorMessage %></p>
        <% } %>
    <form action="SignUpServlet" method="post">
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" placeholder="Your name">

        <label for="username">Username:</label>
        <input type="text" name="username" id="username" placeholder="Choose a username">

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" placeholder="Create a password">

        <input type="submit" value="Sign Up">
    </form>

    <div class="form-links">
        <p>Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</div>
</body>
</html>
