package com.urbaneats.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.urbaneats.model.User;
import com.urbaneats.daoimpl.UserDAOImpl;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String addr = request.getParameter("address");

        User user = new User(name, email, pass, addr);
        UserDAOImpl userDAO = new UserDAOImpl();
        
        int result = userDAO.registerUser(user);
        
        if(result > 0) {
            // Registration success -> Go to Login
            response.sendRedirect("login.jsp?msg=success");
        } else {
            response.sendRedirect("register.jsp?msg=failed");
        }
    }
}