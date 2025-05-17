package com.scentedbliss.service;

import com.scentedbliss.config.DbConfig;
import com.scentedbliss.model.ProductModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CartService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public CartService() {
        initializeConnection();
    }

    private void initializeConnection() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    public Integer getCartIdByUserId(int userId) {
        if (isConnectionError) {
            System.err.println("Cannot fetch cart ID due to connection error");
            reconnectIfNeeded();
            return null;
        }

        String query = "SELECT cartId FROM cart WHERE userId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("cartId");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during cart ID retrieval: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
        }
        return null;
    }

    public Integer createCart(int userId) {
        if (isConnectionError) {
            System.err.println("Cannot create cart due to connection error");
            reconnectIfNeeded();
            return null;
        }

        String insertQuery = "INSERT INTO cart (userId, createdAt) VALUES (?, ?)";
        try (PreparedStatement stmt = dbConn.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            // For testing, set to current time (06:11 PM +0545, May 13, 2025)
            stmt.setTimestamp(2, Timestamp.valueOf(LocalDateTime.of(2025, 5, 13, 18, 11, 0)));
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during cart creation: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
        }
        return null;
    }

    public boolean addProductToCart(int cartId, int productId, int quantity) {
        if (isConnectionError) {
            System.err.println("Cannot add product to cart due to connection error");
            reconnectIfNeeded();
            return false;
        }

        String checkQuery = "SELECT quantity FROM cart_product WHERE cartId = ? AND productId = ?";
        try (PreparedStatement checkStmt = dbConn.prepareStatement(checkQuery)) {
            checkStmt.setInt(1, cartId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                int currentQuantity = rs.getInt("quantity");
                String updateQuery = "UPDATE cart_product SET quantity = ? WHERE cartId = ? AND productId = ?";
                try (PreparedStatement updateStmt = dbConn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, currentQuantity + quantity);
                    updateStmt.setInt(2, cartId);
                    updateStmt.setInt(3, productId);
                    return updateStmt.executeUpdate() > 0;
                }
            } else {
                String insertQuery = "INSERT INTO cart_product (cartId, productId, quantity) VALUES (?, ?, ?)";
                try (PreparedStatement insertStmt = dbConn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, cartId);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, quantity);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during add product to cart: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
            return false;
        }
    }

    public boolean updateCartProductQuantity(int cartId, int productId, int quantity) {
        if (isConnectionError) {
            System.err.println("Cannot update cart product quantity due to connection error");
            reconnectIfNeeded();
            return false;
        }

        String query = "UPDATE cart_product SET quantity = ? WHERE cartId = ? AND productId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            stmt.setInt(3, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error during update cart product quantity: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
            return false;
        }
    }

    public boolean removeProductFromCart(int cartId, int productId) {
        if (isConnectionError) {
            System.err.println("Cannot remove product from cart due to connection error");
            reconnectIfNeeded();
            return false;
        }

        String query = "DELETE FROM cart_product WHERE cartId = ? AND productId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error during remove product from cart: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
            return false;
        }
    }

    public boolean clearCart(int cartId) {
        if (isConnectionError) {
            System.err.println("Cannot clear cart due to connection error");
            reconnectIfNeeded();
            return false;
        }

        String query = "DELETE FROM cart_product WHERE cartId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            return stmt.executeUpdate() >= 0;
        } catch (SQLException e) {
            System.err.println("SQL Error during clear cart: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
            return false;
        }
    }

    public List<ProductModel> getCartProducts(int cartId) {
        if (isConnectionError) {
            System.err.println("Cannot fetch cart products due to connection error");
            reconnectIfNeeded();
            return new ArrayList<>();
        }

        String query = "SELECT cp.productId, cp.quantity, p.productName, p.productDescription, p.price, p.stock, " +
                      "p.brand, p.productImage, p.createdAt, p.updatedAt " +
                      "FROM cart_product cp JOIN products p ON cp.productId = p.productId WHERE cp.cartId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            List<ProductModel> products = new ArrayList<>();

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setProductId(rs.getInt("productId"));
                product.setProductName(rs.getString("productName"));
                product.setProductDescription(rs.getString("productDescription"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setQuantity(rs.getInt("quantity"));
                product.setBrand(rs.getString("brand"));
                product.setProductImage(rs.getString("productImage"));
                product.setCreatedAt(rs.getString("createdAt"));
                product.setUpdatedAt(rs.getString("updatedAt"));
                products.add(product);
            }
            return products;
        } catch (SQLException e) {
            System.err.println("SQL Error during cart products retrieval: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
            return new ArrayList<>();
        }
    }

    private void reconnectIfNeeded() {
        if (isConnectionError) {
            initializeConnection();
            if (dbConn != null) {
                isConnectionError = false;
                System.out.println("Reconnected to database successfully.");
            }
        }
    }
}