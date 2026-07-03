package com.urbaneats.dao;

import java.util.List;
import com.urbaneats.model.Menu;

public interface MenuDAO {
    List<Menu> getMenuByRestaurant(int restaurantId);
    
    Menu getMenuById(int menuId);
}