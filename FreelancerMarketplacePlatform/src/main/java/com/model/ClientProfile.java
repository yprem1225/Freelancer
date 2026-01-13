package com.model;

public class ClientProfile {
	private int id;
	private String name;
	private String email;
	private String role;
	
	private String phone;
	private String companyname;
	private String companubio;
	private String completedprofile;
	
	public void setCompletedprofile(String completedprofile) {
		this.completedprofile = completedprofile;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getCompanubio() {
		return companubio;
	}
	public void setCompanubio(String companubio) {
		this.companubio = companubio;
	}
	public String getCompletedprofile() {
		return completedprofile;
	}
	

}
