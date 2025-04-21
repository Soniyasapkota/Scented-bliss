<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Wishlist</title>
     <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wishlist.css">
</head>
<body>
	<jsp:include page="header.jsp"/>
	
<div class = "Wish-list">

<div class="wishlist-container">
    <h2>Wishlist</h2>
    <p class="breadcrumb">Home / Wishlist</p>

    <table class="wishlist-table">
        <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Date Added</th>
            <th>Stock Status</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <div class="product-info">
                    <img src="${pageContext.request.contextPath}/resources/images/system/sauvage.jpg" alt="Dior Sauvage">
                    <div>
                        <p class="product-name">Dior Sauvage</p>
                        <p class="product-category">Category: Men</p>
                    </div>
                </div>
            </td>
            <td>$160.00</td>
            <td>18 April 2024</td>
            <td class="instock">In stock</td>
            <td><button class="add-btn">Add to Cart</button></td>
        </tr>
        <!-- Repeat for other products -->
        </tbody>
    </table>

    <div class="wishlist-footer">
        <input type="text" readonly value="https://www.example.com">
        <button class="copy-btn">Copy Link</button>
        <a href="#" class="clear-link">Clear Wishlist</a>
        <button class="add-all-btn">Add All to Cart</button>
    </div>

    <div class="features">
        <div class="feature-item">
            <img src="${pageContext.request.contextPath}/resources/images/system/victoria.jpg" alt="Free Shipping">
            <p><strong>Free Shipping</strong><br>Free shipping for orders above $180</p>
        </div>
        <div class="feature-item">
            <img src="${pageContext.request.contextPath}/resources/images/system/miss_dior.jpg" alt="Flexible Payment">
            <p><strong>Flexible Payment</strong><br>Multiple secure payment options</p>
        </div>
        <div class="feature-item">
            <img src="${pageContext.request.contextPath}/resources/images/system/blue_channel.jpg" alt="24x7 Support">
            <p><strong>24x7 Support</strong><br>We support online all days.</p>
        </div>
    </div>
</div>
</div>
	<jsp:include page="footer.jsp"/>

</body>
</html>
