<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Form</title>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- Set contextPath variable for reuse -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/register.css" />
</head>
<body>
<div class="container_img">
        <div class="image-section">
            <h1>Create your Account</h1>
            <h3>Discover scents that tell your story!</h3>
            </div>
        
	<div class="container">
		<h2>Registration Form</h2>
		
		
		<!-- Display error message if available -->
		<c:if test="${not empty error}">
			<p class="error-message">${error}</p>
		</c:if>

		<!-- Display success message if available -->
		<c:if test="${not empty success}">
			<p class="success-message">${success}</p>
		</c:if>
	

		<form action="${pageContext.request.contextPath}/register" method="post"
			enctype="multipart/form-data">
			<div class="row">
				<div class="col">
					<label for="firstName">First Name:</label> <input type="text"
						id="firstName" name="firstName" value="${firstName}" required>
				</div>
				<div class="col">
					<label for="lastName">Last Name:</label> <input type="text"
						id="lastName" name="lastName" value="${lastName}" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" value="${username}" required>
				</div>
				<div class="col">
					<label for="birthday">Date of Birth:</label> <input type="date"
						id="birthday" name="dob" value="${dob}" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="gender">Gender:</label> <select id="gender"
						name="gender" required>
						<option value="male" ${gender == 'male' ? 'selected' : ''}>Male</option>
						<option value="female" ${gender == 'female' ? 'selected' : ''}>Female</option>
					</select>
				</div>
				<div class="col">
					<label for="email">Email:</label> <input type="email" id="email"
						name="email" value="${email}" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="phoneNumber">Phone Number:</label> <input type="tel"
						id="phoneNumber" name="phoneNumber" value="${phoneNumber}"
						required>
				</div>
				<div class="col">
					<label for="Address">Address:</label> <input type="text"
						id="Address" name="address" value="${address}" required>
				</div>
				
				<div class="col">
					<label for="UserRole">Role:</label> <select id="role"
						name="role" required>
						<option value="admin" ${role == 'admin' ? 'selected' : ''}>Admin</option>
						<option value="customer" ${role == 'customer' ? 'selected' : ''}>Customer</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="password">Password:</label> <input type="password"
						id="password" name="password" required>
				</div>
				<div class="col">
					<label for="retypePassword">Retype Password:</label> <input
						type="password" id="retypePassword" name="retypePassword" required>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<label for="image">Profile Picture:</label> <input type="file"
						id="image" name="image">
				</div>
			</div>
			<button type="submit">Register A New Account</button>
		</form>
		<a href="${pageContext.request.contextPath}/login" class="login-button">Login If You
			Already Have An Account </a>
	</div>
		</div>
	
</body>
</html>
