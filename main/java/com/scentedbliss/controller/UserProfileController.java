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
import com.scentedbliss.util.ImageUtil;
import com.scentedbliss.util.CookieUtil;

import java.io.IOException;

/**
 * @author 23050320 Soniya Sapkota 
 */

@WebServlet(asyncSupported = true, urlPatterns = { "/userProfile" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UserProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;
    private ImageUtil imageUtil;

    public UserProfileController() {
        super();
        this.userService = new UserService();
        this.imageUtil = new ImageUtil();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = CookieUtil.getCookieValue(request, "username");

        if (session == null || username == null) {
            System.out.println("UserProfileController: No username in cookie or session, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserModel user = userService.getUserByUsername(username);
        if (user != null) {
            request.setAttribute("user", user);
        } else {
            request.setAttribute("error", "Unable to load user profile.");
        }

        System.out.println("UserProfileController: Forwarding to userProfile.jsp for username=" + username);
        request.getRequestDispatcher("/WEB-INF/pages/userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String username = CookieUtil.getCookieValue(request, "username");

        if (session == null || username == null) {
            System.out.println("UserProfileController: No username in cookie or session, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("UserProfileController: Processing profile update for username=" + username);

        UserModel user = new UserModel();
        user.setUsername(username);
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setAddress(request.getParameter("address"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phone"));

        String profilePicturePath = null;
        Part filePart = request.getPart("profilePicture");
        if (filePart != null && filePart.getSize() > 0) {
            String saveFolder = "/profiles";
            boolean isUploaded = imageUtil.uploadImage(filePart, request.getServletContext().getRealPath(""), saveFolder);
            if (isUploaded) {
                profilePicturePath = "/resources/images" + saveFolder + "/" + imageUtil.getImageNameFromPart(filePart);
            }
        }

        boolean isUpdated = userService.updateUserProfile(user, profilePicturePath);
        if (isUpdated) {
            // Refresh session attributes
            UserModel updatedUser = userService.getUserByUsername(username);
            session.setAttribute("role", updatedUser.getRole() != null ? updatedUser.getRole() : "Customer");
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        // Refresh user data
        user = userService.getUserByUsername(username);
        request.setAttribute("user", user);
        System.out.println("UserProfileController: Forwarding to userProfile.jsp after update");
        request.getRequestDispatcher("/WEB-INF/pages/userProfile.jsp").forward(request, response);
    }
}