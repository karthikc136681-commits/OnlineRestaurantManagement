package com.restaurant.servlet;

import com.restaurant.dao.CategoryDAO;
import com.restaurant.model.Category;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    // VIEW CATEGORIES
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute("categoryList", categoryList);

        request.getRequestDispatcher("adminCategories.jsp")
                .forward(request, response);
    }

    // ADD / UPDATE / DELETE
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equals(session.getAttribute("role"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {

            // ADD
            if ("add".equals(action)) {

                Category category = new Category();

                category.setCategoryName(
                        request.getParameter("categoryName"));

                category.setDescription(
                        request.getParameter("description"));

                category.setStatus(
                        request.getParameter("status"));

                categoryDAO.addCategory(category);

            }

            // UPDATE
            else if ("update".equals(action)) {

                Category category = new Category();

                category.setCategoryId(
                        Integer.parseInt(
                                request.getParameter("categoryId")));

                category.setCategoryName(
                        request.getParameter("categoryName"));

                category.setDescription(
                        request.getParameter("description"));

                category.setStatus(
                        request.getParameter("status"));

                categoryDAO.updateCategory(category);

            }

            // DELETE
            else if ("delete".equals(action)) {

                int categoryId = Integer.parseInt(
                        request.getParameter("categoryId"));

                categoryDAO.deleteCategory(categoryId);
            }

            response.sendRedirect("categories");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                    "Error while processing category.");
        }
    }
}