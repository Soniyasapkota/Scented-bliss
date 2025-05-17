<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="com.scentedbliss.service.OrderService" %>
<%@ page import="com.scentedbliss.model.OrderModel" %>
<%@ page import="java.util.List" %>
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
    System.out.println("orders.jsp - Session: " + (userSession != null ? "exists" : "null"));
    System.out.println("orders.jsp - Role: " + currentUser);
    System.out.println("orders.jsp - Username from cookie: " + username);

    // Fetch orders
    OrderService orderService = new OrderService();
    List<OrderModel> orders = orderService.getAllOrders();
    pageContext.setAttribute("orders", orders);
%>

<!-- Set contextPath variable -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Perfume Shop - Orders</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/productlist.css" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/css/orders.css" />
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/header.css" />
    
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
   <script>
    function showOrderItems(orderId) {
        window.location.href = "${contextPath}/orderItems?orderId=" + orderId;
    }
</script>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <h2>Admin</h2>
            <ul>
                <li><a href="${contextPath}/dashboard">Dashboard</a></li>
                <li><a href="${contextPath}/orders">Order List</a></li>
                <li><a href="${contextPath}/product">Product List</a></li>
                <li><a href="${contextPath}/customerlist">Customer List</a></li>
                <li><a href="${contextPath}/userProfile">Account</a></li>
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
                        <h2>Orders</h2>
                        <c:if test="${not empty success}">
                            <p class="success-message"><c:out value="${success}" /></p>
                        </c:if>
                        <c:if test="${not empty error}">
                            <p class="error-message"><c:out value="${error}" /></p>
                        </c:if>
                        <table id="ordersTable">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Order Date</th>
                                    <th>User ID</th>
                                    <th>Shipping Address</th>
                                    <th>Total Amount</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="ordersBody">
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td><c:out value="${order.orderId}" /></td>
                                        <td><c:out value="${order.orderDate}" /></td>
                                        <td><c:out value="${order.userId}" /></td>
                                        <td><c:out value="${order.shippingAddress}" /></td>
                                        <td>$ <c:out value="${order.totalAmount}" /></td>
                                        <td>
                                            <button class="order-items-btn" onclick="showOrderItems('<c:out value="${order.orderId}" />')">Order Items</button>
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