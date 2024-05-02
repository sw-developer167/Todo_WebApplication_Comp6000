package com.example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.jdom2.*;
import org.jdom2.output.*;
import org.jdom2.input.*;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private final String XML_PATH = "/WEB-INF/users.xml"; // Path to the XML file

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user input
        if (name == null || name.isEmpty() || username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all fields.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Store user data in XML
        boolean success = storeUserData(name, username, password);

        if (success) {
            response.sendRedirect("login.jsp?signup=success");
        } else {
            request.setAttribute("errorMessage", "Error signing up. Please try again later.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }

    private boolean storeUserData(String name, String username, String password) {
        try {
            // Load existing XML file or create a new one if it doesn't exist
            File xmlFile = new File(getServletContext().getRealPath(XML_PATH));
            Document doc;
            Element root;
            if (xmlFile.exists()) {
                SAXBuilder saxBuilder = new SAXBuilder();
                doc = saxBuilder.build(xmlFile);
                root = doc.getRootElement();
            } else {
                doc = new Document();
                root = new Element("users");
                doc.setRootElement(root);
            }

            // Create user element and add it to the XML
            Element user = new Element("user");
            Element nameElement = new Element("name").setText(name);
            Element usernameElement = new Element("username").setText(username);
            Element passwordElement = new Element("password").setText(password);
            user.addContent(nameElement);
            user.addContent(usernameElement);
            user.addContent(passwordElement);
            root.addContent(user);

            // Write updated XML to the file
            XMLOutputter xmlOutputter = new XMLOutputter();
            xmlOutputter.setFormat(Format.getPrettyFormat());
            FileOutputStream outputStream = new FileOutputStream(xmlFile);
            xmlOutputter.output(doc, outputStream);
            outputStream.close();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
