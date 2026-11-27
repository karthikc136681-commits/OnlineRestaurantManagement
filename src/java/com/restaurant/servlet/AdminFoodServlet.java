package com.restaurant.servlet;

import com.restaurant.dao.FoodItemDAO;
import com.restaurant.model.FoodItem;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/adminFood")
public class AdminFoodServlet extends HttpServlet {

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

        String action = request.getParameter("action");

        // OPEN UPDATE PAGE
        if ("edit".equals(action)) {

            String foodIdString =
                    request.getParameter("foodId");

            if (foodIdString == null) {
                response.sendRedirect("adminFood");
                return;
            }

            int foodId =
                    Integer.parseInt(foodIdString);

            FoodItem food =
                    foodDAO.getFoodById(foodId);

            if (food == null) {
                response.sendRedirect("adminFood");
                return;
            }

            request.setAttribute("food", food);

            request.getRequestDispatcher("updateFood.jsp")
                    .forward(request, response);

            return;
        }

        // NORMAL ADMIN FOOD PAGE
        List<FoodItem> foodList =
                foodDAO.getAllFood();

        request.setAttribute("foodList", foodList);

        request.getRequestDispatcher("adminFood.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        // Check ADMIN role
        String role =
                (String) session.getAttribute("role");

        if (!"ADMIN".equals(role)) {

            response.sendRedirect("login.jsp");
            return;
        }

        String action =
                request.getParameter("action");

        // UPDATE FOOD
        if ("update".equals(action)) {

            try {

                int foodId =
                        Integer.parseInt(
                                request.getParameter("foodId"));

                int categoryId =
                        Integer.parseInt(
                                request.getParameter("categoryId"));

                String foodName =
                        request.getParameter("foodName");

                String description =
                        request.getParameter("description");

                double price =
                        Double.parseDouble(
                                request.getParameter("price"));

                String imagePath =
                        request.getParameter("imagePath");

                int availability =
                        Integer.parseInt(
                                request.getParameter("availability"));

                FoodItem food = new FoodItem();

                food.setFoodId(foodId);
                food.setCategoryId(categoryId);
                food.setFoodName(foodName);
                food.setDescription(description);
                food.setPrice(price);
                food.setImagePath(imagePath);
                food.setAvailability(availability);

                boolean updated =
                        foodDAO.updateFood(food);

                if (updated) {

                    response.sendRedirect("adminFood");

                } else {

                    response.getWriter().println(
                            "Food item could not be updated.");
                }

            } catch (Exception e) {

                e.printStackTrace();

                response.getWriter().println(
                        "Error while updating food item.");
            }

        } else {

            response.sendRedirect("adminFood");
        }
    }
}