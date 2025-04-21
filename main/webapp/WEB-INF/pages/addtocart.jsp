<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" >
    <!-- responsive viewport -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
     <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addtocart.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    
  </head>
  

  <body>
     <jsp:include page="header.jsp"/>
  
    <!-- Banner section -->
    <div class = cart-page>
    <div class="banner">
      <h1>SCENTED BLISS</h1>
      <p>FRAGRANCE AS RARE AS YOU</p>
    </div>

    <!-- Main container for the shopping cart -->
    <div class="cart">
      <!-- Section for displaying cart items -->
      <div class="items">
        <h2>Shopping Cart <span id="item-count">3 items</span></h2>

        <!-- Individual item in the cart -->
        <div class="item" data-price="105">
          <div class="item-left">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo11.jpg" alt="" />
            <div class="item-details">
              <div class="brand">DIOR</div>
              <div class="product">DIOR HOMME INTENSE</div>
            </div>
          </div>
          <div class="qty">
            <button class="minus"><i class="fas fa-minus"></i></button>
            <input type="number" class="qty-input" value="1" min="1" />
            <button class="plus"><i class="fas fa-plus"></i></button>
          </div>
          <div class="price">$<span class="price-val">105</span>.00</div>
          <button class="remove-item"><i class="fas fa-times"></i></button>
        </div>

        <!-- Individual item in the cart -->
        <div class="item" data-price="115">
          <div class="item-left">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo3.jpg" alt="" />
            <div class="item-details">
              <div class="brand">CHANEL</div>
              <div class="product">PLATINUM ÉGOÏSTE</div>
            </div>
          </div>
          <div class="qty">
            <button class="minus"><i class="fas fa-minus"></i></button>
            <input type="number" class="qty-input" value="1" min="1" />
            <button class="plus"><i class="fas fa-plus"></i></button>
          </div>
          <div class="price">$<span class="price-val">115</span>.00</div>
          <button class="remove-item"><i class="fas fa-times"></i></button>
        </div>

        <!-- Individual item in the cart -->
        <div class="item" data-price="145">
          <div class="item-left">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo16.jpg" alt="" />
            <div class="item-details">
              <div class="brand">DIOR</div>
              <div class="product">DIOR FAHRENHEIT</div>
            </div>
          </div>
          <div class="qty">
            <button class="minus"><i class="fas fa-minus"></i></button>
            <input type="number" class="qty-input" value="1" min="1" />
            <button class="plus"><i class="fas fa-plus"></i></button>
          </div>
          <div class="price">$<span class="price-val">145</span>.00</div>
          <button class="remove-item"><i class="fas fa-times"></i></button>
        </div>

        <a href="#" class="back"
          ><i class="fas fa-arrow-left"></i> Back to shop</a
        >
      </div>

      <!-- Section for displaying the cart summary -->
      <div class="summary">
        <h3>Summary</h3>
        <div class="line">
          <span>Items (<span id="summary-count">3</span>)</span>
          <span>$<span id="summary-sub">365</span>.00</span>
        </div>
        <div class="line">
          <span>Shipping</span>
          <span>$<span id="shipping">10</span>.00</span>
        </div>
        <div class="total">
          <span>Total Price</span>
          <span>$<span id="summary-total">375</span>.00</span>
        </div>
        <!-- Checkout button -->
        <a href="#" class="checkout">Checkout</a>
      </div>
    </div>

    <!-- JavaScript for handling transaction -->
    <script>
      var SHIPPING = 10; // Fixed shipping cost

      // Function to update totals and display
      function updateCart() {
        var items = document.querySelectorAll(".item"), // Get all items in the cart
          totalCount = 0,
          subTotal = 0; // Track total items and subtotal

        // Iterating through each item to calculate totals
        for (var i = 0; i < items.length; i++) {
          var pricePer = parseFloat(items[i].dataset.price), // Price per item
            qtyInput = items[i].querySelector(".qty-input"), // Quantity input field
            qty = parseInt(qtyInput.value, 10), // Current quantity
            lineTotal = pricePer * qty; // Total cost for item

          items[i].querySelector(".price-val").textContent =
            lineTotal.toFixed(0); // Updating item price display

          totalCount += qty; // Adding to total item count
          subTotal += lineTotal; // Adding to subtotal
        }

        // Updating the cart header and summary with calculated values
        document.getElementById("item-count").textContent =
          totalCount + " items";
        document.getElementById("summary-count").textContent = totalCount;
        document.getElementById("summary-sub").textContent =
          subTotal.toFixed(0);
        document.getElementById("shipping").textContent = SHIPPING.toFixed(0);
        document.getElementById("summary-total").textContent = (
          subTotal + SHIPPING
        ).toFixed(0);
      }

      // Get all buttons and inputs for interaction
      var plusBtns = document.getElementsByClassName("plus"),
        minusBtns = document.getElementsByClassName("minus"),
        removeBtns = document.getElementsByClassName("remove-item"),
        qtyInputs = document.getElementsByClassName("qty-input");

      // Adding functionality to plus buttons
      for (var i = 0; i < plusBtns.length; i++) {
        plusBtns[i].onclick = function () {
          var inp = this.parentNode.querySelector(".qty-input");
          inp.value = parseInt(inp.value, 10) + 1; // Increase quantity
          updateCart(); // Refresh cart totals
        };
      }

      // Adding functionality to minus buttons
      for (var i = 0; i < minusBtns.length; i++) {
        minusBtns[i].onclick = function () {
          var inp = this.parentNode.querySelector(".qty-input");
          if (inp.value > 1) inp.value = parseInt(inp.value, 10) - 1; // Decrease quantity if above 1
          updateCart();
        };
      }

      // Adding functionality to remove buttons
      for (var i = 0; i < removeBtns.length; i++) {
        removeBtns[i].onclick = function () {
          this.parentNode.remove(); // Remove the item from the cart
          updateCart();
        };
      }

      // Handling quantity changes
      for (var i = 0; i < qtyInputs.length; i++) {
        qtyInputs[i].onchange = function () {
          if (this.value < 1) this.value = 1;
          updateCart();
        };
      }

      // Calling updateCart function on page reload
      updateCart();
    </script>
    </div>
    
   <jsp:include page="footer.jsp"/>
   
   
  </body>
</html>