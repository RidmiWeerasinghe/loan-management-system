package com.openarc.trialcal.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cp_stakeholder")
public class Stakeholder {
	@Id
	@GeneratedValue
	@Column(name="STK_ID")
	private int stakeholderId;
	
	@Column(name="NIC")
	private String nic;
	
	@Column(name = "F_NAME")
	private String firstName;
	
	@Column(name = "L_NAME")
	private String lastName;
	
	@Column(name = "FULL_NAME")
	private String fullName;
	
	@Column(name = "DOB")
	private String dateOfBirth;
	
	@Column(name = "GENDER")
	private String gender;
	
	@Column(name="PHONE")
	private String phone;
	
	@Column(name="EMAIL")
	private String email;
	
	@Column(name="OCCUPATION")
	private String occupation;
	
	@Column(name = "ADD_ID")
	private int addressId;
	
	@Column(name = "REGISTERED_DATE")
	private Date registeredDate;

	public int getStakeholderId() {
		return stakeholderId;
	}

	public void setStakeholderId(int stakeholderId) {
		this.stakeholderId = stakeholderId;
	}

	public String getNic() {
		return nic;
	}

	public void setNic(String nic) {
		this.nic = nic;
	}

	public String getNIC() {
		return nic;
	}

	public void setNIC(String nic) {
		 this.nic = nic;
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

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public Date getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(Date registeredDate) {
		this.registeredDate = registeredDate;
	}

	
}
