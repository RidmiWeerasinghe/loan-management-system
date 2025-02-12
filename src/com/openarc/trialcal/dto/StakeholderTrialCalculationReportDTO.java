package com.openarc.trialcal.dto;

import java.sql.Date;
import java.sql.Timestamp;

import javax.persistence.Column;

public class StakeholderTrialCalculationReportDTO {
	private String trialCalculationNumber;
	
	private double capitalAmount;

	private double interestRate;

	private int noOfMonth;

	private double emi;

	private Timestamp timestamp;

	private String applicationSts;

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

	public Timestamp getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public String getApplicationSts() {
		return applicationSts;
	}

	public void setApplicationSts(String applicationSts) {
		this.applicationSts = applicationSts;
	}
	
	
}
