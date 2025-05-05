package com.scentedbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.scentedbliss.model.UserModel;
import com.scentedbliss.service.UserService;
import com.scentedbliss.util.CookieUtil;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = { "/updatePassword" })
public class UpdatePasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    public UpdatePasswordController() {
        super();
        this.userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = CookieUtil.getCookieValue(request, "username");

        if (session == null || username == null) {
            System.out.println("UpdatePasswordController: No username in cookie or session, redirecting to login");
            request.setAttribute("error", "Session expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("UpdatePasswordController: Processing password update for username=" + username);

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null ||
            currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "All password fields are required.");
            System.out.println("UpdatePasswordController: Missing password fields for username=" + username);
        } else if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirm password do not match.");
            System.out.println("UpdatePasswordController: Passwords do not match for username=" + username);
        } else {
            try {
                boolean isUpdated = userService.updatePassword(username, currentPassword, newPassword);
                if (isUpdated) {
                    request.setAttribute("message", "Password updated successfully!");
                    System.out.println("UpdatePasswordController: Password updated successfully for username=" + username);
                } else {
                    request.setAttribute("error", "Failed to update password. Please check your current password.");
                    System.out.println("UpdatePasswordController: Password update failed for username=" + username);
                }
            } catch (Exception e) {
                request.setAttribute("error", "An error occurred while updating the password.");
                System.out.println("UpdatePasswordController: Exception during password update for username=" + username + ": " + e.getMessage());
                e.printStackTrace();
            }
        }

        // Refresh user data
        UserModel user = userService.getUserByUsername(username);
        if (user != null) {
            request.setAttribute("user", user);
            session.setAttribute("role", user.getRole() != null ? user.getRole() : "Customer");
        } else {
            request.setAttribute("error", "Unable to load user profile.");
            System.out.println("UpdatePasswordController: Failed to load user profile for username=" + username);
        }

        System.out.println("UpdatePasswordController: Forwarding to userProfile.jsp");
        request.getRequestDispatcher("/WEB-INF/pages/userProfile.jsp").forward(request, response);
    }
}