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

@WebServlet("/deliveryOrders")
public class DeliveryOrdersServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }


    // =========================================================
    // VIEW DELIVERY ORDERS
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Check DELIVERY role
        String role =
                (String) session.getAttribute("role");

        if (!"DELIVERY".equals(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Get all orders
        List<Order> orderList =
                orderDAO.getAllOrders();

        request.setAttribute(
                "orderList",
                orderList);

        // Open deliveryOrders.jsp
        request.getRequestDispatcher(
                "/deliveryOrders.jsp")
                .forward(request, response);
    }


    // =========================================================
    // UPDATE DELIVERY STATUS
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Check DELIVERY role
        String role =
                (String) session.getAttribute("role");

        if (!"DELIVERY".equals(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        String action =
                request.getParameter("action");

        if ("updateStatus".equals(action)) {

            try {

                int orderId =
                        Integer.parseInt(
                                request.getParameter("orderId"));

                String status =
                        request.getParameter("status");

                boolean updated =
                        orderDAO.updateDeliveryStatus(
                                orderId,
                                status);

                if (updated) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/deliveryOrders");

                } else {

                    response.getWriter().println(
                            "Delivery status could not be updated.");
                }

            } catch (Exception e) {

                e.printStackTrace();

                response.getWriter().println(
                        "Error while updating delivery status.");
            }

        } else {

            response.getWriter().println(
                    "Invalid action.");
        }
    }
}