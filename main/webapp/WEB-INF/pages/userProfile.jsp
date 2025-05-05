<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%
// Initialize necessary objects and variables
HttpSession userSession = request.getSession(false);
String currentUserRole = (String) (userSession != null ? userSession.getAttribute("role") : null);
pageContext.setAttribute("currentUserRole", currentUserRole);
%>

<!-- Set contextPath variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Profile - Scented Bliss</title>
    <c:choose>
        <c:when test="${currentUserRole == 'Admin'}">
            <link rel="stylesheet" type="text/css" href="${contextPath}/css/productlist.css" />
            <link rel="stylesheet" type="text/css" href="${contextPath}/css/header.css" />
        </c:when>
        <c:otherwise>
            <link rel="stylesheet" type="text/css" href="${contextPath}/css/header.css" />
            <link rel="stylesheet" type="text/css" href="${contextPath}/css/footer.css" />
        </c:otherwise>
    </c:choose>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/userProfile.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        <c:if test="${currentUserRole == 'Admin'}">
            html, body {
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
                min-height: 100vh;
            }
          
            .main-content {
                flex: 1;
                padding: 20px;
                box-sizing: border-box;
                overflow-y: auto; /* Enable scrolling */
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                align-items: flex-start; /* Align content to the top */
            }
            .User-profile {
                max-width: 800px;
                margin: 0 auto;
                width: 100%;
                padding: 20px 0;
            }
            .profile-container {
                margin: 0;
                padding: 0;
            }
        </c:if>
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${currentUserRole == 'Admin'}">
            <div class="container">
                <aside class="sidebar">
                    <h2>Admin</h2>
                    <ul>
                        <li><a href="${contextPath}/dashboard">Dashboard</a></li>
                        <li>Order List</li>
                        <li><a href="${contextPath}/productlist">Product List</a></li>
                        <li><a href="${contextPath}/customerlist">Customer List</a></li>
                        <li>Sales Reports</li>
                        <li><a href="${contextPath}/userProfile">Account</a></li>
                    </ul>
                </aside>
                <main class="main-content">
                    <header class="header">
                        <div class="logo">
                            <a href="${contextPath}" class="logo-text">Scented Bliss</a>
                        </div>
                        <ul class="main-nav right-nav">
                            <c:if test="${empty currentUserRole}">
                                <li><a href="${contextPath}/register">Register</a></li>
                            </c:if>
                            <li>
                                <c:choose>
                                    <c:when test="${not empty currentUserRole}">
                                        <form action="${contextPath}/logout" method="post">
                                            <input type="submit" class="nav-button" value="Logout" />
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${contextPath}/login">Login</a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>
                    </header>

                    <div class="User-profile">
                        <div class="profile-container">
                            <h1>My Profile</h1>
                            <c:if test="${not empty message}">
                                <p style="color: green;">${message}</p>
                            </c:if>
                            <c:if test="${not empty error}">
                                <p style="color: red;">${error}</p>
                            </c:if>
                            
                            <div class="profile-icon">
                                <c:choose>
                                    <c:when test="${not empty user.imageUrl}">
                                        <img src="${contextPath}${user.imageUrl}" style="width:100px; height:100px; border-radius:50%;" onerror="this.src='${contextPath}/resources/images/system/Photo1.png'" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${contextPath}/resources/images/system/Photo1.png" alt="Default Profile" style="width:100px; height:100px; border-radius:50%;" />
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <form class="profile-form" method="post" action="${contextPath}/updateProfile" enctype="multipart/form-data">
                                <label for="firstName">First Name</label>
                                <input type="text" id="firstName" name="firstName" value="${user.firstName != null ? user.firstName : ''}" required /><br />
                                
                                <label for="lastName">Last Name</label>
                                <input type="text" id="lastName" name="lastName" value="${user.lastName != null ? user.lastName : ''}" required /><br />
                                
                                <label for="address">Address</label>
                                <input type="text" id="address" name="address" value="${user.address != null ? user.address : ''}" /><br />
                                
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="${user.email != null ? user.email : ''}" required /><br />
                                
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phone" value="${user.phoneNumber != null ? user.phoneNumber : ''}" /><br />
                                
                                <label for="profilePicture">Profile Picture</label>
                                <input type="file" id="profilePicture" name="profilePicture" accept="image/*" /><br />
                                
                                <button type="submit" class="save-btn">Save Changes</button>
                            </form>

                            <div class="password-section">
                                <h2>Update Password</h2>
                                <form class="password-form" method="post" action="${contextPath}/updatePassword">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" id="currentPassword" name="currentPassword" placeholder="Current Password" required /><br />
                                    <label for="newPassword">New Password</label>
                                    <input type="password" id="newPassword" name="newPassword" placeholder="New Password" required /><br />
                                    <label for="confirmPassword">Confirm Password</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required /><br />
                                    <button type="submit" class="update-btn">Update</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </c:when>
        <c:otherwise>
            <jsp:include page="header.jsp" />
            <div class="User-profile">
                <div class="profile-container">
                    <h1>My Profile</h1>
                    <c:if test="${not empty message}">
                        <p style="color: green;">${message}</p>
                    </c:if>
                    <c:if test="${not empty error}">
                        <p style="color: red;">${error}</p>
                    </c:if>
                    
                    <div class="profile-icon">
                        <c:choose>
                            <c:when test="${not empty user.imageUrl}">
                                <img src="${contextPath}${user.imageUrl}" style="width:100px; height:100px; border-radius:50%;" onerror="this.src='${contextPath}/resources/images/system/Photo1.png'" />
                            </c:when>
                            <c:otherwise>
                                <img src="${contextPath}/resources/images/system/Photo1.png" alt="Default Profile" style="width:100px; height:100px; border-radius:50%;" />
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form class="profile-form" method="post" action="${contextPath}/updateProfile" enctype="multipart/form-data">
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName" value="${user.firstName != null ? user.firstName : ''}" required /><br />
                        
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName" value="${user.lastName != null ? user.lastName : ''}" required /><br />
                        
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" value="${user.address != null ? user.address : ''}" /><br />
                        
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${user.email != null ? user.email : ''}" required /><br />
                        
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" value="${user.phoneNumber != null ? user.phoneNumber : ''}" /><br />
                        
                        <label for="profilePicture">Profile Picture</label>
                        <input type="file" id="profilePicture" name="profilePicture" accept="image/*" /><br />
                        
                        <button type="submit" class="save-btn">Save Changes</button>
                    </form>

                    <div class="password-section">
                        <h2>Update Password</h2>
                        <form class="password-form" method="post" action="${contextPath}/updatePassword">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" placeholder="Current Password" required /><br />
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="New Password" required /><br />
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required /><br />
                            <button type="submit" class="update-btn">Update</button>
                        </form>
                    </div>
                </div>
            </div>
            <jsp:include page="footer.jsp" />
        </c:otherwise>
    </c:choose>
</body>
</html>