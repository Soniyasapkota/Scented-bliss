<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%
// Initialize necessary objects and variables
HttpSession userSession = request.getSession(false);
String currentUser = (String) (userSession != null ? userSession.getAttribute("role") : null);
pageContext.setAttribute("currentUser", currentUser);

// Get username from cookie
String username = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("username".equals(cookie.getName())) {
            username = cookie.getValue();
            break;
        }
    }
}
pageContext.setAttribute("username", username);

// Debug logging
System.out.println("customerlist.jsp - Session: " + (userSession != null ? "exists" : "null"));
System.out.println("customerlist.jsp - Role: " + currentUser);
System.out.println("customerlist.jsp - Username from cookie: " + username);
%>

<!-- Set contextPath variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Perfume Shop - Customer List</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/dashboard.css" />
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/header.css" />
    
   <link rel="stylesheet" type="text/css" href="${contextPath}/css/customerlist.css" />
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
   
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <h2>Admin</h2>
            <ul>
                <li><a href="${contextPath}/dashboard">Dashboard</a></li>
                <li><a href="#">Order List</a></li>
                <li><a href="${contextPath}/productlist">Product List</a></li>
                <li><a href="${contextPath}/customerlist">Customer List</a></li>
                <li><a href="#">Sales Reports</a></li>
       <li><a href="${contextPath}/userProfile"></a>Account</li>
            </ul>
        </aside>

        <main class="main-content">
            <div id="header">
                <header class="header">
                    <div class="logo">
                        <a href="${contextPath}" class="logo-text">Scented Bliss</a>
                    </div>
                    <ul class="main-nav right-nav">
                        <c:if test="${empty currentUser}">
                            <li><a href="${contextPath}/register">Register</a></li>
                        </c:if>
                        <li>
                            <c:choose>
                                <c:when test="${not empty currentUser}">
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
            </div>

            <div class="content-body">
                <c:if test="${not empty currentUser and currentUser.equalsIgnoreCase('Admin')}">
                    <div class="table-container">
                        <h3>Customer Information</h3>
                        <c:if test="${not empty error}">
                            <p class="error-message"><c:out value="${error}" /></p>
                        </c:if>
                        <table>
                            <thead>
                                <tr>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Address</th>
                                    <th>Gender</th>
                                    <th>Username</th>
                                    <th>Date of Birth</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="customer" items="${customers}">
                                    <tr>
                                        <td><c:out value="${customer.firstName}" /></td>
                                        <td><c:out value="${customer.lastName}" /></td>
                                        <td><c:out value="${customer.email}" /></td>
                                        <td><c:out value="${customer.phoneNumber}" /></td>
                                        <td><c:out value="${customer.address}" /></td>
                                        <td><c:out value="${customer.gender}" /></td>
                                        <td><c:out value="${customer.username}" /></td>
                                        <td><c:out value="${customer.dob}" /></td>
                                        <td><c:out value="${customer.role}" /></td>
                                        <td>
                                            <form action="${contextPath}/removeCustomer" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                                                <input type="hidden" name="username" value="${customer.username}">
                                                <input type="hidden" name="action" value="delete">
                                                <button class="action-btn" type="submit">
                                                    <img src="${contextPath}/resources/images/system/delete.avif" alt="Delete" title="Delete" />
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <c:if test="${empty currentUser or not currentUser.equalsIgnoreCase('Admin')}">
                    <p>You do not have permission to view this page.</p>
                    <p>Current Role: <c:out value="${currentUser}" default="None" /></p>
                    <p>Username from Cookie: <c:out value="${username}" default="None" /></p>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>