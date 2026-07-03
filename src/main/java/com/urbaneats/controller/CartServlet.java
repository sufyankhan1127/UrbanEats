package com.urbaneats.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.urbaneats.dao.MenuDAO;
import com.urbaneats.daoimpl.MenuDAOImpl;
import com.urbaneats.model.Cart;
import com.urbaneats.model.CartItem;
import com.urbaneats.model.Menu;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Get or Create Session and Cart
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // 2. Get parameters from the request
        String action = request.getParameter("action");
        int menuId = Integer.parseInt(request.getParameter("menuId"));

        try {
            // 3. Handle specific actions
            if ("add".equals(action)) {
                addItem(request, cart);
            } else if ("update".equals(action)) {
                updateItem(request, cart);
            } else if ("remove".equals(action)) {
                removeItem(request, cart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. Update the session and redirect
        session.setAttribute("cart", cart);

        // Logic: If added from menu, stay on menu. If updated in cart, stay in cart.
        if ("add".equals(action)) {
            // Redirect back to the menu of the restaurant we are currently ordering from
            String restaurantId = request.getParameter("restaurantId");
            response.sendRedirect("menu?restaurantId=" + restaurantId);
        } else {
            response.sendRedirect("cart.jsp");
        }
    }

    // Helper method to add an item
    private void addItem(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        MenuDAO menuDAO = new MenuDAOImpl();
        Menu menuItem = menuDAO.getMenuById(menuId);

        if (menuItem != null) {
            CartItem cartItem = new CartItem(
                menuItem.getMenuId(),
                menuItem.getRestaurantId(),
                menuItem.getItemName(),
                quantity,
                menuItem.getPrice()
            );
            cart.addItem(cartItem);
        }
    }

    // Helper method to update quantity
    private void updateItem(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        cart.updateItem(menuId, quantity);
    }

    // Helper method to remove an item
    private void removeItem(HttpServletRequest request, Cart cart) {
        int menuId = Integer.parseInt(request.getParameter("menuId"));
        cart.removeItem(menuId);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // If someone tries to access /cart via URL, just show them the cart page
        response.sendRedirect("cart.jsp");
    }
}