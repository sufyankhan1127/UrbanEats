<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.urbaneats.model.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu | UrbanEats</title>
    
    <!-- Design System Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --background: #FFFFFF;
            --foreground: #0F172A;
            --muted: #F8FAFC;
            --muted-foreground: #64748B;
            --accent-red: #EF4444; 
            --border: #E2E8F0;
            --radius: 16px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            line-height: 1.6;
        }

        /* NAVBAR */
        .navbar { 
            background: white; 
            padding: 15px 80px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            position: sticky; 
            top: 0; 
            z-index: 1000;
            border-bottom: 1px solid var(--border);
        }
        
        .logo { 
            color: var(--accent-red); 
            font-size: 26px; 
            font-weight: bold; 
            text-decoration: none; 
            font-family: 'Calistoga', serif; 
        }

        .nav-right { display: flex; align-items: center; gap: 10px; }
        .user-name { font-weight: 600; font-size: 14px; margin-right: 15px; color: var(--muted-foreground); }

        /* REUSABLE BUTTON STYLE (Used for Nav and Back Button) */
        .nav-btn {
            text-decoration: none;
            color: var(--foreground);
            font-weight: 700;
            font-size: 13px;
            padding: 10px 22px;
            border-radius: 100px;
            transition: all 0.3s ease;
            display: inline-block;
            border: 1px solid transparent;
        }

        /* Black Effect for Cart and Back Button */
        .effect-black:hover { 
            background: #0F172A; 
            color: white; 
            transform: translateY(-2px);
        }

        /* Red Effect for Logout */
        .logout-btn:hover { background: var(--accent-red); color: white; transform: translateY(-2px); }

        /* MENU LAYOUT */
        .menu-container { max-width: 900px; margin: 40px auto; padding: 0 40px; }
        
        .header-section {
            margin-bottom: 50px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 30px;
        }

        /* BACK BUTTON PLACEMENT */
        .back-btn-wrapper {
            margin-bottom: 25px;
        }

        h1 { 
            font-family: 'Calistoga', serif; 
            font-size: 3.5rem; 
            display: block; 
            color: var(--foreground);
            margin-top: 10px;
        }

        /* MENU ITEMS */
        .menu-item { 
            display: flex; 
            justify-content: space-between; 
            align-items: flex-start; 
            padding: 40px 0; 
            border-bottom: 1px solid var(--border);
        }

        .item-details { flex: 1; padding-right: 40px; }
        .item-name { font-size: 22px; font-weight: 700; color: var(--foreground); margin-bottom: 8px; }
        .item-price { font-weight: 800; font-size: 18px; color: var(--foreground); margin-bottom: 12px; }
        .item-desc { color: var(--muted-foreground); font-size: 15px; max-width: 550px; }

        /* ACTION AREA */
        .item-action { text-align: center; width: 150px; }
        
        .item-img { 
            width: 140px; 
            height: 120px; 
            border-radius: var(--radius); 
            object-fit: cover; 
            margin-bottom: 15px; 
            background: var(--muted); 
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .qty-input {
            width: 60px;
            padding: 8px;
            border: 1px solid var(--border);
            border-radius: 8px;
            text-align: center;
            font-weight: 700;
            margin-bottom: 10px;
            outline: none;
        }

        .add-btn { 
            background: white; 
            color: var(--foreground); 
            border: 2px solid var(--foreground); 
            padding: 12px 0; 
            font-weight: 800; 
            cursor: pointer; 
            border-radius: 12px; 
            width: 100%; 
            transition: all 0.3s ease;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .add-btn:hover { 
            background: var(--foreground); 
            color: white; 
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .navbar { padding: 15px 30px; }
            .menu-container { padding: 0 20px; }
            .menu-item { flex-direction: column-reverse; }
            .item-action { width: 100%; display: flex; gap: 20px; align-items: center; margin-bottom: 20px;}
            .item-img { margin-bottom: 0; }
        }
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

<!-- NAVIGATION -->
<nav class="navbar">
    <a href="home" class="logo">UrbanEats</a>
    <div class="nav-right">
        <span class="user-name">Hi, <%= user.getUsername() %></span>
        <a href="cart.jsp" class="nav-btn effect-black">Cart (<%= cartSize %>)</a>
        <a href="logout" class="nav-btn logout-btn">Logout</a>
    </div>
</nav>

<div class="menu-container">
    <div class="header-section">
        <div class="back-btn-wrapper">
            <!-- BACK BUTTON WITH CART-STYLE HOVER EFFECT -->
            <a href="home" class="nav-btn effect-black" style="border: 1px solid var(--border); padding: 8px 20px;">
               ← Back to Restaurants
            </a>
        </div>
        <h1>Menu</h1>
    </div>

    <%
        // BUSINESS LOGIC UNTOUCHED
        List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
        if (menuList != null && !menuList.isEmpty()) {
            for (Menu item : menuList) {
                // IMAGE PATH LOGIC UNTOUCHED
                String mPath = item.getImagePath();
                String mSrc = (mPath != null && mPath.startsWith("http")) ? mPath : request.getContextPath() + "/images/" + mPath;
    %>
        <div class="menu-item">
            <div class="item-details">
                <div class="item-name"><%= item.getItemName() %></div>
                <div class="item-price">₹<%= item.getPrice() %></div>
                <div class="item-desc"><%= item.getDescription() %></div>
            </div>
            
            <div class="item-action">
                <img src="<%= mSrc %>" class="item-img" onerror="this.src='https://via.placeholder.com/200x150?text=Food';">
                
                <form action="cart" method="post">
                    <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                    <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                    <input type="hidden" name="action" value="add">
                    
                    <input type="number" name="quantity" value="1" min="1" class="qty-input">
                    <button type="submit" class="add-btn">ADD TO CART</button>
                </form>
            </div>
        </div>
    <% } } else { %>
        <div style="text-align: center; padding: 60px; color: var(--muted-foreground);">
            <p>No items found for this restaurant.</p>
        </div>
    <% } %>
</div>

</body>
</html>