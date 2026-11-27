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

@WebServlet("/foods")
public class FoodServlet extends HttpServlet {

    private FoodItemDAO foodDAO;

    @Override
    public void init() {
        foodDAO = new FoodItemDAO();
    }

    // READ - Display all food items
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        List<FoodItem> foodList = foodDAO.getAllFood();

        request.setAttribute("foodList", foodList);

        request.getRequestDispatcher("menu.jsp")
                .forward(request, response);
    }

    // CREATE, UPDATE and DELETE
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {

            // CREATE
            if ("add".equals(action)) {

                int categoryId = Integer.parseInt(
                        request.getParameter("categoryId"));

                String foodName = request.getParameter("foodName");

                String description =
                        request.getParameter("description");

                double price = Double.parseDouble(
                        request.getParameter("price"));

                String imagePath =
                        request.getParameter("imagePath");

                int availability = Integer.parseInt(
                        request.getParameter("availability"));

                FoodItem food = new FoodItem();

                food.setCategoryId(categoryId);
                food.setFoodName(foodName);
                food.setDescription(description);
                food.setPrice(price);
                food.setImagePath(imagePath);
                food.setAvailability(availability);

                boolean result = foodDAO.addFood(food);

                if (result) {
                    response.sendRedirect("foods");
                } else {
                    response.getWriter().println(
                            "Food could not be added.");
                }

            }

            // UPDATE
            else if ("update".equals(action)) {

                int foodId = Integer.parseInt(
                        request.getParameter("foodId"));

                int categoryId = Integer.parseInt(
                        request.getParameter("categoryId"));

                String foodName =
                        request.getParameter("foodName");

                String description =
                        request.getParameter("description");

                double price = Double.parseDouble(
                        request.getParameter("price"));

                String imagePath =
                        request.getParameter("imagePath");

                int availability = Integer.parseInt(
                        request.getParameter("availability"));

                FoodItem food = new FoodItem();

                food.setFoodId(foodId);
                food.setCategoryId(categoryId);
                food.setFoodName(foodName);
                food.setDescription(description);
                food.setPrice(price);
                food.setImagePath(imagePath);
                food.setAvailability(availability);

                boolean result = foodDAO.updateFood(food);

                if (result) {
                    response.sendRedirect("foods");
                } else {
                    response.getWriter().println(
                            "Food could not be updated.");
                }

            }

            // DELETE
            else if ("delete".equals(action)) {

                int foodId = Integer.parseInt(
                        request.getParameter("foodId"));

                boolean result = foodDAO.deleteFood(foodId);

                if (result) {
                    response.sendRedirect("foods");
                } else {
                    response.getWriter().println(
                            "Food could not be deleted.");
                }

            }

            else {
                response.getWriter().println(
                        "Invalid action.");
            }

        } catch (NumberFormatException e) {

            response.getWriter().println(
                    "Invalid number entered.");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "An error occurred while processing the request.");
        }
    }
}