package com.scentedbliss.model;
import java.time.LocalDate;

public class UserModel {
	private int userId;
	private String firstName;
	private String lastName;
	private String address;
	private String email;
	private String phoneNumber;
	private String gender;
	private String username;
	private String password;
	private LocalDate dob;
	private String role;
	private String imageUrl;

	
	public UserModel() {}
	

	
	public UserModel(String username, String password) {
        this.username = username;
        this.password = password;
    }
	
	
	public UserModel( int userId, String firstName, String lastName, String address, String email, String phoneNumber, String gender,
			String username, String password, LocalDate dob, String role, String imageUrl) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.gender = gender;
		this.username = username;
		this.password = password;
		this.dob = dob;
		this.role = role;
		this.imageUrl = imageUrl;
	}
	
	public UserModel(  String firstName, String lastName, String address, String email, String phoneNumber, String gender,
			String username, String password, LocalDate dob, String role, String imageUrl) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.gender = gender;
		this.username = username;
		this.password = password;
		this.dob = dob;
		this.role = role;
		this.imageUrl = imageUrl;
	}



	public int getUserId() {
		return userId;
	}



	public void setUserId(int userId) {
		this.userId = userId;
	}



	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhoneNumber() {
		return phoneNumber;
	}


	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public LocalDate getDob() {
		return dob;
	}


	public void setDob(LocalDate dob) {
		this.dob = dob;
	}


	


	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getImageUrl() {
		return imageUrl;
	}


	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	
	
	
	
	
	

	








	

}
