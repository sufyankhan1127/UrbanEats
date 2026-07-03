package com.urbaneats.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.urbaneats.dao.MenuDAO;
import com.urbaneats.daoimpl.MenuDAOImpl;
import com.urbaneats.model.Menu;
import com.urbaneats.model.User;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Security Check
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Get Restaurant ID from URL
        String restaurantIdStr = request.getParameter("restaurantId");
        if (restaurantIdStr != null) {
            int restaurantId = Integer.parseInt(restaurantIdStr);
            
            // 3. Fetch Menu for this restaurant
            MenuDAO menuDAO = new MenuDAOImpl();
            List<Menu> menuList = menuDAO.getMenuByRestaurant(restaurantId);
            
            request.setAttribute("menuList", menuList);
            request.getRequestDispatcher("menu.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}