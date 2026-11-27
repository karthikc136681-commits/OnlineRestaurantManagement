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

@WebServlet("/adminOrders")
public class AdminOrdersServlet extends HttpServlet {

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

        // Check ADMIN role
        String role = (String) session.getAttribute("role");

        if (!"ADMIN".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get all orders
        List<Order> orderList =
                orderDAO.getAllOrders();

        request.setAttribute("orderList", orderList);

        // Open admin orders page
        request.getRequestDispatcher("adminOrders.jsp")
                .forward(request, response);
    }
}