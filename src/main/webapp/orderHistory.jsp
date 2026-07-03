<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.urbaneats.util.DBConnection, com.urbaneats.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | UrbanEats</title>
    
    <!-- Design System Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --background: #FAFAFA;
            --foreground: #0F172A;
            --muted: #F8FAFC;
            --muted-foreground: #64748B;
            --accent-red: #EF4444; 
            --accent-orange: #FF6B35;
            --border: #E2E8F0;
            --radius: 20px;
            --shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
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

        .nav-right { display: flex; align-items: center; gap: 15px; }
        .user-info { font-weight: 600; font-size: 14px; color: var(--muted-foreground); margin-right: 10px; }

        .nav-btn {
            text-decoration: none;
            color: var(--foreground);
            font-weight: 700;
            font-size: 13px;
            padding: 10px 22px;
            border-radius: 100px;
            transition: all 0.3s ease;
        }

        /* Black Effect for Home */
        .home-btn:hover { background: var(--foreground); color: white; transform: translateY(-2px); }
        /* Red Effect for Logout */
        .logout-btn:hover { background: var(--accent-red); color: white; transform: translateY(-2px); }

        /* CONTENT */
        .container { max-width: 850px; margin: 50px auto; padding: 0 20px; }
        
        h2 { 
            font-family: 'Calistoga', serif; 
            font-size: 2.5rem; 
            margin-bottom: 40px;
            border-bottom: 4px solid var(--foreground);
            display: inline-block;
        }

        /* ORDER CARD */
        .order-card { 
            background: white; 
            padding: 30px; 
            border-radius: var(--radius); 
            margin-bottom: 25px; 
            box-shadow: var(--shadow); 
            border: 1px solid var(--border);
            transition: transform 0.2s ease;
        }
        
        .order-card:hover { transform: scale(1.01); }

        .order-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            border-bottom: 1px solid var(--muted); 
            padding-bottom: 15px; 
            margin-bottom: 20px; 
        }

        .order-id { 
            font-weight: 800; 
            color: var(--accent-orange); 
            font-size: 18px;
            letter-spacing: 0.05em;
        }

        .order-date { color: var(--muted-foreground); font-size: 14px; font-weight: 500; }

        .order-body { display: flex; justify-content: space-between; align-items: flex-end; }

        .amount-box b { font-size: 24px; color: var(--foreground); }
        .status-tag { 
            display: inline-block;
            margin-top: 8px;
            padding: 4px 12px;
            background: #DCFCE7;
            color: #166534;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .order-again {
            color: var(--foreground);
            font-weight: 700;
            text-decoration: none;
            font-size: 14px;
            padding: 8px 16px;
            border: 2px solid var(--foreground);
            border-radius: 100px;
            transition: 0.2s;
        }

        .order-again:hover { background: var(--foreground); color: white; }

        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 80px 0;
            background: white;
            border-radius: var(--radius);
            border: 1px dashed var(--border);
        }

        .empty-state p { color: var(--muted-foreground); margin-bottom: 25px; font-size: 18px; }

        @media (max-width: 768px) {
            .navbar { padding: 15px 30px; }
            .nav-right span { display: none; }
        }
    </style>
</head>
<body>

<%
    // 1. Security Check (Untouched)
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- NAVIGATION -->
<nav class="navbar">
    <a href="home" class="logo">UrbanEats</a>
    <div class="nav-right">
        <span class="user-info">Logged in as: <b><%= user.getUsername() %></b></span>
        <a href="home" class="nav-btn home-btn">Home</a>
        <a href="logout" class="nav-btn logout-btn">Logout</a>
    </div>
</nav>

<div class="container">
    <h2>Your Order History</h2>
    
    <%
        // 2. Fetch orders (Logic Untouched)
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getUserId());
            ResultSet rs = ps.executeQuery();

            boolean hasOrders = false;
            while (rs.next()) {
                hasOrders = true;
    %>
        <div class="order-card">
            <div class="order-header">
                <span class="order-id">#ORD-<%= rs.getInt("order_id") %></span>
                <span class="order-date"><%= rs.getTimestamp("order_date") %></span>
            </div>
            
            <div class="order-body">
                <div class="amount-box">
                    <p style="font-size: 14px; color: var(--muted-foreground); margin-bottom: 2px;">Total Paid</p>
                    <b>₹<%= rs.getFloat("total_amount") %></b><br>
                    <span class="status-tag"><%= rs.getString("status") %></span>
                </div>
                <a href="home" class="order-again">Order Again</a>
            </div>
        </div>
    <%
            }
            if (!hasOrders) {
    %>
        <div class="empty-state">
            <p>You haven't placed any orders yet.</p>
            <a href="home" class="nav-btn home-btn" style="background: var(--foreground); color: white; padding: 15px 40px;">Explore Restaurants</a>
        </div>
    <%
            }
        } catch (Exception e) {
    %>
        <div style="background: #FEF2F2; color: #DC2626; padding: 20px; border-radius: 12px; font-weight: 600;">
            Error loading your order history. Please refresh the page.
        </div>
    <%
        }
    %>
</div>

</body>
</html>