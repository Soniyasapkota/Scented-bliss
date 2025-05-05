<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${isEdit ? 'Edit Product' : 'Add Product'}</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
</head>
<body>
<div class="container_img">
    <div class="image-section">
        <h1>${isEdit ? 'Edit Product' : 'Add a New Product'}</h1>
        <h3>${isEdit ? 'Update your fragrance details!' : 'Expand your fragrance collection!'}</h3>
    </div>
    
    <div class="container">
        <h2>Product Form</h2>
        
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
        
        <c:if test="${not empty success}">
            <p class="success-message">${success}</p>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/product" method="post" enctype="multipart/form-data">
            <input type="hidden" name="formSubmit" value="${isEdit ? 'editProduct' : 'addProduct'}">
            <c:if test="${isEdit}">
                <input type="hidden" name="productId" value="${product.productId}">
            </c:if>
            <div class="row">
                <div class="col">
                    <label for="productName">Product Name:</label>
                    <input type="text" id="productName" name="productName" value="${product != null ? product.productName : productName}" required>
                </div>
                <div class="col">
                    <label for="productDescription">Description:</label>
                    <textarea id="productDescription" name="productDescription" required>${product != null ? product.productDescription : productDescription}</textarea>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <label for="price">Price:</label>
                    <input type="number" step="0.01" id="price" name="price" value="${product != null ? product.price : price}" required>
                </div>
                <div class="col">
                    <label for="stock">Stock:</label>
                    <input type="number" id="stock" name="stock" value="${product != null ? product.stock : stock}" required>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity" value="${product != null ? product.quantity : quantity}" required>
                </div>
                <div class="col">
                    <label for="brand">Brand:</label>
                    <input type="text" id="brand" name="brand" value="${product != null ? product.brand : brand}" required>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <label for="productImage">Product Image:</label>
                    <input type="file" id="productImage" name="productImage" accept="image/*">
                    <c:if test="${isEdit && product.productImage != null}">
                        <p>Current Image: <img src="${pageContext.request.contextPath}${product.productImage}" alt="Current Image" style="max-width: 100px;"/></p>
                    </c:if>
                </div>
                <div class="col">
                    <label for="createdAt">Created At:</label>
                    <input type="datetime-local" id="createdAt" name="createdAt" value="${product != null ? product.createdAt.replace(' ', 'T') : createdAt}" required>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <label for="updatedAt">Updated At:</label>
                    <input type="datetime-local" id="updatedAt" name="updatedAt" value="${product != null ? product.updatedAt.replace(' ', 'T') : updatedAt}" required>
                </div>
            </div>
            <button type="submit">${isEdit ? 'Update Product' : 'Add Product'}</button>
        </form>
        <a href="${pageContext.request.contextPath}/product" class="back-button">Back to Product List</a>
    </div>
</div>
</body>
</html>