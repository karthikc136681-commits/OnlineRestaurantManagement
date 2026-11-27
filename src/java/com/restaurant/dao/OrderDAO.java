package com.restaurant.dao;

import com.restaurant.connection.DBConnection;
import com.restaurant.model.Order;
import com.restaurant.model.OrderItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================================================
    // CREATE ORDER
    // =========================================================
    public int createOrder(Order order, List<OrderItem> items) {

        String orderSql =
                "INSERT INTO restaurant_orders " +
                "(user_id, total_amount, delivery_address, payment_method, order_status) " +
                "VALUES (?, ?, ?, ?, ?)";

        String itemSql =
                "INSERT INTO order_items " +
                "(order_id, food_id, quantity, price) " +
                "VALUES (?, ?, ?, ?)";

        Connection con = null;

        try {
            con = DBConnection.getConnection();

            con.setAutoCommit(false);

            PreparedStatement orderPs =
                    con.prepareStatement(
                            orderSql,
                            Statement.RETURN_GENERATED_KEYS);

            orderPs.setInt(1, order.getUserId());
            orderPs.setDouble(2, order.getTotalAmount());
            orderPs.setString(3, order.getDeliveryAddress());
            orderPs.setString(4, order.getPaymentMethod());
            orderPs.setString(5, order.getOrderStatus());

            orderPs.executeUpdate();

            ResultSet keys = orderPs.getGeneratedKeys();

            int orderId = 0;

            if (keys.next()) {
                orderId = keys.getInt(1);
            }

            PreparedStatement itemPs =
                    con.prepareStatement(itemSql);

            for (OrderItem item : items) {

                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getFoodId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getPrice());

                itemPs.addBatch();
            }

            itemPs.executeBatch();

            con.commit();

            return orderId;

        } catch (Exception e) {

            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // GET CUSTOMER ORDERS
    // =========================================================
    public List<Order> getOrdersByCustomer(int userId) {

        List<Order> orderList = new ArrayList<>();

        String sql =
                "SELECT * FROM restaurant_orders " +
                "WHERE user_id = ? " +
                "ORDER BY order_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setOrderDate(
                        rs.getString("order_date"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                order.setPaymentMethod(
                        rs.getString("payment_method"));

                order.setOrderStatus(
                        rs.getString("order_status"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }


    // =========================================================
    // GET ALL ORDERS
    // =========================================================
    public List<Order> getAllOrders() {

        List<Order> orderList = new ArrayList<>();

        String sql =
                "SELECT * FROM restaurant_orders " +
                "ORDER BY order_id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(
                        rs.getInt("order_id"));

                order.setUserId(
                        rs.getInt("user_id"));

                order.setOrderDate(
                        rs.getString("order_date"));

                order.setTotalAmount(
                        rs.getDouble("total_amount"));

                order.setDeliveryAddress(
                        rs.getString("delivery_address"));

                order.setPaymentMethod(
                        rs.getString("payment_method"));

                order.setOrderStatus(
                        rs.getString("order_status"));

                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }


    // =========================================================
    // GET FOOD ITEMS FOR AN ORDER
    // =========================================================
    public List<OrderItem> getOrderItems(int orderId) {

        List<OrderItem> itemList = new ArrayList<>();

        String sql =
                "SELECT oi.*, f.food_name " +
                "FROM order_items oi " +
                "JOIN food_items f ON oi.food_id = f.food_id " +
                "WHERE oi.order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItem item = new OrderItem();

                item.setOrderItemId(
                        rs.getInt("order_item_id"));

                item.setOrderId(
                        rs.getInt("order_id"));

                item.setFoodId(
                        rs.getInt("food_id"));

                item.setQuantity(
                        rs.getInt("quantity"));

                item.setPrice(
                        rs.getDouble("price"));

                item.setFoodName(
                        rs.getString("food_name"));

                itemList.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return itemList;
    }


    // =========================================================
    // STAFF UPDATE ORDER STATUS
    // Pending → Preparing → Ready for Delivery
    // =========================================================
    public boolean updateOrderStatus(
            int orderId,
            String status) {

        if (!"Pending".equals(status)
                && !"Preparing".equals(status)
                && !"Ready for Delivery".equals(status)) {

            return false;
        }

        String sql =
                "UPDATE restaurant_orders " +
                "SET order_status = ? " +
                "WHERE order_id = ? " +
                "AND order_status != 'Out for Delivery' " +
                "AND order_status != 'Delivered'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELIVERY STAFF UPDATE STATUS
    // Ready for Delivery → Out for Delivery
    // Out for Delivery → Delivered
    // =========================================================
    public boolean updateDeliveryStatus(
            int orderId,
            String status) {

        String sql = "";

        // START DELIVERY
        if ("Out for Delivery".equals(status)) {

            sql =
                    "UPDATE restaurant_orders " +
                    "SET order_status = ? " +
                    "WHERE order_id = ? " +
                    "AND order_status = 'Ready for Delivery'";

        }

        // MARK AS DELIVERED
        else if ("Delivered".equals(status)) {

            sql =
                    "UPDATE restaurant_orders " +
                    "SET order_status = ? " +
                    "WHERE order_id = ? " +
                    "AND order_status = 'Out for Delivery'";

        }

        // Invalid delivery status
        else {

            return false;
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }
}