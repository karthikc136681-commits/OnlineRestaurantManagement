package com.restaurant.servlet;

import com.restaurant.dao.OrderDAO;
import com.restaurant.model.Order;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Check CUSTOMER role
        String role =
                (String) session.getAttribute("role");

        if (!"CUSTOMER".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user's ID
        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get orders of this user
        List<Order> orderList =
                orderDAO.getOrdersByCustomer(userId);

        // Send orders to JSP
        request.setAttribute(
                "orderList",
                orderList);

        // Open customer orders page
        request.getRequestDispatcher(
                "myOrders.jsp")
                .forward(request, response);
    }
}