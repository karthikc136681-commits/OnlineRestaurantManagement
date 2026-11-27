package com.restaurant.servlet;

import com.restaurant.dao.CartDAO;
import com.restaurant.dao.OrderDAO;
import com.restaurant.model.CartItem;
import com.restaurant.model.Order;
import com.restaurant.model.OrderItem;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;
    private CartDAO cartDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        cartDAO = new CartDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in user ID
        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        String address =
                request.getParameter("deliveryAddress");

        String paymentMethod =
                request.getParameter("paymentMethod");

        String totalValue =
                request.getParameter("totalAmount");

        double totalAmount;

        try {

            totalAmount = Double.parseDouble(totalValue);

        } catch (Exception e) {

            response.getWriter().println(
                    "Invalid order amount.");

            return;
        }


        /*
         * GET CART ITEMS FROM DATABASE
         *
         * We do NOT use session cartItems here.
         */
        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);


        if (cartItems == null ||
                cartItems.isEmpty()) {

            response.getWriter().println(
                    "Your cart is empty.");

            return;
        }


        /*
         * Convert CartItem objects
         * into OrderItem objects.
         */
        List<OrderItem> orderItems =
                new ArrayList<>();

        for (CartItem cartItem : cartItems) {

            OrderItem orderItem =
                    new OrderItem();

            orderItem.setFoodId(
                    cartItem.getFoodId());

            orderItem.setQuantity(
                    cartItem.getQuantity());

            orderItem.setPrice(
                    cartItem.getPrice());

            orderItems.add(orderItem);
        }


        // Create Order object
        Order order = new Order();

        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setDeliveryAddress(address);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("Pending");


        // Save order and order items
        int orderId =
                orderDAO.createOrder(
                        order,
                        orderItems);


        if (orderId > 0) {

            /*
             * Clear cart from database
             */
            for (CartItem cartItem : cartItems) {

                cartDAO.removeFromCart(
                        cartItem.getCartItemId());
            }


            response.sendRedirect(
                    "orderSuccess.jsp?orderId=" + orderId);

        } else {

            response.getWriter().println(
                    "Order could not be placed.");
        }
    }
}