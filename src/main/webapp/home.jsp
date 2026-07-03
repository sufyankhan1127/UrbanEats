<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.urbaneats.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>UrbanEats - Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; margin: 0; background: #f4f4f4; color: #333; }
        
        /* NAVBAR */
        .navbar { 
            background: white; 
            padding: 15px 80px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            position: sticky; 
            top:0; 
            z-index: 1000; 
        }
        .logo { color: #EF4444; font-size: 26px; font-weight: bold; text-decoration: none; font-family: 'Calistoga', serif; }
        
        .nav-links { display: flex; align-items: center; gap: 10px; }
        .user-name { font-weight: 600; font-size: 15px; margin-right: 15px; color: #64748B; }

        /* BUTTON EFFECTS */
        .nav-btn {
            text-decoration: none;
            color: #0F172A;
            font-weight: 700;
            font-size: 14px;
            padding: 10px 20px;
            border-radius: 100px;
            transition: all 0.3s ease;
        }

        /* Black Effect for Cart */
        .cart-btn:hover {
            background: #0F172A;
            color: white;
            transform: translateY(-2px);
        }

        /* Red Effect for Logout */
        .logout-btn:hover {
            background: #EF4444;
            color: white;
            transform: translateY(-2px);
        }

        /* MODERN ORANGE HERO */
        .hero-wrapper { padding: 30px 80px 0 80px; }
        .orange-container {
            background: linear-gradient(135deg, #FF6B35 0%, #FF9F1C 100%);
            padding: 60px;
            border-radius: 32px;
            color: white;
            box-shadow: 0 20px 40px rgba(255, 107, 53, 0.3);
        }
        .orange-container h1 { 
            font-family: 'Calistoga', serif; 
            font-size: 52px; 
            margin: 0 0 10px 0; 
            line-height: 1.1;
        }
        .orange-container h1 span { color: #0F172A; }
        .orange-container p { font-size: 20px; margin: 0; opacity: 0.9; }

        /* RESTAURANT GRID */
        .container { padding: 40px 80px; display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 35px; }
        .card { background: white; border-radius: 20px; overflow: hidden; text-decoration: none; color: black; transition: 0.3s; border: 1px solid #eee; }
        .card:hover { transform: translateY(-8px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
        .card img { width: 100%; height: 200px; object-fit: cover; background: #eee; }
        
        .info { padding: 24px; }
        .res-name { font-size: 20px; font-weight: bold; font-family: 'Calistoga', serif; }
        .cuisine { color: #64748B; font-size: 15px; margin: 5px 0 20px 0; }
        .rating { background: #22C55E; color: white; padding: 4px 10px; border-radius: 8px; font-size: 13px; font-weight: 800; }
        .meta-row { display: flex; justify-content: space-between; align-items: center; font-weight: 700; font-size: 12px; }
    </style>
</head>
<body>
<%
    // LOGIC UNTOUCHED
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    Cart cart = (Cart) session.getAttribute("cart");
    int cartSize = (cart != null) ? cart.getItems().size() : 0;
%>

<div class="navbar">
    <a href="home" class="logo">UrbanEats</a>
    <div class="nav-links">
        <span class="user-name">Hi, <%= user.getUsername() %></span>
        <a href="cart.jsp" class="nav-btn cart-btn">Cart (<%= cartSize %>)</a>
        <a href="logout" class="nav-btn logout-btn">Logout</a>
    </div>
</div>

<div class="hero-wrapper">
    <div class="orange-container">
        <h1>Premium <span>Cuisine</span> delivered.</h1>
        <p>Discover the best food and drinks in your city.</p>
    </div>
</div>

<div class="container">
    <%
        List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
        if (restaurantList != null) {
            for (Restaurant res : restaurantList) {
                // IMAGE LOGIC UNTOUCHED
                String path = res.getImagePath();
                String src = (path != null && path.startsWith("http")) ? path : request.getContextPath() + "/images/" + path;
    %>
        <a href="menu?restaurantId=<%= res.getRestaurantId() %>" class="card">
            <img src="<%= src %>" onerror="this.src='https://via.placeholder.com/400x300?text=No+Image';">
            <div class="info">
                <div class="res-name"><%= res.getName() %></div>
                <div class="res-address"><%= res.getAddress() %></div>

                <div class="cuisine"><%= res.getCuisineType() %></div>
                <div class="meta-row">
                    <span class="rating">★ <%= res.getRating() %></span>
                    <span style="color: #0F172A; letter-spacing: 0.05em;"><%= res.getDeliveryTime() %> MINS</span>
                </div>
            </div>
        </a>
    <% } } %>
</div>
</body>
</html>