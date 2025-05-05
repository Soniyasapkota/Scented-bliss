package com.scentedbliss.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.scentedbliss.config.DbConfig;
import com.scentedbliss.model.ProductModel;

public class ProductService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public ProductService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            isConnectionError = true;
        }
    }

    public Boolean addProduct(ProductModel product) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String insertQuery = "INSERT INTO products (productName, productDescription, price, stock, createdAt, updatedAt, quantity, productImage, brand) " +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(insertQuery)) {
            System.out.println("Adding product with values:");
            System.out.println("Product Name: " + product.getProductName());
            System.out.println("Description: " + product.getProductDescription());
            System.out.println("Price: " + product.getPrice());
            System.out.println("Stock: " + product.getStock());
            System.out.println("Created At: " + product.getCreatedAt());
            System.out.println("Updated At: " + product.getUpdatedAt());
            System.out.println("Quantity: " + product.getQuantity());
            System.out.println("Product Image: " + product.getProductImage());
            System.out.println("Brand: " + product.getBrand());
           
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getProductDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStock());
            stmt.setString(5, product.getCreatedAt());
            stmt.setString(6, product.getUpdatedAt());
            stmt.setInt(7, product.getQuantity());
            stmt.setString(8, product.getProductImage());
            stmt.setString(9, product.getBrand());
           
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product successfully added!");
                return true;
            } else {
                System.err.println("No rows affected — product addition failed.");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during product addition: " + e.getMessage());
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("Unexpected error during product addition: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public Boolean updateProduct(ProductModel product) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String updateQuery = "UPDATE products SET productName = ?, productDescription = ?, price = ?, stock = ?, " +
                            "updatedAt = ?, quantity = ?, productImage = ?, brand = ? WHERE productId = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(updateQuery)) {
            System.out.println("Updating product with values:");
            System.out.println("Product ID: " + product.getProductId());
            System.out.println("Product Name: " + product.getProductName());
            System.out.println("Description: " + product.getProductDescription());
            System.out.println("Price: " + product.getPrice());
            System.out.println("Stock: " + product.getStock());
            System.out.println("Updated At: " + product.getUpdatedAt());
            System.out.println("Quantity: " + product.getQuantity());
            System.out.println("Product Image: " + product.getProductImage());
            System.out.println("Brand: " + product.getBrand());

            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getProductDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getStock());
            stmt.setString(5, product.getUpdatedAt());
            stmt.setInt(6, product.getQuantity());
            stmt.setString(7, product.getProductImage());
            stmt.setString(8, product.getBrand());
            stmt.setInt(9, product.getProductId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product successfully updated!");
                return true;
            } else {
                System.err.println("No rows affected — product update failed.");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during product update: " + e.getMessage());
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("Unexpected error during product update: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public Boolean deleteProduct(int productId) {
        if (isConnectionError) {
            System.err.println("Database connection is not available.");
            return null;
        }

        String deleteQuery = "DELETE FROM products WHERE productId = ?";
        
        try (PreparedStatement stmt = dbConn.prepareStatement(deleteQuery)) {
            stmt.setInt(1, productId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Product successfully deleted!");
                return true;
            } else {
                System.err.println("No rows affected — product deletion failed.");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during product deletion: " + e.getMessage());
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("Unexpected error during product deletion: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public ProductModel getProductById(int productId) {
        if (isConnectionError) {
            System.err.println("Connection Error!");
            return null;
        }

        String query = "SELECT * FROM products WHERE productId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
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
                rs.close();
                return product;
            }
            rs.close();
            return null;
        } catch (SQLException e) {
            System.err.println("SQL Error during product retrieval: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<ProductModel> getAllProducts() {
        if (isConnectionError) {
            System.err.println("Connection Error!");
            return null;
        }

        String query = "SELECT * FROM products";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            List<ProductModel> productList = new ArrayList<>();

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
                productList.add(product);
            }
            rs.close();
            return productList;
        } catch (SQLException e) {
            System.err.println("SQL Error during product retrieval: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
   
}