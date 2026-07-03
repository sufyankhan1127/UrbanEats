package com.urbaneats.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.urbaneats.dao.RestaurantDAO;
import com.urbaneats.model.Restaurant;
import com.urbaneats.util.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurantList = new ArrayList<>();
        String query = "SELECT * FROM restaurants";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Restaurant res = new Restaurant();
                res.setRestaurantId(rs.getInt("restaurant_id"));
                res.setName(rs.getString("name"));
                res.setCuisineType(rs.getString("cuisine_type"));
                res.setDeliveryTime(rs.getInt("delivery_time"));
                res.setAddress(rs.getString("address"));
                res.setRating(rs.getFloat("rating"));
                res.setActive(rs.getBoolean("is_active"));
                res.setImagePath(rs.getString("image_path"));
                
                restaurantList.add(res);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurantList;
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        // Logic to fetch a single restaurant (used for the menu page later)
        return null; 
    }
}