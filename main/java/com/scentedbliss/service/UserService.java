package com.scentedbliss.service;

import com.scentedbliss.config.DbConfig;

import com.scentedbliss.model.UserModel;
import com.scentedbliss.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


/**
 * @author 23050320 Soniya Sapkota 
 */

public class UserService {
    private Connection dbConn;
    private boolean isConnectionError = false;

    public UserService() {
        try {
            dbConn = DbConfig.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            isConnectionError = true;
        }
    }
    
    

    public UserModel getUserByUsername(String username) {
        if (isConnectionError) {
            return null;
        }
        
        

        String query = "SELECT firstName, lastName, address, email, phoneNumber, gender, username, dob, role, imageUrl FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                UserModel user = new UserModel();
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setGender(rs.getString("gender"));
                user.setUsername(rs.getString("username"));
                user.setDob(rs.getString("dob") != null ? LocalDate.parse(rs.getString("dob")) : null);
                user.setRole(rs.getString("role"));
                user.setImageUrl(rs.getString("imageUrl"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUserProfile(UserModel user, String profilePicturePath) {
        if (isConnectionError) {
            System.out.println("UserService: Cannot update profile due to connection error");
            return false;
        }

        if (user == null || user.getUsername() == null) {
            System.out.println("UserService: Invalid user or username is null");
            return false;
        }

        // Validate required fields
        if (user.getFirstName() == null || user.getLastName() == null || user.getEmail() == null) {
            System.out.println("UserService: Required fields (firstName, lastName, email) are missing for username=" + user.getUsername());
            return false;
        }

        String query = "UPDATE users SET firstName = ?, lastName = ?, address = ?, email = ?, phoneNumber = ?, imageUrl = ? WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getAddress());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setString(6, profilePicturePath != null ? profilePicturePath : "/resources/images/system/Photo1.png");
            stmt.setString(7, user.getUsername());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("UserService: Profile updated successfully for username=" + user.getUsername());
                return true;
            } else {
                System.out.println("UserService: No rows affected during profile update for username=" + user.getUsername());
                return false;
            }
        } catch (SQLException e) {
            System.out.println("UserService: SQLException in updateUserProfile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(String username, String currentPassword, String newPassword) {
        if (isConnectionError) {
            System.out.println("UserService: Cannot update password due to connection error");
            return false;
        }

        String selectQuery = "SELECT password FROM users WHERE username = ?";
        try (PreparedStatement stmt = dbConn.prepareStatement(selectQuery)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                System.out.println("UserService: Retrieved encrypted password for username=" + username);
                String decryptedPassword = PasswordUtil.decrypt(dbPassword, username);
                if (decryptedPassword == null) {
                    System.out.println("UserService: Password decryption failed for username=" + username);
                    return false;
                }
                if (!decryptedPassword.equals(currentPassword)) {
                    System.out.println("UserService: Current password does not match for username=" + username);
                    return false;
                }

                String encryptedNewPassword = PasswordUtil.encrypt(username, newPassword);
                if (encryptedNewPassword == null) {
                    System.out.println("UserService: Password encryption failed for new password");
                    return false;
                }

                String updateQuery = "UPDATE users SET password = ? WHERE username = ?";
                try (PreparedStatement updateStmt = dbConn.prepareStatement(updateQuery)) {
                    updateStmt.setString(1, encryptedNewPassword);
                    updateStmt.setString(2, username);
                    int rowsAffected = updateStmt.executeUpdate();
                    if (rowsAffected > 0) {
                        System.out.println("UserService: Password updated successfully for username=" + username);
                        return true;
                    } else {
                        System.out.println("UserService: No rows affected during password update for username=" + username);
                        return false;
                    }
                }
            } else {
                System.out.println("UserService: Username not found: " + username);
                return false;
            }
        } catch (SQLException e) {
            System.out.println("UserService: SQLException during password update: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public List<UserModel> getAllCustomers() {
        if (isConnectionError) {
            System.out.println("UserService: Cannot fetch customers due to connection error");
            return new ArrayList<>();
        }

        List<UserModel> customers = new ArrayList<>();
        String query = "SELECT firstName, lastName, address, email, phoneNumber, gender, username, dob, role, imageUrl FROM users WHERE role = 'customer'";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                UserModel user = new UserModel();
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setAddress(rs.getString("address"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNumber(rs.getString("phoneNumber"));
                user.setGender(rs.getString("gender"));
                user.setUsername(rs.getString("username"));
                user.setDob(rs.getString("dob") != null ? LocalDate.parse(rs.getString("dob")) : null);
                user.setRole(rs.getString("role"));
                user.setImageUrl(rs.getString("imageUrl"));
                customers.add(user);
            }
        } catch (SQLException e) {
            System.out.println("UserService: SQLException in getAllCustomers: " + e.getMessage());
            e.printStackTrace();
        }
        return customers;
    }

    public boolean removeCustomer(String username) {
        if (isConnectionError) {
            System.out.println("UserService: Cannot remove customer due to connection error");
            return false;
        }

        String query = "DELETE FROM users WHERE username = ? AND role = 'customer'";
        try (PreparedStatement stmt = dbConn.prepareStatement(query)) {
            stmt.setString(1, username);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("UserService: Customer removed successfully for username=" + username);
                return true;
            } else {
                System.out.println("UserService: No customer found for username=" + username);
                return false;
            }
        } catch (SQLException e) {
            System.out.println("UserService: SQLException in removeCustomer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    
    

}