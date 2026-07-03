<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UrbanEats | Premium Food Delivery</title>
    
    <!-- Design System Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Calistoga&family=JetBrains+Mono:wght@500&display=swap" rel="stylesheet">
    
    <style>
        /* DESIGN TOKENS */
        :root {
            --background: #FAFAFA;
            --foreground: #0F172A;
            --muted: #F1F5F9;
            --muted-foreground: #64748B;
            --accent: #EF4444; /* Premium Red */
            --accent-secondary: #F87171;
            --accent-gradient: linear-gradient(135deg, #EF4444, #F87171);
            --border: #E2E8F0;
            --card: #FFFFFF;
            --radius: 16px;
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.07);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            --shadow-accent: 0 10px 15px -3px rgba(239, 68, 68, 0.2);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--background);
            color: var(--foreground);
            line-height: 1.5;
            overflow-x: hidden;
        }

        /* TYPOGRAPHY */
        h1, h2 { 
            font-family: 'Calistoga', serif; 
            font-weight: 400; 
            line-height: 1.05;
            letter-spacing: -0.02em;
        }

        .gradient-text {
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* NEW BOLD BRAND HEADING */
        .brand-label {
            display: block;
            font-family: 'Inter', sans-serif;
            font-weight: 800;
            font-size: 1.25rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 1rem;
        }

        /* HERO SECTION */
        .hero {
            padding: 100px 80px;
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            align-items: center;
            gap: 60px;
            max-width: 1400px;
            margin: 0 auto;
            min-height: 90vh;
        }

        .hero-title { 
            font-size: clamp(3.5rem, 7vw, 5.5rem); 
            margin-bottom: 24px; 
            color: var(--foreground);
        }

        .hero-desc { 
            font-size: 22px; 
            color: var(--muted-foreground); 
            max-width: 550px; 
            margin-bottom: 40px;
            font-weight: 400;
        }

        .btn-group { display: flex; gap: 16px; align-items: center; }

        .btn {
            padding: 18px 36px;
            border-radius: var(--radius);
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 18px;
            display: inline-flex;
            align-items: center;
        }

        .btn-primary {
            background: var(--accent-gradient);
            color: white;
            box-shadow: var(--shadow-accent);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 30px -5px rgba(239, 68, 68, 0.4);
        }

        .btn-secondary {
            background: var(--card);
            color: var(--foreground);
            border: 2px solid var(--border);
        }

        .btn-secondary:hover { 
            background: var(--muted);
            border-color: var(--accent);
        }

        /* HERO IMAGE / FLOATING UI */
        .hero-visual {
            position: relative;
            height: 500px;
            background: radial-gradient(circle at center, rgba(239, 68, 68, 0.08) 0%, transparent 70%);
        }

        .floating-card {
            position: absolute;
            background: var(--card);
            padding: 24px;
            border-radius: 20px;
            box-shadow: var(--shadow-xl);
            animation: float 6s ease-in-out infinite;
            border: 1px solid var(--border);
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        /* TECHNICAL GRID */
        .tech-section {
            background-color: var(--foreground);
            color: white;
            padding: 100px 80px;
            position: relative;
        }

        .tech-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .tech-card {
            padding: 30px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--radius);
        }

        .tech-card h3 {
            font-size: 13px;
            font-family: 'JetBrains Mono', monospace;
            color: var(--accent-secondary);
            margin-bottom: 15px;
        }

        /* RESPONSIVE */
        @media (max-width: 1024px) {
            .hero { grid-template-columns: 1fr; padding: 60px 24px; text-align: center; }
            .hero-desc { margin-left: auto; margin-right: auto; }
            .btn-group { justify-content: center; }
            .hero-visual { display: none; }
            .tech-grid { grid-template-columns: 1fr 1fr; }
        }
    </style>
</head>
<body>

    <main>
        <!-- SECTION 01: HERO -->
        <section class="hero">
            <div class="hero-content">
                <!-- NEW BOLD BRANDING -->
                <span class="brand-label">UrbanEats Platform 1.0</span>
                
                <h1 class="hero-title">Delicious food, <br>delivered <span class="gradient-text">faster.</span></h1>
                
                <!-- SIMPLIFIED ATTRACTIVE QUOTE -->
                <p class="hero-desc">
                    Craving something amazing? Order from your favorite local restaurants 
                    and get fresh, hot meals delivered to your doorstep in minutes.
                </p>
                
                <div class="btn-group">
                    <a href="login.jsp" class="btn btn-primary">Login Now</a>
                    <a href="register.jsp" class="btn btn-secondary">Join UrbanEats</a>
                </div>
            </div>

            <!-- ANIMATED HERO GRAPHIC -->
            <div class="hero-visual">
                <!-- Floating "Order" Card -->
                <div class="floating-card" style="top: 80px; left: 40px; width: 300px;">
                    <div style="display: flex; gap: 15px; align-items: center;">
                        <div style="width: 60px; height: 60px; background: var(--accent-gradient); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">🍕</div>
                        <div>
                            <div style="height: 12px; width: 140px; background: var(--muted); margin-bottom: 8px; border-radius: 4px;"></div>
                            <div style="height: 12px; width: 90px; background: var(--muted); border-radius: 4px;"></div>
                        </div>
                    </div>
                </div>
                <!-- Second floating card -->
                <div class="floating-card" style="bottom: 80px; right: 40px; width: 260px; animation-delay: -3s;">
                    <div style="height: 160px; background: #FFF5F5; border-radius: 10px; margin-bottom: 15px; display: flex; align-items: center; justify-content: center; font-size: 40px;">🍔</div>
                    <div style="height: 12px; width: 100%; background: var(--accent); opacity: 0.2; border-radius: 4px;"></div>
                </div>
            </div>
        </section>

        <!-- SECTION 02: TECHNICAL MANIFESTO (Simplified) -->
        <section class="tech-section">
            <div class="tech-grid">
                <div class="tech-card">
                    <h3>01 / FAST DELIVERY</h3>
                    <p style="font-size: 14px; opacity: 0.7;">Route optimization for the quickest delivery times.</p>
                </div>
                <div class="tech-card">
                    <h3>02 / LIVE TRACKING</h3>
                    <p style="font-size: 14px; opacity: 0.7;">Know exactly where your food is at every second.</p>
                </div>
                <div class="tech-card">
                    <h3>03 / TOP VENDORS</h3>
                    <p style="font-size: 14px; opacity: 0.7;">Only the best-rated local restaurants make our list.</p>
                </div>
                <div class="tech-card">
                    <h3>04 / SECURE PAY</h3>
                    <p style="font-size: 14px; opacity: 0.7;">Industrial-grade encryption for all your transactions.</p>
                </div>
            </div>
        </section>
    </main>

</body>
</html>