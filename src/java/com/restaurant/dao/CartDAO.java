package com.restaurant.dao;

import com.restaurant.connection.DBConnection;
import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // CREATE - Get existing cart or create a new cart
    public int getOrCreateCart(int userId) {

        String selectSql = "SELECT cart_id FROM cart WHERE user_id = ?";
        String insertSql = "INSERT INTO cart (user_id) VALUES (?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(selectSql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("cart_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     insertSql,
                     java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    // CREATE - Add food to cart
    public boolean addToCart(int userId, int foodId, int quantity) {

        int cartId = getOrCreateCart(userId);

        if (cartId == -1) {
            return false;
        }

        String checkSql =
                "SELECT cart_item_id, quantity " +
                "FROM cart_items " +
                "WHERE cart_id = ? AND food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setInt(1, cartId);
            checkPs.setInt(2, foodId);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {

                int cartItemId = rs.getInt("cart_item_id");
                int oldQuantity = rs.getInt("quantity");

                String updateSql =
                        "UPDATE cart_items " +
                        "SET quantity = ? " +
                        "WHERE cart_item_id = ?";

                try (PreparedStatement updatePs =
                             con.prepareStatement(updateSql)) {

                    updatePs.setInt(1, oldQuantity + quantity);
                    updatePs.setInt(2, cartItemId);

                    return updatePs.executeUpdate() > 0;
                }

            } else {

                String insertSql =
                        "INSERT INTO cart_items " +
                        "(cart_id, food_id, quantity) " +
                        "VALUES (?, ?, ?)";

                try (PreparedStatement insertPs =
                             con.prepareStatement(insertSql)) {

                    insertPs.setInt(1, cartId);
                    insertPs.setInt(2, foodId);
                    insertPs.setInt(3, quantity);

                    return insertPs.executeUpdate() > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // READ - Get cart items
    public List<CartItem> getCartItems(int userId) {

        List<CartItem> cartItems = new ArrayList<>();

        String sql =
        "SELECT ci.*, f.food_name, f.price " +
        "FROM cart_items ci " +
        "JOIN cart c ON ci.cart_id = c.cart_id " +
        "JOIN food_items f ON ci.food_id = f.food_id " +
        "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem item = new CartItem();

                item.setCartItemId(
                        rs.getInt("cart_item_id"));

                item.setCartId(
                        rs.getInt("cart_id"));

                item.setFoodId(
                        rs.getInt("food_id"));

                item.setQuantity(
                        rs.getInt("quantity"));
                
                item.setFoodName(
                        rs.getString("food_name"));

                item.setPrice(
                        rs.getDouble("price"));

                cartItems.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cartItems;
    }


    // UPDATE - Change quantity
    public boolean updateQuantity(
            int cartItemId,
            int quantity) {

        String sql =
                "UPDATE cart_items " +
                "SET quantity = ? " +
                "WHERE cart_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // DELETE - Remove item from cart
    public boolean removeFromCart(int cartItemId) {

        String sql =
                "DELETE FROM cart_items " +
                "WHERE cart_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}