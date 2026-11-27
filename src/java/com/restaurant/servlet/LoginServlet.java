package com.restaurant.servlet;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            User user = userDAO.loginUser(email, password);

            if (user != null) {

                HttpSession session = request.getSession();

                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("name", user.getName());
                session.setAttribute("role", user.getRole());

                String contextPath = request.getContextPath();

                // ADMIN
                if ("ADMIN".equals(user.getRole())) {

                    response.sendRedirect(
                            contextPath + "/adminDashboard.jsp");

                }

                // STAFF
                else if ("STAFF".equals(user.getRole())) {

                    response.sendRedirect(
                            contextPath + "/staffOrders");

                }

                // DELIVERY
                else if ("DELIVERY".equals(user.getRole())) {

                    response.sendRedirect(
                            contextPath + "/deliveryDashboard.jsp");

                }

                // CUSTOMER
                else if ("CUSTOMER".equals(user.getRole())) {

                    response.sendRedirect(
                            contextPath + "/customerDashboard.jsp");

                }

                else {

                    response.getWriter().println(
                            "Invalid user role: " + user.getRole());
                }

            } else {

                response.getWriter().println(
                        "Invalid email or password.");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "An error occurred during login.");
        }
    }
}