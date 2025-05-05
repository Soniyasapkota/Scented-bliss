package com.scentedbliss.service;

import com.scentedbliss.config.DbConfig;
import com.scentedbliss.controller.AddtocartController.CartItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public CartService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    private int ensureCartExists(int userId) throws SQLException {
        String selectQuery = "SELECT cartId FROM cart WHERE userId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
        }

        String insertQuery = "INSERT INTO cart (userId, quantity, createdAt) VALUES (?, 0, CURRENT_TIMESTAMP)";
        try (PreparedStatement stmt = dbConn.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        throw new SQLException("Failed to create cart for userId: " + userId);
    }

    public Boolean addCartItem(int userId, int productId, int quantity) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        try {
            int cartId = ensureCartExists(userId);

            // Check if the item already exists for the user
            String selectQuery = "SELECT cart_user_product_ID, quantity FROM cart_user_product WHERE userId = ? AND productId = ?";
            try (PreparedStatement selectStmt = dbConn.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, userId);
                selectStmt.setInt(2, productId);
                ResultSet rs = selectStmt.executeQuery();
                if (rs.next()) {
                    // Item exists, update quantity
                    int cartUserProductId = rs.getInt("cart_user_product_ID");
                    int currentQuantity = rs.getInt("quantity");
                    return updateCartItem(cartUserProductId, currentQuantity + quantity);
                }
            }

            // Item does not exist, insert new
            String insertQuery = "INSERT INTO cart_user_product (cartId, userId, productId, quantity) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = dbConn.prepareStatement(insertQuery)) {
                stmt.setInt(1, cartId);
                stmt.setInt(2, userId);
                stmt.setInt(3, productId);
                stmt.setInt(4, quantity);
                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during cart item addition: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public Boolean updateCartItem(int cartUserProductId, int quantity) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String updateQuery = "UPDATE cart_user_product SET quantity = ? WHERE cart_user_product_ID = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(updateQuery)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartUserProductId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error during cart item update: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public Boolean removeCartItem(int cartUserProductId) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String deleteQuery = "DELETE FROM cart_user_product WHERE cart_user_product_ID = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setInt(1, cartUserProductId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error during cart item deletion: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<CartItem> getCartItems(int userId) {
        if (isConnectionError) {
            System.err.println("Connection Error!");
            return null;
        }

        String query = "SELECT cup.cart_user_product_ID, cup.productId, cup.quantity, p.productName, p.price, p.brand, p.productImage " +
                      "FROM cart_user_product cup " +
                      "JOIN products p ON cup.productId = p.productId " +
                      "WHERE cup.userId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            List<CartItem> cartItems = new ArrayList<>();
            while (rs.next()) {
                CartItem item = new CartItem(
                    rs.getInt("productId"),
                    rs.getString("productName"),
                    rs.getDouble("price"),
                    rs.getString("brand"),
                    rs.getString("productImage"),
                    rs.getInt("quantity")
                );
                item.setCartUserProductId(rs.getInt("cart_user_product_ID"));
                cartItems.add(item);
            }
            rs.close();
            return cartItems;
        } catch (SQLException e) {
            System.err.println("SQL Error during cart retrieval: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}