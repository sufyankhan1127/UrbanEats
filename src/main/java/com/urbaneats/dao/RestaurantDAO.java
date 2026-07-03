package com.urbaneats.dao;

import java.util.List;
import com.urbaneats.model.Restaurant;

public interface RestaurantDAO {
    List<Restaurant> getAllRestaurants();
    Restaurant getRestaurant(int restaurantId);
    // You can add addRestaurant, updateRestaurant later
}