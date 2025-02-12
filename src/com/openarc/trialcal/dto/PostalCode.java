package com.openarc.trialcal.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="cp_postal_code")
public class PostalCode {
	@Id
	@GeneratedValue
	@Column(name="PSTC_ID")
	private int postalCodeId;
	
	@Column(name="PSTC")
	private String postalCode;
	
	@Column(name="CITY")
	private String city;

	public int getPostalCodeId() {
		return postalCodeId;
	}

	public void setPostalCodeId(int postalCodeId) {
		this.postalCodeId = postalCodeId;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
	
	
}
