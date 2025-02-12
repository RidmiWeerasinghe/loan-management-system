package com.openarc.trialcal.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cp_stakeholder_address")
public class Address {
	@Id
	@GeneratedValue
	@Column(name = "ADD_ID")
	private int addressId;

	@Column(name = "PSTC_ID")
	private int postalCodeId;

	@Column(name = "ADD_LINE_1")
	private String addressLine1;

	@Column(name = "ADD_LINE_2")
	private String addressLine2;

	@Column(name = "PROVINCE")
	private String province;

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public int getPostalCodeId() {
		return postalCodeId;
	}

	public void setPostalCodeId(int postalCodeId) {
		this.postalCodeId = postalCodeId;
	}

	public String getAddressLine1() {
		return addressLine1;
	}

	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}

	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

}
