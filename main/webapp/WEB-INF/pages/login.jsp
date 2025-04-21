<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />
</head>
<body>

<div class="container_img">
        <div class="image-section">
            <h1>Welcome to Scented Bliss</h1>
            <h3>Unlock a world of timeless elegance and refined fragrance.</h3>
            </div>
    <div class="login-box">
        <h2>Login To Your Account:</h2>
        
        <!-- Display error message if available -->
		<c:if test="${not empty error}">
			<p class="error-message">${error}</p>
		</c:if>

		<!-- Display success message if available -->
		<c:if test="${not empty success}">
			<p class="success-message">${success}</p>
		</c:if>
		
		
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="row">
                <div class="col">
                    <label for="username">Username:</label> 
                    <input type="text" id="username" name="username" value="${username}" required>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
            </div>
            <button type="submit" class="login-button">Login</button>
        </form>
        <a href="${pageContext.request.contextPath}/register" class="register-button">
			Don't Have An Account? Sign Up. </a>
    </div>
    </div>
</body>
</html>