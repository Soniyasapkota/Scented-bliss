<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addtocart.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <!-- Banner section -->
    <div class="cart-page">
        <div class="banner">
            <h1>SCENTED BLISS</h1>
            <p>FRAGRANCE AS RARE AS YOU</p>
        </div>

        <!-- Main container for the shopping cart -->
        <div class="cart">
            <!-- Section for displaying cart items -->
            <div class="items">
                <h2>Shopping Cart <span id="item-count">0 items</span></h2>

                <c:forEach var="cartItem" items="${cartItems}">
                    <div class="item" data-price="${cartItem.price}" data-product-id="${cartItem.productId}" data-cart-user-product-id="${cartItem.cartUserProductId}">
                        <div class="item-left">
                            <img src="${pageContext.request.contextPath}${cartItem.productImage}" alt="${cartItem.productName}" />
                            <div class="item-details">
                                <div class="brand">${cartItem.brand}</div>
                                <div class="product">${cartItem.productName}</div>
                            </div>
                        </div>
                        <div class="qty">
                            <button class="minus"><i class="fas fa-minus"></i></button>
                            <input type="number" class="qty-input" value="${cartItem.quantity}" min="1" />
                            <button class="plus"><i class="fas fa-plus"></i></button>
                        </div>
                        <div class="price">$<span class="price-val">${cartItem.price * cartItem.quantity}</span>.00</div>
                        <button class="remove-item"><i class="fas fa-times"></i></button>
                    </div>
                </c:forEach>

                <a href="${pageContext.request.contextPath}/ShopProduct" class="back"><i class="fas fa-arrow-left"></i> Back to shop</a>
            </div>

            <!-- Section for displaying the cart summary -->
            <div class="summary">
                <h3>Summary</h3>
                <div class="line">
                    <span>Items (<span id="summary-count">0</span>)</span>
                    <span>$<span id="summary-sub">0</span>.00</span>
                </div>
                <div class="line">
                    <span>Shipping</span>
                    <span>$<span id="shipping">10</span>.00</span>
                </div>
                <div class="total">
                    <span>Total Price</span>
                    <span>$<span id="summary-total">0</span>.00</span>
                </div>
                <a href="#" class="checkout">Checkout</a>
            </div>
        </div>

        <!-- JavaScript for handling cart interactions -->
        <script>
            var SHIPPING = 10;

            function updateCart() {
                var items = document.querySelectorAll(".item"),
                    totalCount = 0,
                    subTotal = 0;

                for (var i = 0; i < items.length; i++) {
                    var pricePer = parseFloat(items[i].dataset.price),
                        qtyInput = items[i].querySelector(".qty-input"),
                        qty = parseInt(qtyInput.value, 10),
                        lineTotal = pricePer * qty;

                    items[i].querySelector(".price-val").textContent = lineTotal.toFixed(0);
                    totalCount += qty;
                    subTotal += lineTotal;
                }

                document.getElementById("item-count").textContent = totalCount + " items";
                document.getElementById("summary-count").textContent = totalCount;
                document.getElementById("summary-sub").textContent = subTotal.toFixed(0);
                document.getElementById("shipping").textContent = SHIPPING.toFixed(0);
                document.getElementById("summary-total").textContent = (subTotal + SHIPPING).toFixed(0);
            }

            function updateCartItem(productId, quantity, cartUserProductId) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '${pageContext.request.contextPath}/addtocart', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                var data = 'action=update' +
                           '&productId=' + encodeURIComponent(productId) +
                           '&quantity=' + encodeURIComponent(quantity) +
                           '&cartUserProductId=' + encodeURIComponent(cartUserProductId);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status !== 200) {
                        alert('Failed to update cart.');
                    }
                };
                xhr.send(data);
            }

            function removeCartItem(productId, cartUserProductId, element) {
                var xhr = new XMLHttpRequest();
                xhr.open('POST', '${pageContext.request.contextPath}/addtocart', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                var data = 'action=remove' +
                           '&productId=' + encodeURIComponent(productId) +
                           '&cartUserProductId=' + encodeURIComponent(cartUserProductId);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            element.parentNode.remove();
                            updateCart();
                        } else {
                            alert('Failed to remove item.');
                        }
                    }
                };
                xhr.send(data);
            }

            var plusBtns = document.getElementsByClassName("plus"),
                minusBtns = document.getElementsByClassName("minus"),
                removeBtns = document.getElementsByClassName("remove-item"),
                qtyInputs = document.getElementsByClassName("qty-input");

            for (var i = 0; i < plusBtns.length; i++) {
                plusBtns[i].onclick = function() {
                    var inp = this.parentNode.querySelector(".qty-input");
                    var item = this.closest(".item");
                    var productId = item.dataset.productId;
                    var cartUserProductId = item.dataset.cartUserProductId;
                    inp.value = parseInt(inp.value, 10) + 1;
                    updateCartItem(productId, inp.value, cartUserProductId);
                    updateCart();
                };
            }

            for (var i = 0; i < minusBtns.length; i++) {
                minusBtns[i].onclick = function() {
                    var inp = this.parentNode.querySelector(".qty-input");
                    var item = this.closest(".item");
                    var productId = item.dataset.productId;
                    var cartUserProductId = item.dataset.cartUserProductId;
                    if (inp.value > 1) {
                        inp.value = parseInt(inp.value, 10) - 1;
                        updateCartItem(productId, inp.value, cartUserProductId);
                        updateCart();
                    }
                };
            }

            for (var i = 0; i < removeBtns.length; i++) {
                removeBtns[i].onclick = function() {
                    var item = this.closest(".item");
                    var productId = item.dataset.productId;
                    var cartUserProductId = item.dataset.cartUserProductId;
                    removeCartItem(productId, cartUserProductId, this);
                };
            }

            for (var i = 0; i < qtyInputs.length; i++) {
                qtyInputs[i].onchange = function() {
                    if (this.value < 1) this.value = 1;
                    var item = this.closest(".item");
                    var productId = item.dataset.productId;
                    var cartUserProductId = item.dataset.cartUserProductId;
                    updateCartItem(productId, this.value, cartUserProductId);
                    updateCart();
                };
            }

            updateCart();
        </script>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>