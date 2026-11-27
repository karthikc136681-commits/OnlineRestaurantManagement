package com.restaurant.dao;

import com.restaurant.connection.DBConnection;
import com.restaurant.model.FoodItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class FoodItemDAO {

    // CREATE - Add a new food item
    public boolean addFood(FoodItem food) {

        String sql = "INSERT INTO food_items "
                + "(category_id, food_name, description, price, image_path, availability) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, food.getCategoryId());
            ps.setString(2, food.getFoodName());
            ps.setString(3, food.getDescription());
            ps.setDouble(4, food.getPrice());
            ps.setString(5, food.getImagePath());
            ps.setInt(6, food.getAvailability());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // READ - Get all food items
    // READ - Get all food items with category name
public List<FoodItem> getAllFood() {

    List<FoodItem> foodList = new ArrayList<>();

    String sql = "SELECT f.*, c.category_name "
            + "FROM food_items f "
            + "JOIN categories c "
            + "ON f.category_id = c.category_id "
            + "ORDER BY f.category_id, f.food_id";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {

            FoodItem food = new FoodItem();

            food.setFoodId(rs.getInt("food_id"));
            food.setCategoryId(rs.getInt("category_id"));
            food.setCategoryName(rs.getString("category_name"));
            food.setFoodName(rs.getString("food_name"));
            food.setDescription(rs.getString("description"));
            food.setPrice(rs.getDouble("price"));
            food.setImagePath(rs.getString("image_path"));
            food.setAvailability(rs.getInt("availability"));
            food.setCreatedAt(rs.getString("created_at"));

            foodList.add(food);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return foodList;
}


    // READ - Get one food item by ID
    public FoodItem getFoodById(int foodId) {

        FoodItem food = null;

        String sql = "SELECT * FROM food_items WHERE food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, foodId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                food = new FoodItem();

                food.setFoodId(rs.getInt("food_id"));
                food.setCategoryId(rs.getInt("category_id"));
                food.setFoodName(rs.getString("food_name"));
                food.setDescription(rs.getString("description"));
                food.setPrice(rs.getDouble("price"));
                food.setImagePath(rs.getString("image_path"));
                food.setAvailability(rs.getInt("availability"));
                food.setCreatedAt(rs.getString("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return food;
    }


    // UPDATE - Update food item
    public boolean updateFood(FoodItem food) {

        String sql = "UPDATE food_items SET "
                + "category_id = ?, "
                + "food_name = ?, "
                + "description = ?, "
                + "price = ?, "
                + "image_path = ?, "
                + "availability = ? "
                + "WHERE food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, food.getCategoryId());
            ps.setString(2, food.getFoodName());
            ps.setString(3, food.getDescription());
            ps.setDouble(4, food.getPrice());
            ps.setString(5, food.getImagePath());
            ps.setInt(6, food.getAvailability());
            ps.setInt(7, food.getFoodId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // DELETE - Delete food item
    public boolean deleteFood(int foodId) {

        String sql = "DELETE FROM food_items WHERE food_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, foodId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}