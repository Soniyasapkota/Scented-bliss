package com.scentedbliss.controller;

import com.scentedbliss.service.CartService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author 23050320 Soniya Sapkota 
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/addtocart"})
public class AddtocartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cartItems;

        if (userId != null) {
            // Fetch from database
            cartItems = cartService.getCartItems(userId);
        } else {
            // Use session-based cart
            cartItems = (List<CartItem>) session.getAttribute("cartItems");
        }

        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }

        req.setAttribute("cartItems", cartItems);
        req.getRequestDispatcher("WEB-INF/pages/addtocart.jsp").forward(req, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }

        String action = req.getParameter("action");

        if (action == null || action.isEmpty()) {
            // Add item to cart
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String brand = req.getParameter("brand");
            String productImage = req.getParameter("productImage");
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            // Session update
            boolean itemExists = false;
            for (CartItem item : cartItems) {
                if (item.getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    itemExists = true;
                    break;
                }
            }
            if (!itemExists) {
                CartItem cartItem = new CartItem(productId, productName, price, brand, productImage, quantity);
                cartItems.add(cartItem);
            }

            // Database update if user is logged in
            if (userId != null) {
                Boolean result = cartService.addCartItem(userId, productId, quantity);
                if (result == null || !result) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to add product to cart in database");
                    return;
                }
            }

            session.setAttribute("cartItems", cartItems);
            response.setContentType("text/plain");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Product added to cart");
        } else if ("update".equals(action)) {
            // Update item quantity
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int cartUserProductId = Integer.parseInt(req.getParameter("cartUserProductId"));

            // Session update
            for (CartItem item : cartItems) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }

            // Database update if user is logged in
            if (userId != null) {
                Boolean result = cartService.updateCartItem(cartUserProductId, quantity);
                if (result == null || !result) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to update cart in database");
                    return;
                }
            }

            session.setAttribute("cartItems", cartItems);
            response.setContentType("text/plain");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Cart updated");
        } else if ("remove".equals(action)) {
            // Remove item from cart
            int productId = Integer.parseInt(req.getParameter("productId"));
            int cartUserProductId = Integer.parseInt(req.getParameter("cartUserProductId"));

            // Session update
            cartItems.removeIf(item -> item.getProductId() == productId);

            // Database update if user is logged in
            if (userId != null) {
                Boolean result = cartService.removeCartItem(cartUserProductId);
                if (result == null || !result) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Failed to remove item from database");
                    return;
                }
            }

            session.setAttribute("cartItems", cartItems);
            response.setContentType("text/plain");
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Item removed");
        }
    }

    // Inner class to represent a cart item
    public static class CartItem {
        private int cartUserProductId; // Added for database reference
        private int productId;
        private String productName;
        private double price;
        private String brand;
        private String productImage;
        private int quantity;

        public CartItem(int productId, String productName, double price, String brand, String productImage, int quantity) {
            this.productId = productId;
            this.productName = productName;
            this.price = price;
            this.brand = brand;
            this.productImage = productImage;
            this.quantity = quantity;
        }

        public int getCartUserProductId() { return cartUserProductId; }
        public void setCartUserProductId(int cartUserProductId) { this.cartUserProductId = cartUserProductId; }
        public int getProductId() { return productId; }
        public String getProductName() { return productName; }
        public double getPrice() { return price; }
        public String getBrand() { return brand; }
        public String getProductImage() { return productImage; }
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }
}