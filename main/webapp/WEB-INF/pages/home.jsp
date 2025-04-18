<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/home.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
</head>
<body>

	<jsp:include page="header.jsp"/>

	<section class="main">
    <div class="main-item1">
        <img src="image/coco_bestselling.jpg" alt="Chanel Perfume">
        <p>A Fragrance collection that embodies the house.</p>
    </div>
    <div class="main-logo">
        <img src="image/main_img.jpg" alt="Scented Bliss Logo">
    </div>
    <div class="main-item2">
        <img src="image/ariana.jpg" alt="Victoria's Secret">
        <p>Fresh Fragrances<br>Floral Fragrances<br>Sweet Fragrances</p>
    </div>
  </section>


  <section class="best-selling">
    <h2>Best Selling Product</h2>
    <div class="products">
        <div class="product-card">
            <img src="image/sauvage.jpg" alt="Dior Sauvage">
            <p>Sale Price: $89.13</p>
            <p class="original">Original Price: $110.90</p>
            <button>🛒</button>
            <button>Buy Now</button>
        </div>
        <div class="product-card">
            <img src="image/victoria.jpg" alt="Juicy Couture">
            <p>Sale Price: $45.00</p>
            <p class="original">Original Price: $69.00</p>
            <button>🛒</button>
            <button>Buy Now</button>
        </div>
        <div class="product-card">
            <img src="image/blue_channel.jpg" alt="Coco Chanel">
            <p>Sale Price: $90.50</p>
            <p class="original">Original Price: $115.90</p>
            <button>🛒</button>
            <button>Buy Now</button>
        </div>
    </div>
  </section>


  <section class="quote">
    <p>Perfume is the key to our memories.<br>
        A Scented Bliss believes in the<br>
        high quality perfume to enhance<br>
        the fragrance of life.<br>
        We believe fragrance as a<br>
        reflection of our personality.
    </p>
    <div class="quote-images">
        <img src="image/coco_channel.jpg" alt="Bleu de Chanel">
        <img src="image/miss_dior.jpg" alt="Miss Dior">
        <img src="image/pretty.jpg" alt="Pretty">
    </div>
  </section>


	<jsp:include page="footer.jsp"/>
	
	

</body>
</html>