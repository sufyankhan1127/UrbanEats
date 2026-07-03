package com.urbaneats.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.urbaneats.model.Cart;
import com.urbaneats.model.CartItem;
import com.urbaneats.model.User;
import com.urbaneats.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    User user = (User) session.getAttribute("loggedInUser");
	    Cart cart = (Cart) session.getAttribute("cart");

	    if (user == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }

	    if (cart == null || cart.getItems().isEmpty()) {
	        response.sendRedirect("home");
	        return;
	    }

	    try (Connection conn = DBConnection.getConnection()) {
	        conn.setAutoCommit(false);

	        // 1. Get Restaurant ID from the first item in the cart
	        int restaurantId = cart.getItems().values().iterator().next().getRestaurantId();

	        // 2. Insert into Orders Table (Check your SQL columns!)
	        String orderSql = "INSERT INTO orders (user_id, restaurant_id, total_amount, status) VALUES (?, ?, ?, 'Placed')";
	        PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
	        
	        float total = 0;
	        for(CartItem item : cart.getItems().values()) {
	            total += item.getPrice() * item.getQuantity();
	        }
	        
	        ps.setInt(1, user.getUserId());
	        ps.setInt(2, restaurantId);
	        ps.setFloat(3, total);
	        ps.executeUpdate();

	        ResultSet rs = ps.getGeneratedKeys();
	        int orderId = 0;
	        if(rs.next()) {
	            orderId = rs.getInt(1);
	        }

	        // 3. Insert into OrderItems Table
	        String itemSql = "INSERT INTO order_items (order_id, menu_id, quantity, item_total) VALUES (?, ?, ?, ?)";
	        PreparedStatement psItem = conn.prepareStatement(itemSql);
	        for(CartItem item : cart.getItems().values()) {
	            psItem.setInt(1, orderId);
	            psItem.setInt(2, item.getMenuId());
	            psItem.setInt(3, item.getQuantity());
	            psItem.setFloat(4, item.getPrice() * item.getQuantity());
	            psItem.addBatch();
	        }
	        psItem.executeBatch();

	        conn.commit();
	        session.removeAttribute("cart");
	        response.sendRedirect("orderHistory.jsp"); // This will now trigger
	        
	    } catch (Exception e) {
	        e.printStackTrace(); // THIS WILL SHOW YOU THE ERROR IN ECLIPSE CONSOLE
	        response.getWriter().println("Order Failed: " + e.getMessage());
	    }
	}
}