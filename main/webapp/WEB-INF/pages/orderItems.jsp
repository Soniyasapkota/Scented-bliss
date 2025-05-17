<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Perfume Shop - Order Items</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/orderItems.css"/>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/productlist.css" />
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/header.css" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
                <h2>Order Items for Order ID: <c:out value="${orderId}" /></h2>
                <a href="${contextPath}/orders"><button class="back-btn">Back to Orders</button></a>
                <c:if test="${not empty orderItems}">
                    <table>
                        <thead>
                            <tr>
                                <th>Order Item ID</th>
                                <th>Order ID</th>
                                <th>Product ID</th>
                                <th>Quantity</th>
                                <th>Unit Price</th>
                                <th>Sub Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${orderItems}">
                                <tr>
                                    <td><c:out value="${item.orderItemId}" /></td>
                                    <td><c:out value="${item.orderId}" /></td>
                                    <td><c:out value="${item.productId}" /></td>
                                    <td><c:out value="${item.quantity}" /></td>
                                    <td>$<c:out value="${item.unitPrice}" /></td>
                                    <td>$<c:out value="${item.subTotal}" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty orderItems}">
                    <p>No order items found for Order ID: <c:out value="${orderId}" />.</p>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>