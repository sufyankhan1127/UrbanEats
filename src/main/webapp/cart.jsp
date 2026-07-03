<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.urbaneats.model.*, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | UrbanEats</title>
    
    <!-- Design System Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --background: #FAFAFA;
            --foreground: #0F172A;
            --muted: #F8FAFC;
            --muted-foreground: #64748B;
            --accent-red: #EF4444; 
            --border: #E2E8F0;
            --radius: 24px;
            --shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* NAVBAR */
        .navbar { 
            background: white; 
            padding: 15px 80px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            border-bottom: 1px solid var(--border);
        }
        
        .logo { 
            color: var(--accent-red); 
            font-size: 26px; 
            font-weight: bold; 
            text-decoration: none; 
            font-family: 'Calistoga', serif; 
        }

        .nav-btn {
            text-decoration: none;
            color: var(--foreground);
            font-weight: 700;
            font-size: 13px;
            padding: 10px 22px;
            border-radius: 100px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .logout-btn:hover { background: var(--accent-red); color: white; }

        /* CART CONTAINER */
        .cart-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .cart-card {
            background: white;
            width: 100%;
            max-width: 550px;
            padding: 50px;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }

        h2 {
            font-family: 'Calistoga', serif;
            font-size: 2.5rem;
            margin-bottom: 30px;
            border-bottom: 4px solid var(--foreground);
            display: inline-block;
        }

        /* CART ITEMS */
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid var(--border);
        }

        .item-info b { font-size: 18px; font-weight: 700; }
        .item-info p { color: var(--muted-foreground); font-weight: 600; }

        /* ACTIONS */
        .item-controls { display: flex; align-items: center; gap: 8px; }

        .qty-input {
            width: 50px;
            padding: 8px;
            border: 1px solid var(--border);
            border-radius: 8px;
            text-align: center;
            font-weight: 700;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 100px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.2s;
            border: 1px solid var(--border);
            background: white;
            text-transform: uppercase;
        }

        .update-btn:hover { background: var(--foreground); color: white; }
        
        .remove-btn { color: var(--accent-red); border: none; background: none; }
        .remove-btn:hover { background: #FEF2F2; color: var(--accent-red); padding: 8px 15px; }

        /* TOTAL & FOOTER */
        .total-section {
            margin-top: 30px;
            font-family: 'Calistoga', serif;
            font-size: 28px;
            text-align: right;
            color: var(--foreground);
        }

        .footer-btns {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-main {
            width: 100%;
            padding: 18px;
            border-radius: 100px;
            font-weight: 800;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        /* Black Effect Button (Proceed & Back) */
        .btn-black {
            background: var(--foreground);
            color: white;
        }
        .btn-black:hover {
            background: #000;
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
        }

        .btn-outline {
            background: white;
            color: var(--foreground);
            border: 2px solid var(--foreground);
        }
        .btn-outline:hover {
            background: var(--foreground);
            color: white;
        }

        .empty-msg {
            text-align: center;
            padding: 40px 0;
            color: var(--muted-foreground);
            font-size: 18px;
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="home" class="logo">UrbanEats</a>
        <a href="logout" class="nav-btn logout-btn">Logout</a>
    </nav>

    <main class="cart-wrapper">
        <div class="cart-card">
            <h2>Your Cart</h2>

            <%
                Cart cart = (Cart) session.getAttribute("cart");
                float total = 0; 
                
                if(cart != null && !cart.getItems().isEmpty()) {
                    for(CartItem item : cart.getItems().values()) {
                        total += (item.getPrice() * item.getQuantity());
            %>
                <div class="cart-item">
                    <div class="item-info">
                        <b><%= item.getName() %></b>
                        <p>₹<%= item.getPrice() %></p>
                    </div>

                    <form action="cart" method="post" class="item-controls">
                        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="qty-input">
                        
                        <button type="submit" name="action" value="update" class="action-btn update-btn">Update</button>
                        <button type="submit" name="action" value="remove" class="action-btn remove-btn">Remove</button>
                    </form>
                </div>
            <% 
                    }
            %>
                <div class="total-section">Total: ₹<%= total %></div>

                <div class="footer-btns">
                    <form action="checkout" method="post">
                        <button type="submit" class="btn-main btn-black">Proceed to Order</button>
                    </form>
                    
                    <a href="home" class="btn-main btn-outline">← Add More Items</a>
                </div>

            <% } else { %>
                <div class="empty-msg">
                    <p>Your cart feels a bit light...</p>
                </div>
                <a href="home" class="btn-main btn-black">Back to Restaurants</a>
            <% } %>
        </div>
    </main>

</body>
</html>