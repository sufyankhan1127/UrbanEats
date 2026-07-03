package com.urbaneats.controller;

import java.io.IOException;
import java.util.List;

// Use jakarta instead of javax
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.urbaneats.dao.RestaurantDAO;
import com.urbaneats.daoimpl.RestaurantDAOImpl;
import com.urbaneats.model.Restaurant;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    if(session.getAttribute("loggedInUser") == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }
	    
	    RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();
        
        request.setAttribute("restaurantList", restaurantList);
        

        request.getRequestDispatcher("home.jsp").forward(request, response);
	}
    
}