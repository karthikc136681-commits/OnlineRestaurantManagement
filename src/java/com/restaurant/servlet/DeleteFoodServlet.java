package com.restaurant.servlet;

import com.restaurant.dao.FoodItemDAO;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/deleteFood")
public class DeleteFoodServlet extends HttpServlet {

    private FoodItemDAO foodDAO;

    @Override
    public void init() {
        foodDAO = new FoodItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check whether user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Only ADMIN can delete food
        String role = (String) session.getAttribute("role");

        if (!"ADMIN".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {

            String idParameter = request.getParameter("foodId");

            if (idParameter == null) {
                response.getWriter().println("Food ID is missing.");
                return;
            }

            int foodId = Integer.parseInt(idParameter);

            boolean result = foodDAO.deleteFood(foodId);

            if (result) {

                response.sendRedirect("foods");

            } else {

                response.getWriter().println(
                        "Food could not be deleted.");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while deleting food.");
        }
    }
}