<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productDetail.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <title>${product.productName} - Scented Bliss</title>
</head>
<body>
  <jsp:include page="header.jsp"/>

  <div class="Shop-product">
    <main class="container main">
      <c:choose>
        <c:when test="${not empty product}">
          <div class="product-detail">
            <div class="product-detail-image">
              <img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}" class="product-image"/>
            </div>
            <div class="product-detail-info">
              <h2>${product.productName}</h2>
              <p class="product-type">${product.brand}</p>
              <p class="price">$${product.price}</p>
              <div class="cart-controls">
                <label for="quantity">Qty:</label>
                <input type="number" id="quantity" class="quantity-input" min="1" value="1" data-product-id="${product.productId}" style="width: 60px; margin-right: 10px;" />
                <button class="add-to-bag" onclick="addToCart(${product.productId}, '${product.productName}', ${product.price}, '${product.brand}', '${product.productImage}', this.previousElementSibling.value)">ADD TO CART</button>
              </div>
              <button class="wishlist-button"><i class="far fa-heart"></i> Add to Wishlist</button>
              <h4>Description</h4>
              <p class="description">${product.productDescription}</p>
              <p class="made-in">Made in France</p>
            </div>
          </div>
        </c:when>
        <c:otherwise>
          <p class="not-found">Product not found.</p>
        </c:otherwise>
      </c:choose>
    </main>
  </div>

  <script>
    function addToCart(productId, productName, price, brand, productImage, quantity) {
      // Check if user is logged in by looking for username cookie
      var cookies = document.cookie.split(';').map(cookie => cookie.trim());
      var usernameCookie = cookies.find(cookie => cookie.startsWith('username='));
      if (!usernameCookie) {
        alert('Please log in to add items to your cart.');
        window.location.href = '${pageContext.request.contextPath}/login';
        return;
      }

      // Validate quantity
      quantity = parseInt(quantity);
      if (isNaN(quantity) || quantity < 1) {
        alert('Please enter a valid quantity.');
        return;
      }

      var xhr = new XMLHttpRequest();
      xhr.open('POST', '${pageContext.request.contextPath}/addtocart', true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      var data = 'productId=' + encodeURIComponent(productId) +
                 '&productName=' + encodeURIComponent(productName) +
                 '&price=' + encodeURIComponent(price) +
                 '&brand=' + encodeURIComponent(brand) +
                 '&productImage=' + encodeURIComponent(productImage) +
                 '&quantity=' + encodeURIComponent(quantity);
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
          if (xhr.status === 200) {
            alert('Product added to cart!');
          } else if (xhr.status === 401) {
            alert('Please log in to add items to your cart.');
            window.location.href = '${pageContext.request.contextPath}/login';
          } else {
            alert(xhr.responseText || 'Failed to add product to cart.');
          }
        }
      };
      xhr.send(data);
    }
  </script>

  <jsp:include page="footer.jsp"/>
</body>
</html>