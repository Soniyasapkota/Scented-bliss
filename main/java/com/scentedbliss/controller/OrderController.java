package com.scentedbliss.controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.scentedbliss.service.OrderService;


/**
 * Servlet implementation class OrderController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/orders" })
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderService orderService = new OrderService();

    public OrderController() {
        super();
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch all products from the database
        request.setAttribute("orders", orderService.getAllOrders());

        request.getRequestDispatcher("/WEB-INF/pages/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}