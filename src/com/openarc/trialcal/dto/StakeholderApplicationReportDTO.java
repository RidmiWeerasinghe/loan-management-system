package com.openarc.trialcal.dto;

import java.sql.Timestamp;

import javax.persistence.Column;

public class StakeholderApplicationReportDTO {
	
	private String applicationNumber;

	private String applicationStatus;

	private int createdUserId;

	private Timestamp createdTimestamp;

	private String trialCalculationNumber;

	private double capitalAmount;

	private double interestRate;

	private int noOfMonth;

	private double emi;

	public String getApplicationNumber() {
		return applicationNumber;
	}

	public void setApplicationNumber(String applicationNumber) {
		this.applicationNumber = applicationNumber;
	}

	public String getApplicationStatus() {
		return applicationStatus;
	}

	public void setApplicationStatus(String applicationStatus) {
		this.applicationStatus = applicationStatus;
	}

	public int getCreatedUserId() {
		return createdUserId;
	}

	public void setCreatedUserId(int createdUserId) {
		this.createdUserId = createdUserId;
	}

	public Timestamp getCreatedTimestamp() {
		return createdTimestamp;
	}

	public void setCreatedTimestamp(Timestamp createdTimestamp) {
		this.createdTimestamp = createdTimestamp;
	}

	public String getTrialCalculationNumber() {
		return trialCalculationNumber;
	}

	public void setTrialCalculationNumber(String trialCalculationNumber) {
		this.trialCalculationNumber = trialCalculationNumber;
	}

	public double getCapitalAmount() {
		return capitalAmount;
	}

	public void setCapitalAmount(double capitalAmount) {
		this.capitalAmount = capitalAmount;
	}

	public double getInterestRate() {
		return interestRate;
	}

	public void setInterestRate(double interestRate) {
		this.interestRate = interestRate;
	}

	public int getNoOfMonth() {
		return noOfMonth;
	}

	public void setNoOfMonth(int noOfMonth) {
		this.noOfMonth = noOfMonth;
	}

	public double getEmi() {
		return emi;
	}

	public void setEmi(double emi) {
		this.emi = emi;
	}

	
}
