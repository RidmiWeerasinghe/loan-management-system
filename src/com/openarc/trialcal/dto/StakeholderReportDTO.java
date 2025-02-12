package com.openarc.trialcal.dto;

import java.sql.Date;

import javax.persistence.Column;

public class StakeholderReportDTO {
	private int stakeholderId;
	
	private String nic;
	
	private String firstName;
	
	private String lastName;
	
	private String fullName;
	
	private String dateOfBirth;
	
	private String gender;
	
	private String phone;
	
	private String email;
	
	private String occupation;
	
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

	public Date getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(Date registeredDate) {
		this.registeredDate = registeredDate;
	}
	
	
}
