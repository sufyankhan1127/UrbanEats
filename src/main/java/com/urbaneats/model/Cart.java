package com.urbaneats.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        this.items = new HashMap<>();
    }

    public void addItem(CartItem item) {
        if (items.containsKey(item.getMenuId())) {
            CartItem existing = items.get(item.getMenuId());
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
        } else {
            items.put(item.getMenuId(), item);
        }
    }

    public void updateItem(int menuId, int quantity) {
        if (items.containsKey(menuId)) {
            if (quantity <= 0) items.remove(menuId);
            else items.get(menuId).setQuantity(quantity);
        }
    }

    public void removeItem(int menuId) {
        items.remove(menuId);
    }

    public Map<Integer, CartItem> getItems() {
        return items;
    }
}