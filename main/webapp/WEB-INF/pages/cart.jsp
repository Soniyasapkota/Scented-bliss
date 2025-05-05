<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Your Shopping Cart</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

  <style>
    .success {
      color: green;
      font-weight: bold;
      margin: 10px 0;
    }
    .error {
      color: red;
      font-weight: bold;
      margin: 10px 0;
    }
    .login-prompt {
      text-align: center;
      margin: 20px 0;
    }
    .login-prompt a {
      color: #007bff;
      text-decoration: none;
    }
    .login-prompt a:hover {
      text-decoration: underline;
    }
    .debug {
      color: gray;
      font-size: 12px;
      margin: 10px 0;
    }
  </style>

  <script>
    function updateQty(productId, qty) {
      if (qty < 1) qty = 1;
      window.location.href = 
        '${pageContext.request.contextPath}/cart'
        + '?action=updateQuantity'
        + '&productId=' + productId
        + '&quantity=' + qty;
    }
    function deleteItem(productId) {
      if (confirm('Remove this item from your cart?')) {
        window.location.href = 
          '${pageContext.request.contextPath}/cart'
          + '?action=delete'
          + '&productId=' + productId;
      }
    }
  </script>
</head>
<body>
  <jsp:include page="header.jsp"/>

  <div class="cart-container">
    <div class="cart-content">
      <h2>Shopping Cart</h2>
      <c:choose>
        <c:when test="${empty sessionScope.username}">
          <div class="login-prompt">
            <p>Please <a href="${pageContext.request.contextPath}/login?returnUrl=/cart">log in</a> to view your cart.</p>
          </div>
          <!-- Debugging output -->
          <p class="debug">Debug: sessionScope.username is empty. Check if username cookie is set.</p>
        </c:when>
        <c:otherwise>
          <p class="item-count">${cartList != null ? cartList.size() : 0} Items</p>
          <p class="debug">Debug: sessionScope.username = ${sessionScope.username}</p>

          <c:if test="${not empty sessionScope.success}">
            <p class="success">${sessionScope.success}</p>
            <c:remove var="success" scope="session"/>
          </c:if>
          <c:if test="${not empty sessionScope.error}">
            <p class="error">${sessionScope.error}</p>
            <c:remove var="error" scope="session"/>
          </c:if>
          <c:if test="${not empty error}">
            <p class="error">${error}</p>
          </c:if>

          <c:if test="${cartList == null}">
            <p>Error loading cart. Please try again later.</p>
          </c:if>
          <c:if test="${empty cartList}">
            <p>Your cart is empty.</p>
          </c:if>

          <c:if test="${not empty cartList}">
            <c:set var="subtotal" value="0.0" scope="page"/>
            <c:forEach var="item" items="${cartList}">
              <c:set var="subtotal" value="${subtotal + (item.price * item.quantity)}" scope="page"/>
            </c:forEach>

            <c:forEach var="item" items="${cartList}">
              <c:set var="prevQty" value="${item.quantity > 1 ? item.quantity - 1 : 1}"/>
              <c:set var="nextQty" value="${item.quantity + 1}"/>

              <div class="cart-item">
                <img src="${pageContext.request.contextPath}${item.productImage}" 
                     alt="${item.productName}" />

                <div class="item-details">
                  <p>${item.productName}</p>
                  <div class="quantity-controls">
                    <button type="button"
                            onclick="updateQty(${item.productId}, ${prevQty})"
                            ${item.quantity <= 1 ? 'disabled' : ''}>
                      <i class="fas fa-minus"></i>
                    </button>
                    <span class="quantity">${item.quantity}</span>
                    <button type="button"
                            onclick="updateQty(${item.productId}, ${nextQty})">
                      <i class="fas fa-plus"></i>
                    </button>
                  </div>
                </div>

                <span class="item-price">
                  <fmt:formatNumber value="${item.price * item.quantity}" type="currency"/>
                </span>

                <button type="button" class="remove-item"
                        onclick="deleteItem(${item.productId})">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </c:forEach>
          </c:if>
        </c:otherwise>
      </c:choose>
    </div>

    <c:if test="${not empty cartList}">
      <div class="summary">
        <p>Items: <strong>${cartList.size()}</strong></p>
        <p>Subtotal: 
          <strong><fmt:formatNumber value="${subtotal}" type="currency"/></strong>
        </p>
        <p>Shipping: <strong><fmt:formatNumber value="${sessionScope.shippingFee != null ? sessionScope.shippingFee : 10.00}" type="currency"/></strong></p>
        <p class="total-price">
          TOTAL: 
          <strong><fmt:formatNumber 
                      value="${subtotal + (sessionScope.shippingFee != null ? sessionScope.shippingFee : 10.00)}" 
                      type="currency"/></strong>
        </p>
        <button class="checkout-btn">CHECKOUT</button>
      </div>
    </c:if>
  </div>

  <jsp:include page="footer.jsp"/>
</body>
</html>