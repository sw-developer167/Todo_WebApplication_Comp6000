<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>To-Do List Project - Welcome</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> <!-- Importing a Google Font -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(45deg, #3498db, #8e44ad);
            color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 600px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.3);
            border-radius: 20px;
            transition: transform 0.3s;
        }

        .container:hover {
            transform: translateY(-10px);
        }

        h2 {
            color: #333;
            font-weight: 700;
            margin-bottom: 20px;
        }

        p {
            color: #555;
            font-size: 16px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        ul li {
            margin: 15px 0;
        }

        a {
            text-decoration: none;
            color: #3498db;
            font-size: 20px;
            font-weight: bold;
            transition: color 0.3s;
        }

        a:hover {
            color: #2980b9;
        }

        .image {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <img src="todo.png" alt="To-Do List Banner" class="image">
    <h2>Welcome to Your To-Do List Manager</h2>
    <p>Organize your tasks and get things done. Please choose an option:</p>
    <ul>
        <li><a href="signup.jsp"><i class="fas fa-user-plus"></i> Sign Up</a></li>
        <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
    </ul>
</div>
</body>
</html>
