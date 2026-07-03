package com.urbaneats.daoimpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.urbaneats.dao.MenuDAO;
import com.urbaneats.model.Menu;
import com.urbaneats.util.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public List<Menu> getMenuByRestaurant(int restaurantId) {
        List<Menu> menuList = new ArrayList<>();
        String query = "SELECT * FROM menu WHERE restaurant_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Menu menu = new Menu();
                menu.setMenuId(rs.getInt("menu_id"));
                menu.setRestaurantId(rs.getInt("restaurant_id"));
                menu.setItemName(rs.getString("item_name"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getFloat("price"));
                menu.setAvailable(rs.getBoolean("is_available"));
                menu.setImagePath(rs.getString("image_path"));
                
                menuList.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menuList;
    }
    @Override
    public Menu getMenuById(int menuId) {
        String query = "SELECT * FROM menu WHERE menu_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, menuId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Menu m = new Menu();
                m.setMenuId(rs.getInt("menu_id"));
                m.setRestaurantId(rs.getInt("restaurant_id"));
                m.setItemName(rs.getString("item_name"));
                m.setPrice(rs.getFloat("price"));
                m.setImagePath(rs.getString("image_path"));
                return m;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}