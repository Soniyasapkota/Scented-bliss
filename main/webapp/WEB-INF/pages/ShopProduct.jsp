<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <!-- responsive viewport -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Linking CSS and FontAwesome -->
  <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ShopProduct.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
  <title>Fragrances Store</title>
</head>
<body>
  <jsp:include page="header.jsp"/>

  <!-- banner -->
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

  <!-- Main Content -->
  <main class="container main">
    <!-- Title -->
    <div class="text-center mb-8">
      <span>LUXURY PERFUMES</span>
      <h1 class="title">OUR FRAGRANCES</h1>
    </div>

    <!-- Controls -->
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

    <!-- Product Grid for first 8 products -->
    <div class="grid" id="product-grid">
      <div class="product-card" data-price="145" data-type="CHANEL">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo1.jpg" alt="N°1 DE CHANEL" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">N°1 DE CHANEL</h3>
        <p class="product-type">CHANEL</p>
        <p class="price">$145.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="120" data-type="HERMES">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo2.jpg" alt="TERRE D'HERMES" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">TERRE D'HERMES</h3>
        <p class="product-type">HERMES</p>
        <p class="price">$120.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="115" data-type="CHANEL">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo3.jpg" alt="PLATINUM ÉGOÏSTE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">PLATINUM ÉGOÏSTE</h3>
        <p class="product-type">CHANEL</p>
        <p class="price">$115.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="110" data-type="HERMES">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo4.jpg" alt="Jardin sur le Toit" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">Jardin sur le Toit</h3>
        <p class="product-type">HERMES</p>
        <p class="price">$110.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="100" data-type="CALVIN KLEIN">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo5.jpg" alt="CKFREE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">CKFREE</h3>
        <p class="product-type">CALVIN KLEIN</p>
        <p class="price">$100.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="100" data-type="CHANEL">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo6.jpg" alt="COROMANDEL CHANEL" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">COROMANDEL CHANEL</h3>
        <p class="product-type">CHANEL</p>
        <p class="price">$100.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="100" data-type="CALVIN KLEIN">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo7.jpg" alt="CK ETERNITY" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">CK ETERNITY</h3>
        <p class="product-type">CALVIN KLEIN</p>
        <p class="price">$100.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="100" data-type="CHANEL">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo8.jpg" alt="BLEU DE CHANEL" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">BLEU DE CHANEL</h3>
        <p class="product-type">CHANEL</p>
        <p class="price">$100.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
    </div>

    <!--Product Grid for Special Product -->
    <div class="product-card special-card">
      <div class="special-image">
        <img src="${pageContext.request.contextPath}/resources/images/system/Photo17.jpg"
             alt="Terre d'Hermes Parfum - 2.54 fl.oz | Hermès" />
      </div>
      <div class="special-info">
        <h3>PRODUCT OF THE WEEK</h3>
        <h3>Terre d'Hermes Parfum - 2.54 fl.oz | Hermès</h3>
        <p>
          A warm, woody fragrance, Terre d'Hermès Parfum combines enveloping cedar and sparkling grapefruit with a radiant note of shiso
        </p>
        <a href="#" class="shop-btn">View Product</a>
      </div>
    </div>

    <!-- Product Grid for Extra Products -->
    <div class="grid" id="product-grid-more" style="display: none;">
      <div class="product-card" data-price="130" data-type="DIOR">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo9.jpg" alt="DIOR HOMME COLOGNE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">DIOR HOMME COLOGNE</h3>
        <p class="product-type">DIOR</p>
        <p class="price">$130.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="160" data-type="CALVIN KLEIN">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo10.jpg" alt="CALVIN KLEIN BE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">CALVIN KLEIN BE</h3>
        <p class="product-type">CALVIN KLEIN</p>
        <p class="price">$160.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="105" data-type="DIOR">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo11.jpg" alt="DIOR HOMME INTENSE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">DIOR HOMME INTENSE</h3>
        <p class="product-type">DIOR</p>
        <p class="price">$105.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="125" data-type="CHANEL">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo12.jpg" alt="N°19 CHANEL" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">N°19 CHANEL</h3>
        <p class="product-type">CHANEL</p>
        <p class="price">$125.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="140" data-type="CALVIN KLEIN">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo13.jpg" alt="CALVIN KLEIN DEFY" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">CALVIN KLEIN DEFY</h3>
        <p class="product-type">CALVIN KLEIN</p>
        <p class="price">$140.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="135" data-type="DIOR">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo14.jpg" alt="DIOR SAUVAGE" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">DIOR SAUVAGE</h3>
        <p class="product-type">DIOR</p>
        <p class="price">$135.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="150" data-type="HERMES">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo15.jpg" alt="HERMES THREE DIMENSION" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">HERMES THREE DIMENSION</h3>
        <p class="product-type">HERMES</p>
        <p class="price">$150.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
      <div class="product-card" data-price="145" data-type="DIOR">
        <div class="product-image-wrapper">
          <a href="#" class="product-link">
            <img src="${pageContext.request.contextPath}/resources/images/system/Photo16.jpg" alt="DIOR FAHRENHEIT" class="product-image"/>
          </a>
          <button class="wishlist-button"><i class="far fa-heart"></i></button>
        </div>
        <h3 class="product-name">DIOR FAHRENHEIT</h3>
        <p class="product-type">DIOR</p>
        <p class="price">$145.00</p>
        <button class="add-to-bag">ADD TO CART</button>
      </div>
    </div>

    <div class="load-more-container">
      <button class="load-more-btn">Load More</button>
    </div>
  </main>
<script>
  //DOM references & State variables
  var grid1       = document.getElementById('product-grid');
  var grid2       = document.getElementById('product-grid-more');
  var searchIn    = document.getElementById('search-input');
  var searchBtn   = document.getElementById('search-btn');
  var sortSel     = document.getElementById('sort-select');
  var filterSel   = document.getElementById('filter-select');
  var loadMoreBtn = document.querySelector('.load-more-btn');
  var showMore    = false;

  //Snapshoting all cards on load
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

  //Checking if a card matches search term and type filter
  function matches(card, term, type){
    var name = card.querySelector('.product-name').innerText.toLowerCase();
    var ctype = card.getAttribute('data-type');
    var okSearch = !term || name.indexOf(term) !== -1;
    var okFilter = (type==='all') || (ctype===type);
    return okSearch && okFilter;
  }

  // Creating funtions for filtering, sorting and rendering products
  function updateProducts(){
    var term = searchIn.value.trim().toLowerCase();
    var type = filterSel.value;

    // combining all cards into one array
    var combined = allInitial.concat(allExtra);

    // filtering by search + type
    var filtered = combined.filter(function(c){
      return matches(c, term, type);
    });

    // function to sort the filtered array by price
    var mode = sortSel.value;
    if(mode === 'low-high' || mode === 'high-low'){
      filtered.sort(function(a, b){
        var pa = parseFloat(a.getAttribute('data-price'));
        var pb = parseFloat(b.getAttribute('data-price'));
        return mode==='low-high' ? pa-pb : pb-pa;
      });
    }

    //Showing all filtered sorted in grid1 if in search
    if(term){
      grid1.innerHTML = '';
      grid2.style.display = 'none';
      loadMoreBtn.style.display = 'none';

      if(filtered.length){
        filtered.forEach(function(c){
          grid1.appendChild(c.cloneNode(true));
        });
      } else {
        grid1.innerHTML = '<p class="not-found">Oops, it seems that product is unavailable right now.</p>';
      }
      return;
    }

    // function for default mode i.e. show initial products and extra seperately
    loadMoreBtn.style.display = 'inline-block';
    grid1.innerHTML = '';
    grid2.innerHTML = '';

    // spliting back into initial count vs extras
    var initSlice  = filtered.slice(0, allInitial.length);
    var extraSlice = filtered.slice(allInitial.length);

    initSlice.forEach(function(c){
      grid1.appendChild(c.cloneNode(true));
    });

    if(showMore){
      extraSlice.forEach(function(c){
        grid2.appendChild(c.cloneNode(true));
      });
      grid2.style.display = extraSlice.length ? 'grid' : 'none';
      loadMoreBtn.textContent = 'Load Less';
    } else {
      grid2.style.display = 'none';
      loadMoreBtn.textContent = 'Load More';
    }
  }

  //Toggling extras
  function toggleMore(){
    showMore = !showMore;
    updateProducts();
  }

  //Wiring event
  searchBtn.addEventListener('click', updateProducts);
  searchIn .addEventListener('keyup', function(e){
    if(e.key==='Enter') updateProducts();
  });
  sortSel  .addEventListener('change', updateProducts);
  filterSel.addEventListener('change', updateProducts);
  loadMoreBtn.addEventListener('click', toggleMore);
</script>
</div>
<jsp:include page="footer.jsp"/>

</body>
</html>
