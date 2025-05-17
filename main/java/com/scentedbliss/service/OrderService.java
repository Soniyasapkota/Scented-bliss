package com.scentedbliss.service;

import com.scentedbliss.config.DbConfig;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.scentedbliss.model.OrderItemModel;
import com.scentedbliss.model.OrderModel;

public class OrderService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public OrderService() {
        try {
            this.dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            System.err.println("Database connection error: " + ex.getMessage());
            ex.printStackTrace();
            isConnectionError = true;
        }
    }
    
    public List<OrderModel> getAllOrders() {
        if (isConnectionError) {
            System.err.println("Cannot fetch orders due to connection error");
            return new ArrayList<>();
        }

        List<OrderModel> orders = new ArrayList<>();
        String query = "SELECT orderId, orderDate, userId, shippingAddress, totalAmount FROM orders";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderModel order = new OrderModel(
                    rs.getInt("orderId"),
                    rs.getString("orderDate"),
                    rs.getInt("userId"),
                    rs.getString("shippingAddress"),
                    rs.getDouble("totalAmount")
                );
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during order retrieval: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
        }
        return orders;
    }
    
    public List<OrderItemModel> getOrderItems(int orderId) {
        if (isConnectionError) {
            System.err.println("Cannot fetch order items due to connection error");
            return new ArrayList<>();
        }

        List<OrderItemModel> orderItems = new ArrayList<>();
        String query = "SELECT orderItemId, orderId, productId, quantity, unitPrice, subTotal FROM orderItems WHERE orderId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OrderItemModel item = new OrderItemModel(
                    rs.getInt("orderItemId"),
                    rs.getInt("orderId"),
                    rs.getInt("productId"),
                    rs.getInt("quantity"),
                    rs.getDouble("unitPrice"),
                    rs.getDouble("subTotal")
                );
                orderItems.add(item);
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during order items retrieval: " + e.getMessage());
            e.printStackTrace();
            isConnectionError = true;
        }
        return orderItems;
    }

    public int getUserIdByUsername(String username) {
        if (isConnectionError) {
            System.err.println("Cannot fetch user ID due to connection error");
            return -1;
        }

        String query = "SELECT userId FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("userId");
                System.out.println("getUserIdByUsername: Found userId = " + userId + " for username = " + username);
                return userId;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during user ID retrieval: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("getUserIdByUsername: No userId found for username = " + username);
        return -1;
    }

    public String getUserAddress(int userId) {
        if (isConnectionError) {
            System.err.println("Cannot fetch user address due to connection error");
            return null;
        }

        String query = "SELECT address FROM users WHERE userId = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String address = rs.getString("address");
                System.out.println("getUserAddress: Found address = " + address + " for userId = " + userId);
                return address;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error during address retrieval: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("getUserAddress: No address found for userId = " + userId);
        return null;
    }
    
    

    

    
    
}