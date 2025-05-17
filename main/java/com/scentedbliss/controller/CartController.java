package com.scentedbliss.controller;

import com.scentedbliss.config.DbConfig;

import com.scentedbliss.service.CartService;

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



@WebServlet(asyncSupported = true, urlPatterns = {"/cart", "/addtocart"})
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String username = getUsernameFromCookie(request);
        System.out.println("CartController doGet: Username from cookie = " + username);
        System.out.println("CartController doGet: Session ID = " + request.getSession().getId());

        if (username == null) {
            System.out.println("CartController doGet: No username cookie found, redirecting to login");
            request.getSession().setAttribute("error", "Please log in to view your cart.");
            response.sendRedirect(request.getContextPath() + "/login?returnUrl=/cart");
            return;
        }
        request.getSession().setAttribute("username", username);
        System.out.println("CartController doGet: Set sessionScope.username = " + username);

        int userId = getUserIdByUsername(username);
        if (userId == -1) {
            System.out.println("CartController doGet: User not found for username = " + username);
            handleError(request, response, "User not found.");
            return;
        }

        Integer cartId = cartService.getCartIdByUserId(userId);
        if (cartId == null) {
            cartId = cartService.createCart(userId);
            if (cartId == null) {
                System.out.println("CartController doGet: Failed to create cart for userId = " + userId);
                handleError(request, response, "Could not create cart. Please try again later.");
                return;
            }
        }

        if ("updateQuantity".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity < 1) quantity = 1;
                boolean isUpdated = cartService.updateCartProductQuantity(cartId, productId, quantity);
                if (isUpdated) {
                    request.getSession().setAttribute("success", "Quantity updated successfully!");
                } else {
                    request.getSession().setAttribute("error", "Could not update quantity. Please try again.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid quantity or product ID.");
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("delete".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                boolean isDeleted = cartService.removeProductFromCart(cartId, productId);
                if (isDeleted) {
                    request.getSession().setAttribute("success", "Product removed from cart!");
                } else {
                    request.getSession().setAttribute("error", "Could not remove product. Please try again.");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "Invalid product ID.");
            }
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.setAttribute("cartList", cartService.getCartProducts(cartId));
        System.out.println("CartController doGet: Forwarding to cart.jsp with cartList size = " + (request.getAttribute("cartList") != null ? ((java.util.List<?>)request.getAttribute("cartList")).size() : 0));
        request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/addtocart".equals(path)) {
            String username = getUsernameFromCookie(request);
            System.out.println("CartController doPost: Username from cookie = " + username);
            System.out.println("CartController doPost: Session ID = " + request.getSession().getId());

            if (username == null) {
                System.out.println("CartController doPost: No username cookie found");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("Please log in to add items to your cart.");
                return;
            }
            request.getSession().setAttribute("username", username);
            System.out.println("CartController doPost: Set sessionScope.username = " + username);

            int userId = getUserIdByUsername(username);
            if (userId == -1) {
                System.out.println("CartController doPost: User not found for username = " + username);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("User not found.");
                return;
            }

            Integer cartId = cartService.getCartIdByUserId(userId);
            if (cartId == null) {
                cartId = cartService.createCart(userId);
                if (cartId == null) {
                    System.out.println("CartController doPost: Failed to create cart for userId = " + userId);
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Could not create cart. Please try again later.");
                    return;
                }
            }

            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                boolean isAdded = cartService.addProductToCart(cartId, productId, quantity);
                if (isAdded) {
                    System.out.println("CartController doPost: Product added to cart, productId = " + productId);
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("Product added to cart!");
                } else {
                    System.out.println("CartController doPost: Failed to add product, productId = " + productId);
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Failed to add product to cart.");
                }
            } catch (NumberFormatException e) {
                System.out.println("CartController doPost: Invalid productId or quantity");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid product ID or quantity.");
            }
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

    private int getUserIdByUsername(String username) {
        String query = "SELECT userId FROM users WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("userId");
                System.out.println("getUserIdByUsername: Found userId = " + userId + " for username = " + username);
                return userId;
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("SQL Error during user ID retrieval: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("getUserIdByUsername: No userId found for username = " + username);
        return -1;
    }

    private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
            throws ServletException, IOException {
        System.out.println("handleError: " + message);
        req.setAttribute("error", message);
        req.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(req, resp);
    }
}