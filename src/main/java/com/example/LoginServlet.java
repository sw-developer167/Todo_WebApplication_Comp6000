package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.jdom2.*;
import org.jdom2.input.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final String XML_PATH = "/WEB-INF/users.xml"; // Path to the XML file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user input
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all fields.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Check user credentials
        boolean success = checkUserCredentials(username, password);

        if (success) {
            // Add username to session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            // Redirect user to tasks.jsp
            response.sendRedirect("tasks.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean checkUserCredentials(String username, String password) {
        try {
            File xmlFile = new File(getServletContext().getRealPath(XML_PATH));
            if (!xmlFile.exists()) {
                return false;
            }

            // Load XML file
            SAXBuilder saxBuilder = new SAXBuilder();
            Document doc = saxBuilder.build(xmlFile);
            Element root = doc.getRootElement();

            // Search for user with matching credentials
            for (Element user : root.getChildren("user")) {
                String storedUsername = user.getChildText("username");
                String storedPassword = user.getChildText("password");
                if (storedUsername.equals(username) && storedPassword.equals(password)) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

