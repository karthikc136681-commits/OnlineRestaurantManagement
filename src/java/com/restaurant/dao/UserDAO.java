package com.restaurant.dao;

import com.restaurant.connection.DBConnection;
import com.restaurant.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // CREATE - Register a new user
    public boolean registerUser(User user) {

        String sql = "INSERT INTO users "
                + "(name, email, password, phone, address, role) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // READ - Login user
    public User loginUser(String email, String password) {

        User user = null;

        String sql = "SELECT * FROM users "
                + "WHERE email = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getString("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    // READ - Get all users for Admin
public List<User> getAllUsers() {

    List<User> userList = new ArrayList<>();

    String sql = "SELECT * FROM users ORDER BY user_id";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {

            User user = new User();

            user.setUserId(rs.getInt("user_id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setPhone(rs.getString("phone"));
            user.setAddress(rs.getString("address"));
            user.setRole(rs.getString("role"));
            user.setCreatedAt(rs.getString("created_at"));

            userList.add(user);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return userList;
}
}
