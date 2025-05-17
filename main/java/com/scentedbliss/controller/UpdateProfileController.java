package com.scentedbliss.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import com.scentedbliss.model.UserModel;
import com.scentedbliss.service.UserService;
import com.scentedbliss.util.CookieUtil;
import com.scentedbliss.util.ImageUtil;

import java.io.IOException;

/**
 * @author 23050320 Soniya Sapkota 
 */

@WebServlet(asyncSupported = true, urlPatterns = { "/updateProfile" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private ImageUtil imageUtil;

    public UpdateProfileController() {
        super();
        this.userService = new UserService();
        this.imageUtil = new ImageUtil();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = CookieUtil.getCookieValue(request, "username");

        if (session == null || username == null) {
            System.out.println("UpdateProfileController: No username in cookie or session, redirecting to login");
            request.setAttribute("error", "Session expired. Please log in again.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("UpdateProfileController: Processing profile update for username=" + username);

        UserModel user = new UserModel();
        user.setUsername(username);
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setAddress(request.getParameter("address"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phone"));


        String profilePicturePath = null;
        try {
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                String saveFolder = "/profiles";
                String rootPath = request.getServletContext().getRealPath("");
                System.out.println("UpdateProfileController: Root path: " + rootPath);
                boolean isUploaded = imageUtil.uploadImage(filePart, rootPath, saveFolder);
                if (isUploaded) {
                    profilePicturePath = "/resources/images" + saveFolder + "/" + imageUtil.getImageNameFromPart(filePart);
                    System.out.println("UpdateProfileController: Profile picture uploaded, stored path: " + profilePicturePath);
                } else {
                    System.out.println("UpdateProfileController: Profile picture upload failed for username=" + username + ", file: " + imageUtil.getImageNameFromPart(filePart));
                }
            } else {
                System.out.println("UpdateProfileController: No profile picture provided or size is 0 for username=" + username);
                // Retrieve existing imageUrl to prevent setting to null
                UserModel existingUser = userService.getUserByUsername(username);
                if (existingUser != null && existingUser.getImageUrl() != null) {
                    profilePicturePath = existingUser.getImageUrl();
                } else {
                    profilePicturePath = "/resources/images/system/Photo1.png"; // Default image
                }
            }
        } catch (Exception e) {
            System.out.println("UpdateProfileController: Exception during profile picture upload for username=" + username + ": " + e.getMessage());
            e.printStackTrace();
            // Fallback to existing or default image
            UserModel existingUser = userService.getUserByUsername(username);
            if (existingUser != null && existingUser.getImageUrl() != null) {
                profilePicturePath = existingUser.getImageUrl();
            } else {
                profilePicturePath = "/resources/images/system/Photo1.png"; // Default image
            }
        }

        boolean isUpdated = userService.updateUserProfile(user, profilePicturePath);
        if (isUpdated) {
            // Refresh session attributes
            UserModel updatedUser = userService.getUserByUsername(username);
            if (updatedUser != null) {
                session.setAttribute("role", updatedUser.getRole() != null ? updatedUser.getRole() : "Customer");
                request.setAttribute("message", "Profile updated successfully!");
                System.out.println("UpdateProfileController: Profile updated successfully for username=" + username);
            } else {
                request.setAttribute("error", "Profile updated, but failed to refresh user data.");
                System.out.println("UpdateProfileController: Failed to refresh user data for username=" + username);
            }
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            System.out.println("UpdateProfileController: Profile update failed for username=" + username);
        }

        // Refresh user data
        user = userService.getUserByUsername(username);
        request.setAttribute("user", user);
        System.out.println("UpdateProfileController: Forwarding to userProfile.jsp");
        request.getRequestDispatcher("/WEB-INF/pages/userProfile.jsp").forward(request, response);
    }
}