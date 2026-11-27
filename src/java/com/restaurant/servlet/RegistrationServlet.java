package com.restaurant.servlet;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setAddress(address);

            // Every normal registration is a CUSTOMER
            user.setRole("CUSTOMER");

            boolean result = userDAO.registerUser(user);

            if (result) {

                response.sendRedirect("login.jsp");

            } else {

                response.getWriter().println(
                        "Registration failed. Email may already exist.");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "An error occurred during registration.");
        }
    }
}