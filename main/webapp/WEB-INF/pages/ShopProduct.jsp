<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ShopProduct.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <title>Fragrances Store</title>
</head>
<body>
  <jsp:include page="header.jsp"/>

  <div class="Shop-product">
    <section class="banner">
      <div class="container banner-inner">
        <div class="banner-text">
          <h2 class="banner-title">SCENTED BLISS</h2>
          <p class="banner-subtitle">FRAGRANCE AS RARE AS YOU</p>
        </div>
        <div class="banner-images">
          <img src="${pageContext.request.contextPath}/resources/images/system/Photo2.jpg" alt="Product 1" />
          <img src="${pageContext.request.contextPath}/resources/images/system/Photo1.jpg" alt="Product 2" />
        </div>
      </div>
      <div class="banner-divider"></div>
      <p class="banner-description">
        Welcome to Scented Bliss, where luxury perfumes evoke timeless elegance.
        Each artisanal fragrance weaves luminous florals, rare spices, and
        golden amber into an olfactory masterpiece. Discover your signature
        scent and indulge in exquisite sensory luxury.
      </p>
    </section>

    <main class="container main">
      <div class="text-center mb-8">
        <span>LUXURY PERFUMES</span>
        <h1 class="title">OUR FRAGRANCES</h1>
      </div>

      <div class="toolbar">
        <div class="search-container">
          <input type="text" id="search-input" placeholder="Search products..." />
          <button id="search-btn"><i class="fas fa-search"></i></button>
        </div>
        <select id="sort-select" class="btn">
          <option value="default">Sort By</option>
          <option value="low-high">Price: Low to High</option>
          <option value="high-low">Price: High to Low</option>
        </select>
        <select id="filter-select" class="btn">
          <option value="all">All Types</option>
          <option value="CHANEL">CHANEL</option>
          <option value="DIOR">DIOR</option>
          <option value="CALVIN KLEIN">CALVIN KLEIN</option>
          <option value="HERMES">HERMES</option>
        </select>
      </div>

      <div class="grid" id="product-grid">
        <c:forEach var="product" items="${products}" varStatus="status">
          <c:if test="${status.index < 8}">
            <div class="product-card" data-price="${product.price}" data-type="${product.brand}" data-product-id="${product.productId}">
              <div class="product-image-wrapper">
                <a href="#" class="product-link">
                  <img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}" class="product-image"/>
                </a>
                <button class="wishlist-button"><i class="far fa-heart"></i></button>
              </div>
              <h3 class="product-name">${product.productName}</h3>
              <p class="product-type">${product.brand}</p>
              <p class="price">$${product.price}</p>
              <div class="cart-controls">
                <input type="number" class="quantity-input" min="1" value="1" data-product-id="${product.productId}" style="width: 60px; margin-right: 10px;" />
                <button class="add-to-bag" onclick="addToCart(${product.productId}, '${product.productName}', ${product.price}, '${product.brand}', '${product.productImage}', this.previousElementSibling.value)">ADD TO CART</button>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>

      <c:set var="hasMore" value="${products.size() > 8}" />
      <div class="grid" id="product-grid-more" style="display: none;">
        <c:forEach var="product" items="${products}" varStatus="status">
          <c:if test="${status.index >= 8}">
            <div class="product-card" data-price="${product.price}" data-type="${product.brand}" data-product-id="${product.productId}">
              <div class="product-image-wrapper">
                <a href="#" class="product-link">
                  <img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}" class="product-image"/>
                </a>
                <button class="wishlist-button"><i class="far fa-heart"></i></button>
              </div>
              <h3 class="product-name">${product.productName}</h3>
              <p class="product-type">${product.brand}</p>
              <p class="price">$${product.price}</p>
              <div class="cart-controls">
                <input type="number" class="quantity-input" min="1" value="1" data-product-id="${product.productId}" style="width: 60px; margin-right: 10px;" />
                <button class="add-to-bag" onclick="addToCart(${product.productId}, '${product.productName}', ${product.price}, '${product.brand}', '${product.productImage}', this.previousElementSibling.value)">ADD TO CART</button>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>

      <div class="load-more-container">
        <c:if test="${hasMore}">
          <button class="load-more-btn">Load More</button>
        </c:if>
      </div>
    </main>
  </div>

  <script>
    var grid1 = document.getElementById('product-grid');
    var grid2 = document.getElementById('product-grid-more');
    var searchIn = document.getElementById('search-input');
    var searchBtn = document.getElementById('search-btn');
    var sortSel = document.getElementById('sort-select');
    var filterSel = document.getElementById('filter-select');
    var loadMoreBtn = document.querySelector('.load-more-btn');
    var showMore = false;

    var allInitial = [], allExtra = [];
    document.addEventListener('DOMContentLoaded', function(){
      Array.prototype.forEach.call(grid1.children, function(c){
        allInitial.push(c.cloneNode(true));
      });
      Array.prototype.forEach.call(grid2.children, function(c){
        allExtra.push(c.cloneNode(true));
      });
      grid1.innerHTML = '';
      grid2.innerHTML = '';
      updateProducts();
    });

    function matches(card, term, type){
      var name = card.querySelector('.product-name').innerText.toLowerCase();
      var ctype = card.getAttribute('data-type');
      var okSearch = !term || name.indexOf(term) !== -1;
      var okFilter = (type === 'all') || (ctype === type);
      return okSearch && okFilter;
    }

    function updateProducts(){
      var term = searchIn.value.trim().toLowerCase();
      var type = filterSel.value;

      var combined = allInitial.concat(allExtra);
      var filtered = combined.filter(function(c){
        return matches(c, term, type);
      });

      var mode = sortSel.value;
      if(mode === 'low-high' || mode === 'high-low'){
        filtered.sort(function(a, b){
          var pa = parseFloat(a.getAttribute('data-price'));
          var pb = parseFloat(b.getAttribute('data-price'));
          return mode === 'low-high' ? pa - pb : pb - pa;
        });
      }

      if(term){
        grid1.innerHTML = '';
        grid2.style.display = 'none';
        if(loadMoreBtn) loadMoreBtn.style.display = 'none';

        if(filtered.length){
          filtered.forEach(function(c){
            grid1.appendChild(c.cloneNode(true));
          });
        } else {
          grid1.innerHTML = '<p class="not-found">Oops, it seems that product is unavailable right now.</p>';
        }
        return;
      }

      if(loadMoreBtn) loadMoreBtn.style.display = 'inline-block';
      grid1.innerHTML = '';
      grid2.innerHTML = '';

      var initSlice = filtered.slice(0, allInitial.length);
      var extraSlice = filtered.slice(allInitial.length);

      initSlice.forEach(function(c){
        grid1.appendChild(c.cloneNode(true));
      });

      if(showMore){
        extraSlice.forEach(function(c){
          grid2.appendChild(c.cloneNode(true));
        });
        grid2.style.display = extraSlice.length ? 'grid' : 'none';
        if(loadMoreBtn) loadMoreBtn.textContent = 'Load Less';
      } else {
        grid2.style.display = 'none';
        if(loadMoreBtn) loadMoreBtn.textContent = 'Load More';
      }
    }

    function toggleMore(){
      showMore = !showMore;
      updateProducts();
    }

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

    if(loadMoreBtn){
      loadMoreBtn.addEventListener('click', toggleMore);
    }
    searchBtn.addEventListener('click', updateProducts);
    searchIn.addEventListener('keyup', function(e){
      if(e.key === 'Enter') updateProducts();
    });
    sortSel.addEventListener('change', updateProducts);
    filterSel.addEventListener('change', updateProducts);
  </script>

  <jsp:include page="footer.jsp"/>
</body>
</html>