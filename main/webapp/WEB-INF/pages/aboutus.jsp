<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Scented Bliss</title>
    <link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/header.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/aboutus.css" />

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/footer.css" />
   
</head>
<body>
  <jsp:include page="header.jsp"/>

  
   <div class="About-us">
    <!-- About Us Section -->
    <section class="about-section">
        <h1>About Us</h1>
    </section>

    <!-- Team Section -->
    <section class="team-section">
        <h2>Our Amazing Team</h2>
        <div class="team-container">
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/resources/images/system/soniya.jpeg" alt="Soniya Sapkota">
                <p>Soniya Sapkota</p>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/resources/images/system/ishpa.jpeg" alt="Ishpa Maharjan">
                <p>Ishpa Maharjan</p>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/resources/images/system/raghav.jpeg" alt="Raghav Chaulagain">
                <p>Raghav Chaulagain</p>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/resources/images/system/sadiksha.JPG" alt="Sadiksha Karki">
                <p>Sadiksha Karki</p>
            </div>
            <div class="team-member">
                <img src="${pageContext.request.contextPath}/resources/images/system/sabin.jpeg" alt="Sabin Devkota">
                <p>Sabin Devkota</p>
            </div>
        </div>
    </section>

    <!-- Philosophy Section -->
    <section class="philosophy-section">
        <h2>Our Philosophy</h2>
        <div><p class="philosophy-intro">Welcome to Scented Bliss, A world of fragrance.</p></div>
        <div class="philosophy-content">
            <img src="${pageContext.request.contextPath}/resources/images/system/aboutuscontent.jpg" alt="Perfume Bottle">
            <p>
                At Scented Bliss, we bring the world of fine fragrances right to your doorstep. 
                Our curated collection features premium perfumes from renowned international brands and hidden gems from niche perfumers. 
                Whether you're searching for your signature scent or the perfect gift, we’re here to make your fragrance journey seamless, personal, and unforgettable. 
                With fast shipping, secure payments, and exceptional customer service, we’re passionate about helping you smell your best every day.
            </p>
        </div>
    </section>
    </div>

    <jsp:include page="footer.jsp"/>

</body>
</html>