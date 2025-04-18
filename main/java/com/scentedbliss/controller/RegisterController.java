package com.scentedbliss.controller;

import java.io.IOException;



import java.time.LocalDate;

import com.scentedbliss.model.UserModel;
import com.scentedbliss.service.RegisterService;
import com.scentedbliss.util.ValidationUtil;
import com.scentedbliss.util.ImageUtil;
import com.scentedbliss.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;


/**
 * RegisterController handles user registration requests and processes form
 * submissions. It also manages file uploads and account creation.
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final ImageUtil ImageUtil = new ImageUtil();
	private final RegisterService RegisterService = new RegisterService();



	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        // Validate and extract user model
	        String validationMessage = validateRegistrationForm(req);
	        if (validationMessage != null) {
	            handleError(req, resp, validationMessage);
	            return;
	        }

	        UserModel userModel = extractUserModel(req);
	        Boolean isAdded = RegisterService.addUser(userModel);

	        if (isAdded == null) {
	            handleError(req, resp, "Our server is under maintenance. Please try again later!");
	        } else if (isAdded) {
	            try {
	                if (uploadImage(req)) {
	                    handleSuccess(req, resp, "Your account is successfully created!", "/WEB-INF/pages/login.jsp");
	                } else {
	                    handleError(req, resp, "Could not upload the image. Please try again later!");
	                }
	            } catch (IOException | ServletException e) {
	                handleError(req, resp, "An error occurred while uploading the image. Please try again later!");
	                e.printStackTrace(); // Log the exception
	            }
	        } else {
	            handleError(req, resp, "Could not register your account. Please try again later!");
	        }
	    } catch (Exception e) {
	        handleError(req, resp, "An unexpected error occurred. Please try again later!");
	        e.printStackTrace(); // Log the exception
	    }
	}

	private String validateRegistrationForm(HttpServletRequest req) {
	    String firstName = req.getParameter("firstName");
	    String lastName = req.getParameter("lastName");
	    String username = req.getParameter("username");
	    String dobStr = req.getParameter("dob");
	    String gender = req.getParameter("gender");
	    String email = req.getParameter("email");
	    String phoneNumber = req.getParameter("phoneNumber");
	    String address = req.getParameter("address");
	    String role = req.getParameter("role");
	    String password = req.getParameter("password");
	    String retypePassword = req.getParameter("retypePassword");

	    // Check for null or empty fields first
	    if (ValidationUtil.isNullOrEmpty(firstName))
	        return "First name is required.";
	    if (ValidationUtil.isNullOrEmpty(lastName))
	        return "Last name is required.";
	    if (ValidationUtil.isNullOrEmpty(username))
	        return "Username is required.";
	    if (ValidationUtil.isNullOrEmpty(dobStr))
	        return "Date of birth is required.";
	    if (ValidationUtil.isNullOrEmpty(gender))
	        return "Gender is required.";
	    if (ValidationUtil.isNullOrEmpty(email))
	        return "Email is required.";
	    if (ValidationUtil.isNullOrEmpty(phoneNumber))
	        return "Phone number is required.";
	    if (ValidationUtil.isNullOrEmpty(address))
	        return "Address is required.";
	    if (ValidationUtil.isNullOrEmpty(role))
	        return "Role is required.";
	    if (ValidationUtil.isNullOrEmpty(password))
	        return "Password is required.";
	    if (ValidationUtil.isNullOrEmpty(retypePassword))
	        return "Please retype the password.";

	    // Convert date of birth
	    LocalDate dob;
	    try {
	        dob = LocalDate.parse(dobStr);
	    } catch (Exception e) {
	        return "Invalid date format. Please use YYYY-MM-DD.";
	    }

	    // Validate fields
	    if (!ValidationUtil.isAlphabetic(firstName))
	        return "First name must contain only letters.";
	    if (!ValidationUtil.isAlphabeticOnly(lastName))
	        return "Last name must contain only letters.";

	    if (!ValidationUtil.isAlphanumericStartingWithLetter(username))
	        return "Username must start with a letter and contain only letters and numbers.";
	    if (!ValidationUtil.isValidGender(gender))
	        return "Gender must be 'male' or 'female'.";
	    if (!ValidationUtil.isValidEmail(email))
	        return "Invalid email format.";
	    if (!ValidationUtil.isValidPhoneNumber(phoneNumber))
	        return "Phone number must be 10 digits and start with 98.";
	    if (!ValidationUtil.isValidPassword(password))
	        return "Password must be at least 8 characters long, with 1 uppercase letter, 1 number, and 1 symbol.";
	    if (!ValidationUtil.doPasswordsMatch(password, retypePassword))
	        return "Passwords do not match.";

	    // Check if the date of birth is at least 16 years before today
	    if (!ValidationUtil.isAgeAtLeast16(dob))
	        return "You must be at least 16 years old to register.";

	    try {
	        Part image = req.getPart("image");
	        if (!ValidationUtil.isValidImageExtension(image))
	            return "Invalid image format. Only jpg, jpeg, png, and gif are allowed.";
	    } catch (IOException | ServletException e) {
	        return "Error handling image file. Please ensure the file is valid.";
	    }

	    return null; // All validations passed
	}

	private UserModel extractUserModel(HttpServletRequest req) throws Exception {
	    String firstName = req.getParameter("firstName");
	    String lastName = req.getParameter("lastName");
	    String address = req.getParameter("address");
	    String email = req.getParameter("email");
	    String phoneNumber = req.getParameter("phoneNumber");
	    String gender = req.getParameter("gender");
	    String username = req.getParameter("username");
	    String password = req.getParameter("password");
	    LocalDate dob = LocalDate.parse(req.getParameter("dob"));
	    String role = req.getParameter("role");
	   
	   
	    password = PasswordUtil.encrypt(username, password);

	    // Assuming password validation is already done in validateRegistrationForm
	   // password = PasswordUtil.encrypt(username, password);

	    Part image = req.getPart("image");
	    String imageUrl = ImageUtil.getImageNameFromPart(image);

	    return new UserModel(firstName,  lastName,  address,  email, phoneNumber, gender,
				 username, password, dob, role, imageUrl);
	}

	private boolean uploadImage(HttpServletRequest req) throws IOException, ServletException {
	    Part image = req.getPart("image");
	    return ImageUtil.uploadImage(image, req.getServletContext().getRealPath("/"), "user");
	}

	private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, String message, String redirectPage)
	        throws ServletException, IOException {
	    req.setAttribute("success", message);
	    req.getRequestDispatcher(redirectPage).forward(req, resp);
	}

	private void handleError(HttpServletRequest req, HttpServletResponse resp, String message)
	        throws ServletException, IOException {
	    req.setAttribute("error", message);
	    req.setAttribute("firstName", req.getParameter("firstName"));
	    req.setAttribute("lastName", req.getParameter("lastName"));
	    req.setAttribute("username", req.getParameter("username"));
	    req.setAttribute("dob", req.getParameter("dob"));
	    req.setAttribute("gender", req.getParameter("gender"));
	    req.setAttribute("email", req.getParameter("email"));
	    req.setAttribute("phoneNumber", req.getParameter("phoneNumber"));
	    req.setAttribute("Address", req.getParameter("address"));
	    req.setAttribute("role", req.getParameter("role"));
	    req.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(req, resp);
	}

}


	