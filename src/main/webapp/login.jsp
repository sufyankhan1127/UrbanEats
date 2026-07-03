<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | UrbanEats</title>
    
    <!-- Match Index Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&display=swap" rel="stylesheet">
    
    <style>
        /* DESIGN TOKENS (Mirrored from Index) */
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
        }

        /* CARD STYLING */
        .auth-card {
            background: var(--card);
            width: 100%;
            max-width: 450px;
            padding: 50px;
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            border: 1px solid var(--border);
            text-align: center;
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
            margin-bottom: 20px;
        }

        h2 {
            font-family: 'Calistoga', serif;
            font-size: 3rem;
            margin-bottom: 10px;
            line-height: 1;
        }

        .subtitle {
            color: var(--muted-foreground);
            margin-bottom: 40px;
            font-size: 16px;
        }

        /* FORM STYLING */
        .form-group {
            text-align: left;
            margin-bottom: 20px;
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
            padding: 16px;
            font-family: 'Inter', sans-serif;
            font-size: 16px;
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
            margin-top: 10px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(239, 68, 68, 0.4);
        }

        /* ERROR MESSAGE */
        .error-box {
            background: #FEF2F2;
            color: #DC2626;
            padding: 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 25px;
            border: 1px solid rgba(220, 38, 38, 0.1);
        }

        .footer-links {
            margin-top: 30px;
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
    </style>
</head>
<body>

    <main class="auth-card">
        <a href="index.jsp" class="brand-link">UrbanEats Platform</a>
        
        <h2>Welcome <br><span style="color: var(--accent)">Back.</span></h2>
        <p class="subtitle">Please enter your details to continue.</p>
        
        <%-- Keep Logic exactly as it was --%>
        <% if ("invalid".equals(request.getParameter("msg"))) { %>
            <div class="error-box">
                Invalid email or password. Please try again.
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="name@company.com">
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="••••••••">
            </div>

            <button type="submit" class="btn-submit">Login to Account</button>
        </form>

        <div class="footer-links">
            Don't have an account? <a href="register.jsp">Create one now</a>
        </div>
    </main>

</body>
</html>