package com.restaurant.servlet;

import com.restaurant.dao.OrderDAO;
import com.restaurant.model.Order;
import com.restaurant.model.OrderItem;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/staffOrders")
public class StaffOrdersServlet extends HttpServlet {

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

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        if (!"STAFF".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> orderList = orderDAO.getAllOrders();

        for (Order order : orderList) {

            List<OrderItem> items =
                    orderDAO.getOrderItems(order.getOrderId());

            order.setOrderItems(items);
        }

        request.setAttribute("orderList", orderList);

        request.getRequestDispatcher("staffOrders.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        if (!"STAFF".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {

            try {

                int orderId = Integer.parseInt(
                        request.getParameter("orderId"));

                String status =
                        request.getParameter("status");

                orderDAO.updateOrderStatus(
                        orderId,
                        status);

            } catch (Exception e) {

                e.printStackTrace();
            }
        }

        response.sendRedirect("staffOrders");
    }
}