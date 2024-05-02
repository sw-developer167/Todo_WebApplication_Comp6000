<%@ page import="com.example.TaskServlet" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.jdom2.Element" %>
<%@ page import="org.jdom2.input.SAXBuilder" %>
<%@ page import="org.jdom2.Document" %>
<%@ page import="org.jdom2.output.XMLOutputter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    List<Element> tasks = null;
    String username = (String) session.getAttribute("username");
    if (username != null) {
        File xmlFile = new File(getServletContext().getRealPath("/WEB-INF/tasks.xml"));
        if (xmlFile.exists()) {
            try {
                SAXBuilder saxBuilder = new SAXBuilder();
                Document doc = saxBuilder.build(xmlFile);
                List<Element> allTasks = doc.getRootElement().getChildren("task");
                tasks = new ArrayList<>();
                for (Element task : allTasks) {
                    if (username.equals(task.getAttributeValue("username"))) {
                        tasks.add(task);
                    }
                }
                String filter = request.getParameter("filter");
                if (filter != null && !filter.isEmpty()) {
                    switch (filter) {
                        case "dueDateAsc":
                            Collections.sort(tasks, new Comparator<Element>() {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                @Override
                                public int compare(Element o1, Element o2) {
                                    try {
                                        Date date1 = sdf.parse(o1.getChildText("dueDate"));
                                        Date date2 = sdf.parse(o2.getChildText("dueDate"));
                                        return date1.compareTo(date2);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                        return 0;
                                    }
                                }
                            });
                            break;
                        case "priority":
                            Collections.sort(tasks, new Comparator<Element>() {
                                @Override
                                public int compare(Element o1, Element o2) {
                                    int priority1 = mapPriorityToInt(o1.getChildText("priority"));
                                    int priority2 = mapPriorityToInt(o2.getChildText("priority"));
                                    return Integer.compare(priority2, priority1); // High to low
                                }
                                private int mapPriorityToInt(String priority) {
                                    switch (priority.toLowerCase()) {
                                        case "high":
                                            return 3;
                                        case "medium":
                                            return 2;
                                        case "low":
                                            return 1;
                                        default:
                                            return 0;
                                    }
                                }
                            });
                            break;
                        default:
                            break;
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Tasks - To-Do List Project</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"> <!-- For icons -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"> <!-- Google Fonts -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(45deg, #3498db, #8e44ad); /* Gradient background */
            color: #f4f4f4; /* Default text color */
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 80%;
            margin: 50px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 12px 24px 0 rgba(0, 0, 0, 0.25);
            border-radius: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .container:hover {
            transform: translateY(-10px);
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
            transition: background-color 0.3s;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        td {
            background-color: #f9f9f9;
            color: black;
        }

        td:hover {
            background-color: #e0e0e0;
        }

        button {
            background-color: #3498db;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #2980b9;
        }

        .logout-btn {
            background-color: #e74c3c;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .navigation {
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
    </style>
    <script>
        function enableEdit(td) {
            td.setAttribute('contenteditable', true);
            td.focus();
        }

        function saveChanges(taskId) {
            var name = document.getElementById('name_' + taskId).innerText;
            var description = document.getElementById('description_' + taskId).innerText;
            var dueDate = document.getElementById('dueDate_' + taskId).innerText;
            var priority = document.getElementById('priority_' + taskId).innerText;
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    window.location.reload();
                }
            };
            xhttp.open("POST", "TaskServlet?action=edit&id=" + taskId, true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("name=" + encodeURIComponent(name) + "&description=" + encodeURIComponent(description) + "&dueDate=" + encodeURIComponent(dueDate) + "&priority=" + encodeURIComponent(priority));
        }

        function deleteTask(taskId) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    window.location.reload();
                }
            };
            xhttp.open("POST", "TaskServlet?action=delete&id=" + taskId, true);
            xhttp.send();
        }

        function logout() {
            window.location.href = "LogoutServlet";
        }

        function filterTasks() {
            var filter = document.getElementById("filter").value;
            if (filter === "") {
                window.location.href = "showalltasks.jsp";
            } else {
                window.location.href = "showalltasks.jsp?filter=" + filter;
            }
        }
        window.onload = function() {
            var filterSelect = document.getElementById("filter");
            filterSelect.value = "";
        };
    </script>
</head>
<body>
<div class="container">
    <h2>All Tasks</h2>
    <div>
        <label for="filter">Filter:</label>
        <select id="filter" onchange="filterTasks()">
            <option value="">None</option>
            <option value="dueDateAsc">Due Date (Ascending)</option>
            <option value="priority">Priority (High to Low)</option>
        </select>
    </div>
    <br>
    <table border="1">
        <thead>
            <tr>
                <th>Name</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Priority</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <% if (tasks != null) { %>
                <% for (Element task : tasks) { %>
                    <tr>
                        <td id="name_<%= task.getChildText("id") %>" onclick="enableEdit(this);"><%= task.getChildText("name") %></td>
                        <td id="description_<%= task.getChildText("id") %>" onclick="enableEdit(this);"><%= task.getChildText("description") %></td>
                        <td id="dueDate_<%= task.getChildText("id") %>" onclick="enableEdit(this);"><%= task.getChildText("dueDate") %></td>
                        <td id="priority_<%= task.getChildText("id") %>" onclick="enableEdit(this);"><%= task.getChildText("priority") %></td>
                        <td><button onclick="saveChanges('<%= task.getChildText("id") %>')">Save</button></td>
                        <td><button onclick="deleteTask('<%= task.getChildText("id") %>')">Delete</button></td>
                    </tr>
                <% } %>
            <% } %>
        </tbody>
    </table>
    <div class="navigation">
        <p><a href="tasks.jsp">Add Task</a></p>
    </div>
    <p><button onclick="logout()">Logout</button></p>
    </div>
</body>
</html>
