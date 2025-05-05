package com.scentedbliss.model;

public class ProductModel {
	private int cartId;
	private int productId;
    private String productName;
    private String productDescription;
    private double price;
    private int stock;
    private int quantity;
    private String brand;
    private String productImage;
    private String createdAt;
    private String updatedAt;

	public ProductModel() {
		// TODO Auto-generated constructor stub
	}
	

	public ProductModel(int cartId, int productId, String productName, String productDescription, double price, int stock,
			int quantity, String brand, String productImage, String createdAt, String updatedAt) {
		super();
		this.cartId = cartId;
		this.productId = productId;
		this.productName = productName;
		this.productDescription = productDescription;
		this.price = price;
		this.stock = stock;
		this.quantity = quantity;
		this.brand = brand;
		this.productImage = productImage;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	

	public int getCartId() {
		return cartId;
	}


	public void setCartId(int cartId) {
		this.cartId = cartId;
	}


	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public String getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
	

}
