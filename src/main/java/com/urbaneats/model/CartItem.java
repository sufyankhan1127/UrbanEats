package com.urbaneats.model;

public class CartItem {
    private int menuId;
    private int restaurantId;
    private String name;
    private int quantity;
    private float price;

    public CartItem() {}
    public CartItem(int menuId, int restaurantId, String name, int quantity, float price) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
    }
    // Getters and Setters
    public int getMenuId() { return menuId; }
    public void setMenuId(int menuId) { this.menuId = menuId; }
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public float getPrice() { return price; }
    public void setPrice(float price) { this.price = price; }
}