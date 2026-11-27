package com.restaurant.servlet;

import com.restaurant.dao.CartDAO;
import com.restaurant.model.CartItem;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDAO cartDAO;

    @Override
    public void init() {
        cartDAO = new CartDAO();
    }

    // VIEW CART
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

        if (!"CUSTOMER".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().println(
                    "User ID not found in session.");
            return;
        }

        List<CartItem> cartItems =
                cartDAO.getCartItems(userId);

        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("cart.jsp")
                .forward(request, response);
    }


    // ADD / UPDATE / REMOVE
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

        if (!"CUSTOMER".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.getWriter().println(
                    "User ID not found in session.");
            return;
        }

        String action = request.getParameter("action");


        // ADD TO CART
        if ("add".equals(action)) {

            int foodId = Integer.parseInt(
                    request.getParameter("foodId"));

            int quantity = Integer.parseInt(
                    request.getParameter("quantity"));

            boolean result =
                    cartDAO.addToCart(
                            userId,
                            foodId,
                            quantity);

            if (result) {

                response.sendRedirect("cart");

            } else {

                response.getWriter().println(
                        "Food could not be added to cart.");
            }
        }


        // UPDATE QUANTITY
        else if ("update".equals(action)) {

            int cartItemId = Integer.parseInt(
                    request.getParameter("cartItemId"));

            int quantity = Integer.parseInt(
                    request.getParameter("quantity"));

            boolean result =
                    cartDAO.updateQuantity(
                            cartItemId,
                            quantity);

            if (result) {

                response.sendRedirect("cart");

            } else {

                response.getWriter().println(
                        "Quantity could not be updated.");
            }
        }


        // REMOVE FROM CART
        else if ("remove".equals(action)) {

            int cartItemId = Integer.parseInt(
                    request.getParameter("cartItemId"));

            boolean result =
                    cartDAO.removeFromCart(cartItemId);

            if (result) {

                response.sendRedirect("cart");

            } else {

                response.getWriter().println(
                        "Item could not be removed.");
            }
        }
    }
}