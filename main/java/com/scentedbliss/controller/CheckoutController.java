package com.scentedbliss.controller;

import com.scentedbliss.config.DbConfig;
import com.scentedbliss.model.ProductModel;
import com.scentedbliss.service.CartService;
import com.scentedbliss.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet(asyncSupported = true, urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CartService cartService = new CartService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve username from cookie
        String username = getUsernameFromCookie(request);
        System.out.println("CheckoutController doPost: Username from cookie = " + username);
        System.out.println("CheckoutController doPost: Session ID = " + request.getSession().getId());

        // Check if user is logged in
        if (username == null) {
            System.out.println("CheckoutController doPost: No username cookie found");
            request.getSession().setAttribute("error", "Please log in to proceed with checkout.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        request.getSession().setAttribute("username", username);
        System.out.println("CheckoutController doPost: Set sessionScope.username = " + username);

        // Get user ID
        int userId = orderService.getUserIdByUsername(username);
        if (userId == -1) {
            System.out.println("CheckoutController doPost: User not found for username = " + username);
            request.getSession().setAttribute("error", "User not found.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Get cart ID
        Integer cartId = cartService.getCartIdByUserId(userId);
        if (cartId == null) {
            System.out.println("CheckoutController doPost: No cart found for userId = " + userId);
            request.getSession().setAttribute("error", "No cart found. Please add items to your cart.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Retrieve cart items
        List<ProductModel> cartItems = cartService.getCartProducts(cartId);
        if (cartItems.isEmpty()) {
            System.out.println("CheckoutController doPost: Cart is empty for userId = " + userId);
            request.getSession().setAttribute("error", "Your cart is empty. Add items to proceed with checkout.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate total amount
        double totalAmount = 0.0;
        for (ProductModel item : cartItems) {
            totalAmount += item.getPrice() * item.getQuantity();
        }
        totalAmount += (request.getSession().getAttribute("shippingFee") != null ?
                (Double) request.getSession().getAttribute("shippingFee") : 10.00);

        // Get user's shipping address
        String address = orderService.getUserAddress(userId);
        if (address == null) {
            System.out.println("CheckoutController doPost: No address found for userId = " + userId);
            request.getSession().setAttribute("error", "Please set an address before checkout.");
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);
            try {
                // Create order
                String insertOrderSql = "INSERT INTO orders (orderDate, totalAmount, shippingAddress, userId) VALUES (NOW(), ?, ?, ?)";
                PreparedStatement orderStmt = conn.prepareStatement(insertOrderSql, PreparedStatement.RETURN_GENERATED_KEYS);
                orderStmt.setDouble(1, totalAmount);
                orderStmt.setString(2, address);
                orderStmt.setInt(3, userId);
                int affectedRows = orderStmt.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating order failed, no rows affected.");
                }

                ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                if (!generatedKeys.next()) {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
                int orderId = generatedKeys.getInt(1);

                // Insert order items
                String insertOrderItemSql = "INSERT INTO orderItems (quantity, unitPrice, subTotal, orderId, productId) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSql);
                for (ProductModel item : cartItems) {
                    itemStmt.setInt(1, item.getQuantity());
                    itemStmt.setDouble(2, item.getPrice());
                    itemStmt.setDouble(3, item.getPrice() * item.getQuantity());
                    itemStmt.setInt(4, orderId);
                    itemStmt.setInt(5, item.getProductId());
                    itemStmt.addBatch();
                }
                int[] batchResults = itemStmt.executeBatch();
                for (int result : batchResults) {
                    if (result <= 0) {
                        throw new SQLException("Failed to insert some order items.");
                    }
                }
                
             // Redirect to order confirmation
                System.out.println("CheckoutController doPost: Order created successfully, orderId = " + orderId);
                response.sendRedirect(request.getContextPath() + "/orderComplete");
                
                

                // Clear cart
                String clearCartSql = "DELETE FROM cart_product WHERE cartId = ?";
                PreparedStatement clearStmt = conn.prepareStatement(clearCartSql);
                clearStmt.setInt(1, cartId);
                clearStmt.executeUpdate();

                // Commit transaction
                conn.commit();

                
                

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("CheckoutController doPost: Error processing checkout: " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error processing checkout. Please try again.");
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    private String getUsernameFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    System.out.println("getUsernameFromCookie: Found username cookie = " + cookie.getValue());
                    return cookie.getValue();
                }
            }
        }
        System.out.println("getUsernameFromCookie: No username cookie found");
        return null;
    }
}