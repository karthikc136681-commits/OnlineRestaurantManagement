
package com.restaurant.servlet;

import com.restaurant.dao.OrderDAO;
import com.restaurant.dao.UserDAO;
import com.restaurant.model.Order;
import com.restaurant.model.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/adminDelivery")
public class AdminDeliveryServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null
                || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Only ADMIN can access this page
        String role = (String) session.getAttribute("role");

        if (!"ADMIN".equals(role)) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        // Get all users and filter delivery staff
        List<User> allUsers = userDAO.getAllUsers();
        java.util.List<User> deliveryStaff =
                new java.util.ArrayList<>();

        for (User user : allUsers) {
            if ("DELIVERY".equals(user.getRole())) {
                deliveryStaff.add(user);
            }
        }

        // Get orders from the existing DAO
        List<Order> allOrders = orderDAO.getAllOrders();

        // Provide the data to the JSP
        request.setAttribute("deliveryStaff", deliveryStaff);
        request.setAttribute("orderList", allOrders);

        request.getRequestDispatcher("/adminDelivery.jsp")
                .forward(request, response);
    }
}