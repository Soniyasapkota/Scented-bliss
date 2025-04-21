<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History | Luxury Perfumes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/purchasehistory.css">
    <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>

	<jsp:include page="header.jsp"/>
	
	<div class="Order-history">

    <div class="container">
        <h1>Order History</h1>
        
        <div class="tabs">
            <a href="#" class="active">All Order</a>
            <a href="#">Summary</a>
            <a href="#">Completed</a>
            <a href="#">Cancelled</a>
        </div>
        
        <div class="date-filter">
            <input type="date" value="2023-11-01" class="date-input" /> To
            <input type="date" value="2023-11-01" class="date-input" />
        </div>
        
        <div class="order-card">
            <div class="order-header">
                <div class="order-info">
                    <div>Order : #10234987</div>
                    <div>Order Payment : 18th march 2021</div>
                </div>
                <div class="order-actions">
                    <button class="btn-invoice">Show Invoice</button>
                    <button class="btn-buy">Buy NOW</button>
                </div>
            </div>
            
            <div class="order-item">
                <div class="item-image">
                    <img src="${pageContext.request.contextPath}/resources/images/system/sauvage.jpg" alt="Gentleman's Essence">
                </div>
                <div class="item-details">
                    <h3>Gentleman's Essence</h3>
                    <p>By: Luxury Scents</p>
                    <div class="item-meta">
                        <span>Category: Male</span>
                        <span>Qty: 1</span>
                        <span>Price $110.00</span>
                    </div>
                </div>
                <div class="item-status">
                    <div class="status-label">Status</div>
                    <div class="status-value delivered">Delivered</div>
                </div>
                <div class="item-delivery">
                    <div class="delivery-label">Delivery Expected by</div>
                    <div class="delivery-date">23rd March 2021</div>
                </div>
            </div>
            
            <div class="order-item">
                <div class="item-image">
                    <img src="${pageContext.request.contextPath}/resources/images/system/ariana.jpg" alt="Floral Elegance">
                </div>
                <div class="item-details">
                    <h3>Floral Elegance</h3>
                    <p>By: Luxury Scents</p>
                    <div class="item-meta">
                        <span>Category: Female</span>
                        <span>Qty: 1</span>
                        <span>Price $90.00</span>
                    </div>
                </div>
                <div class="item-status">
                    <div class="status-label">Status</div>
                    <div class="status-value cancelled">Cancelled</div>
                </div>
                <div class="item-delivery">
                    <div class="delivery-label">Delivery Expected by</div>
                    <div class="delivery-date">23rd March 2021</div>
                </div>
            </div>
            
            <div class="order-footer">
                <button class="btn-cancel">
                    <span class="icon">×</span> cancel order
                </button>
                <div class="payment-status">Payment Is Successful</div>
                <div class="total-price">Total Price: $200.00</div>
            </div>
        </div>
    </div>
    </div>
    	<jsp:include page="footer.jsp"/>
    
</body>
</html>