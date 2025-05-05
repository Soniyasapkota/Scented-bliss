<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.scentedbliss.model.ProductModel" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Perfume Shop Product List</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/productlist.css" />
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css" />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <script>
    function confirmDelete(productName, formId) {
      if (confirm("Are you sure you want to remove the product '" + productName + "'?")) {
        document.getElementById(formId).submit();
      }
    }
  </script>
</head>
<body>
  <div class="container">
    <aside class="sidebar">
      <h2>Admin</h2>
      <ul>
        <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
        <li>Order List</li>
        <li><a href="${pageContext.request.contextPath}/product">Product List</a></li>
       <li><a href="${pageContext.request.contextPath}/customerlist">Customer List</a></li>
        <li>Sales Reports</li>
       <li><a href="${contextPath}/userProfile"></a>Account</li>
      </ul>
    </aside>

    <main class="main-content">
      <div id="header">
        <header class="header">
          <div class="logo">
            <a href="${contextPath}" class="logo-text">Scented Bliss</a>
          </div>
          <ul class="main-nav right-nav">
            <li>
              <form action="${contextPath}/logout" method="post">
                <input type="submit" class="nav-button" value="Logout" />
              </form>
            </li>
          </ul>
        </header>
      </div>

      <div class="content-body">
        <div class="product-controls">
          <div class="control-row top-buttons">
            <form action="${pageContext.request.contextPath}/product" method="get">
              <input type="hidden" name="formSubmit" value="addProduct">
              <button type="submit">Add Product</button>
            </form>
          </div>
        </div>

        <c:if test="${not empty success}">
          <p class="success-message">${success}</p>
        </c:if>
        <c:if test="${not empty error}">
          <p class="error-message">${error}</p>
        </c:if>

        <table>
          <thead>
            <tr>
              <th>Image</th>
              <th>Name</th>
              <th>Stock</th>
              <th>Price</th>
              <th>Brands</th>
              <th>Product Description</th>
              <th>Created At</th>
              <th>Updated At</th>
              <th>Quantity</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="product" items="${products}">
              <tr>
                <td><img src="${pageContext.request.contextPath}${product.productImage}" alt="${product.productName}"/></td>
                <td>${product.productName}</td>
                <td>${product.stock}</td>
                <td>$ ${product.price}</td>
                <td>${product.brand}</td>
                <td>${product.productDescription}</td>
                <td>${product.createdAt}</td>
                <td>${product.updatedAt}</td>
                <td>${product.quantity}</td>
                <td>
                  <form action="${pageContext.request.contextPath}/product" method="get">
                    <input type="hidden" name="formSubmit" value="editProduct">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <button type="submit">Edit</button>
                  </form>
                  <form id="removeForm-${product.productId}" action="${pageContext.request.contextPath}/product" method="post">
                    <input type="hidden" name="formSubmit" value="removeProduct">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <button type="button" onclick="confirmDelete('${product.productName}', 'removeForm-${product.productId}')">Remove</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </main>
  </div>
</body>
</html>