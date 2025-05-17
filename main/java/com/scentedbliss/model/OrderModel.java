package com.scentedbliss.model;

public class OrderModel {
    private int orderId;
    private String orderDate;
    private int userId;
    private String shippingAddress;
    private double totalAmount;

    // Constructors
    public OrderModel() {}
    public OrderModel(int orderId, String orderDate, int userId, String shippingAddress, double totalAmount) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.userId = userId;
        this.shippingAddress = shippingAddress;
        this.totalAmount = totalAmount;
    }
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getShippingAddress() {
		return shippingAddress;
	}
	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

   
}