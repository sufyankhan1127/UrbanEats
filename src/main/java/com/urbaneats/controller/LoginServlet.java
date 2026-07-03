package com.urbaneats.controller;

import java.io.IOException;

import com.urbaneats.daoimpl.UserDAOImpl;
import com.urbaneats.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        
        UserDAOImpl userDAO = new UserDAOImpl();
        User user = userDAO.login(email, pass);
        
        if(user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            // REDIRECT TO HOME SERVLET
            response.sendRedirect("home"); 
        } else {
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}