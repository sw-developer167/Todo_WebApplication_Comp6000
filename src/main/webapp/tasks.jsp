<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Task - To-Do List Project</title>
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
        }

        .container {
            width: 600px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 12px 24px 0 rgba(0, 0, 0, 0.25);
            border-radius: 20px;
            transition: transform 0.3s;
            text-align: center;
        }

        .container:hover {
            transform: translateY(-10px);
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .header img {
            width: 150px;
            height: auto;
            border-radius: 25%;
        }

        .header h2 {
            color: #333;
            font-weight: 700;
            margin-top: 10px;
        }

        .message {
            color: #333;
            font-size: 16px;
            margin-bottom: 20px;
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

        input[type="text"], input[type="date"] {
            margin-bottom: 20px;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="date"]:focus {
            border-color: #3498db;
        }

        select {
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border-color 0.3s;
            background-color: #f9f9f9;
            margin-bottom: 20px;
        }

        select:focus {
            border-color: #3498db;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: #fff;
            cursor: pointer;
            padding: 12px;
            font-size: 18px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .navigation {
            text-align: center;
            margin-top: 20px;
        }

        .navigation a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        .navigation a:hover {
            color: #2980b9;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: #fff;
            padding: 12px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
    <script>
        function logout() {
            window.location.href = "LogoutServlet";
        }
    </script>
</head>
<body>
<div class="container">
    <div class="header">
        <img src="addtask.png" alt="User Avatar">
        <h2>Add a New Task</h2>
    </div>

    <% String message = request.getParameter("message"); %>
    <% if (message != null && !message.isEmpty()) { %>
    <p class="message"><%= message %></p>
    <% } %>

    <form action="TaskServlet" method="post">
        <label for="task-name">Task Name:</label>
        <input type="text" name="name" id="task-name" placeholder="Enter task name">

        <label for="description">Task Description:</label>
        <input type="text" name="description" id="description" placeholder="Description of the task">

        <label> for "due-date">Due Date:</label>
        <input type="date" name="dueDate" id="due-date">

        <label for="priority">Priority:</label>
        <select name="priority" id="priority">
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
        </select>

        <input type="hidden" name="action" value="add">
        <input type="submit" value="Add Task">
    </form>

    <div class="navigation">
        <p><a href="showalltasks.jsp">Show All Tasks</a></p>
    </div>

    <button class="logout-btn" onclick="logout()">Logout</button>
</div>
</body>
</html>
