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

@WebServlet("/orderTest")
public class OrderTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        OrderDAO orderDAO = new OrderDAO();

        List<Order> orderList =
                orderDAO.getAllOrders();

        response.getWriter().println(
                "<html><body>");

        response.getWriter().println(
                "<h1>OrderDAO - READ Operation</h1>");

        response.getWriter().println(
                "<h3>Orders Retrieved Successfully</h3>");

        response.getWriter().println(
                "<table border='1' cellpadding='10'>");

        response.getWriter().println(
                "<tr>" +
                "<th>Order ID</th>" +
                "<th>User ID</th>" +
                "<th>Total Amount</th>" +
                "<th>Delivery Address</th>" +
                "<th>Payment Method</th>" +
                "<th>Status</th>" +
                "</tr>");

        for (Order order : orderList) {

            response.getWriter().println(
                    "<tr>" +
                    "<td>" + order.getOrderId() + "</td>" +
                    "<td>" + order.getUserId() + "</td>" +
                    "<td>" + order.getTotalAmount() + "</td>" +
                    "<td>" + order.getDeliveryAddress() + "</td>" +
                    "<td>" + order.getPaymentMethod() + "</td>" +
                    "<td>" + order.getOrderStatus() + "</td>" +
                    "</tr>");
        }

        response.getWriter().println(
                "</table>");

        response.getWriter().println(
                "</body></html>");
    }
}