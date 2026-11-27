package com.restaurant.servlet;

import com.restaurant.connection.DBConnection;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {

            Connection con = DBConnection.getConnection();

            if (con != null) {

                response.getWriter().println(
                        "<h2>Database Connected Successfully!</h2>");

                response.getWriter().println(
                        "<p>JDBC Connection is working correctly.</p>");

                con.close();

            } else {

                response.getWriter().println(
                        "<h2>Database Connection Failed!</h2>");
            }

        } catch (Exception e) {

            response.getWriter().println(
                    "<h2>Database Connection Error</h2>");

            response.getWriter().println(
                    "<p>" + e.getMessage() + "</p>");
        }
    }
}