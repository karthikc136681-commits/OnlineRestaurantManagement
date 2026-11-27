package com.restaurant.dao;

import com.restaurant.connection.DBConnection;
import com.restaurant.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // READ ALL CATEGORIES
    public List<Category> getAllCategories() {

        List<Category> categoryList = new ArrayList<>();

        String sql = "SELECT * FROM categories ORDER BY category_id";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setStatus(rs.getString("status"));

                categoryList.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categoryList;
    }

    // CREATE
    public boolean addCategory(Category category) {

        String sql = "INSERT INTO categories "
                + "(category_name, description, status) "
                + "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // UPDATE
    public boolean updateCategory(Category category) {

        String sql = "UPDATE categories SET "
                + "category_name = ?, description = ?, status = ? "
                + "WHERE category_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getStatus());
            ps.setInt(4, category.getCategoryId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // DELETE
    public boolean deleteCategory(int categoryId) {

        String sql = "DELETE FROM categories WHERE category_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, categoryId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}