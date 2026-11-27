package com.restaurant.servlet;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Only ADMIN can view users
        String role = (String) session.getAttribute("role");

        if (!"ADMIN".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get all users from database
        List<User> userList = userDAO.getAllUsers();

        // Send list to JSP
        request.setAttribute("userList", userList);

        // Open Admin Users page
        request.getRequestDispatcher("adminUsers.jsp")
                .forward(request, response);
    }
}