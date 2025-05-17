package com.scentedbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.scentedbliss.service.OrderService;

@WebServlet(asyncSupported = true, urlPatterns = { "/orderItems" })
public class OrderItemsController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderService orderService = new OrderService();

    public OrderItemsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Log the incoming request
        System.out.println("OrderItemsController: doGet called with orderId=" + request.getParameter("orderId"));

        // Get orderId from request parameter
        String orderIdParam = request.getParameter("orderId");
        int orderId = (orderIdParam != null && !orderIdParam.isEmpty()) ? Integer.parseInt(orderIdParam) : -1;

        if (orderId != -1) {
            // Fetch order items and set attributes
            request.setAttribute("orderItems", orderService.getOrderItems(orderId));
            request.setAttribute("orderId", orderId);
            // Forward to orderItems.jsp
            request.getRequestDispatcher("/WEB-INF/pages/orderItems.jsp").forward(request, response);
        } else {
            // Redirect to orders page if orderId is invalid
            System.out.println("OrderItemsController: Invalid orderId, redirecting to /orders");
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}