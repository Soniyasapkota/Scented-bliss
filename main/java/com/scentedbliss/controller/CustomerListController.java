package com.scentedbliss.controller;

import com.scentedbliss.model.UserModel;
import com.scentedbliss.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/customerlist", "/removeCustomer"})
public class CustomerListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<UserModel> customers = userService.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/WEB-INF/pages/customerlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        if (username != null && !username.trim().isEmpty()) {
            boolean success = userService.removeCustomer(username);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/customerlist");
            } else {
                request.setAttribute("error", "Failed to remove customer: " + username);
                List<UserModel> customers = userService.getAllCustomers();
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/WEB-INF/pages/customerlist.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid username provided.");
            List<UserModel> customers = userService.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("/WEB-INF/pages/customerlist.jsp").forward(request, response);
        }
    }
}