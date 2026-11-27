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

@WebServlet("/foodTest")
public class FoodTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        FoodItemDAO foodDAO = new FoodItemDAO();

        List<FoodItem> foodList =
                foodDAO.getAllFood();

        response.getWriter().println(
                "<html><body>");

        response.getWriter().println(
                "<h1>FoodItemDAO - READ Operation</h1>");

        response.getWriter().println(
                "<h3>Food Items Retrieved Successfully</h3>");

        response.getWriter().println(
                "<table border='1' cellpadding='10'>");

        response.getWriter().println(
                "<tr>" +
                "<th>Food ID</th>" +
                "<th>Food Name</th>" +
                "<th>Category ID</th>" +
                "<th>Price</th>" +
                "<th>Availability</th>" +
                "</tr>");

        for (FoodItem food : foodList) {

            response.getWriter().println(
                    "<tr>" +
                    "<td>" + food.getFoodId() + "</td>" +
                    "<td>" + food.getFoodName() + "</td>" +
                    "<td>" + food.getCategoryId() + "</td>" +
                    "<td>" + food.getPrice() + "</td>" +
                    "<td>" + food.getAvailability() + "</td>" +
                    "</tr>");
        }

        response.getWriter().println(
                "</table>");

        response.getWriter().println(
                "</body></html>");
    }
}