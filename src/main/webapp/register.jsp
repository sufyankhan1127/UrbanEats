<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join | UrbanEats</title>
    
    <!-- Match Index/Login Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    
    <style>
        /* DESIGN TOKENS */
        :root {
            --background: #FAFAFA;
            --foreground: #0F172A;
            --muted: #F1F5F9;
            --muted-foreground: #64748B;
            --accent: #EF4444; 
            --accent-gradient: linear-gradient(135deg, #EF4444, #F87171);
            --border: #E2E8F0;
            --card: #FFFFFF;
            --radius: 16px;
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            --shadow-accent: 0 10px 15px -3px rgba(239, 68, 68, 0.2);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        /* CARD STYLING */
        .auth-card {
            background: var(--card);
            width: 100%;
            max-width: 600px; /* Slightly wider for registration grid */
            padding: 50px;
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--border);
        }

        .header-area {
            text-align: center;
            margin-bottom: 40px;
        }

        .brand-link {
            font-family: 'Inter', sans-serif;
            font-weight: 800;
            font-size: 14px;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: var(--accent);
            text-decoration: none;
            display: inline-block;
            margin-bottom: 15px;
        }

        h2 {
            font-family: 'Calistoga', serif;
            font-size: 3rem;
            line-height: 1;
            margin-bottom: 10px;
        }

        .subtitle {
            color: var(--muted-foreground);
            font-size: 16px;
        }

        /* FORM STYLING */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .full-width {
            grid-column: span 2;
        }

        .form-group {
            margin-bottom: 5px;
        }

        label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            margin-bottom: 8px;
            color: var(--foreground);
            padding-left: 4px;
        }

        input {
            width: 100%;
            padding: 14px 16px;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            background: var(--background);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            outline: none;
            transition: all 0.2s ease;
        }

        input:focus {
            border-color: var(--accent);
            background: white;
            box-shadow: 0 0 0 4px rgba(239, 68, 68, 0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 18px;
            background: var(--accent-gradient);
            color: white;
            border: none;
            border-radius: var(--radius);
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-accent);
            margin-top: 20px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(239, 68, 68, 0.4);
        }

        .footer-links {
            margin-top: 30px;
            text-align: center;
            font-size: 14px;
            color: var(--muted-foreground);
        }

        .footer-links a {
            color: var(--accent);
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        /* RESPONSIVE */
        @media (max-width: 600px) {
            .form-grid { grid-template-columns: 1fr; }
            .full-width { grid-column: span 1; }
            .auth-card { padding: 30px 20px; }
            h2 { font-size: 2.25rem; }
        }
    </style>
</head>
<body>

    <main class="auth-card">
        <div class="header-area">
            <a href="index.jsp" class="brand-link">UrbanEats Platform</a>
            <h2>Join the <br><span style="color: var(--accent)">Community.</span></h2>
            <p class="subtitle">Create your account to start ordering.</p>
        </div>

        <form action="register" method="post" class="form-grid">
            <div class="form-group full-width">
                <label>Username</label>
                <input type="text" name="username" required placeholder="Pick a unique username">
            </div>

            <div class="form-group full-width">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="name@example.com">
            </div>

            <div class="form-group full-width">
                <label>Password</label>
                <input type="password" name="password" required placeholder="••••••••">
            </div>

            <div class="form-group full-width">
                <label>Delivery Address</label>
                <input type="text" name="address" required placeholder="Street, Building, Apartment No.">
            </div>

            <div class="full-width">
                <button type="submit" class="btn-submit">Create My Account</button>
            </div>
        </form>

        <div class="footer-links">
            Already have an account? <a href="login.jsp">Log in here</a>
        </div>
    </main>

</body>
</html>