package com.example;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.jdom2.*;
import org.jdom2.input.*;
import org.jdom2.output.*;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
    private static final String XML_PATH = "/WEB-INF/tasks.xml"; // Path to the XML file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "add":
                    addTask(request, response);
                    break;
                case "edit":
                    editTask(request, response);
                    break;
                case "delete":
                    deleteTask(request, response);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Return bad request if action is invalid
                    break;
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Return bad request if no action specified
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED); // Return method not allowed for GET requests
    }

    // Method to get all tasks from XML file
    public static List<Element> getAllTasks(ServletContext servletContext) {
        List<Element> tasks = new ArrayList<>();
        try {
            File xmlFile = new File(servletContext.getRealPath(XML_PATH));
            if (xmlFile.exists()) {
                SAXBuilder saxBuilder = new SAXBuilder();
                Document doc = saxBuilder.build(xmlFile);
                Element root = doc.getRootElement();
                tasks = root.getChildren("task");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tasks;
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");
        String priority = request.getParameter("priority");

        // Validate task data
        if (name == null || name.isEmpty() || description == null || description.isEmpty() ||
                dueDate == null || dueDate.isEmpty() || priority == null || priority.isEmpty()) {
            // Handle invalid input
            response.sendRedirect("tasks.jsp?message=Please fill in all fields."); // Redirect back to tasks page with error message
            return;
        }

        // Retrieve username from session
        String username = (String) request.getSession().getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
            return;
        }

        // Add task to XML file
        try {
            File xmlFile = new File(getServletContext().getRealPath(XML_PATH));
            synchronized (this) {
                Document doc;
                if (xmlFile.exists()) {
                    SAXBuilder saxBuilder = new SAXBuilder();
                    doc = saxBuilder.build(xmlFile);
                } else {
                    doc = new Document();
                    doc.setRootElement(new Element("tasks"));
                }

                // Generate unique ID for the task
                int taskId = generateTaskId(doc);

                Element task = new Element("task");
                task.addContent(new Element("id").setText(String.valueOf(taskId))); // Assign task ID
                task.addContent(new Element("name").setText(name));
                task.addContent(new Element("description").setText(description));
                task.addContent(new Element("dueDate").setText(dueDate));
                task.addContent(new Element("priority").setText(priority));
                task.setAttribute("username", username);

                doc.getRootElement().addContent(task);

                XMLOutputter xmlOutputter = new XMLOutputter();
                xmlOutputter.setFormat(Format.getPrettyFormat());
                FileOutputStream outputStream = new FileOutputStream(xmlFile);
                xmlOutputter.output(doc, outputStream);
                outputStream.close();
            }

            // Output success message to request attribute
            response.sendRedirect("tasks.jsp?message=Task added successfully!"); // Redirect to tasks page with success message
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("tasks.jsp?message=Error adding task. Please try again later."); // Redirect back to tasks page with error message
        }
    }

    // Method to generate a unique task ID
    private int generateTaskId(Document doc) {
        List<Element> tasks = doc.getRootElement().getChildren("task");
        if (tasks.isEmpty()) {
            return 1; // If no tasks exist, start with ID 1
        } else {
            // Find the maximum existing task ID and increment by 1
            int maxId = tasks.stream()
                    .map(task -> Integer.parseInt(task.getChildText("id")))
                    .max(Integer::compare)
                    .orElse(0);
            return maxId + 1;
        }
    }

    private void editTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskId = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("dueDate");
        String priority = request.getParameter("priority");

        if (taskId == null || taskId.isEmpty() || name == null || name.isEmpty() || description == null || description.isEmpty() ||
                dueDate == null || dueDate.isEmpty() || priority == null || priority.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Return bad request if any parameter is missing
            return;
        }

        try {
            File xmlFile = new File(getServletContext().getRealPath(XML_PATH));
            if (xmlFile.exists()) {
                SAXBuilder saxBuilder = new SAXBuilder();
                Document doc = saxBuilder.build(xmlFile);
                Element root = doc.getRootElement();
                List<Element> tasks = root.getChildren("task");
                for (Element task : tasks) {
                    if (task.getChildText("id").equals(taskId)) { // Check if task ID matches
                        task.getChild("name").setText(name);
                        task.getChild("description").setText(description);
                        task.getChild("dueDate").setText(dueDate);
                        task.getChild("priority").setText(priority);

                        XMLOutputter xmlOutputter = new XMLOutputter();
                        xmlOutputter.setFormat(Format.getPrettyFormat());
                        try (FileOutputStream outputStream = new FileOutputStream(xmlFile)) {
                            xmlOutputter.output(doc, outputStream);
                        }
                        response.setStatus(HttpServletResponse.SC_OK); // Return success status
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Return not found status if task not found
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskId = request.getParameter("id");
        if (taskId == null || taskId.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Return bad request if no task ID provided
            return;
        }

        try {
            File xmlFile = new File(getServletContext().getRealPath(XML_PATH));
            if (xmlFile.exists()) {
                SAXBuilder saxBuilder = new SAXBuilder();
                Document doc = saxBuilder.build(xmlFile);
                Element root = doc.getRootElement();
                List<Element> tasks = root.getChildren("task");
                for (Element task : tasks) {
                    if (task.getChildText("id").equals(taskId)) {
                        root.removeContent(task);
                        XMLOutputter xmlOutputter = new XMLOutputter();
                        xmlOutputter.setFormat(Format.getPrettyFormat());
                        FileOutputStream outputStream = new FileOutputStream(xmlFile);
                        xmlOutputter.output(doc, outputStream);
                        outputStream.close();
                        response.setStatus(HttpServletResponse.SC_OK); // Return success status
                        return;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Return not found status if task not found
    }

}
