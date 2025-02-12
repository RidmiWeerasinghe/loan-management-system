package com.openarc.trialcal.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ln_trial_calculation")
public class TrialCalculation {
	@Id
	@GeneratedValue
	@Column(name = "TC_ID")
	private int trialCalculationId;
	
	@Column(name="TC_NO")
	private String trialCalculationNumber;
	
	@Column(name = "STK_ID")
	private int stakeholderId;
	
	@Column(name = "CAPITAL")
	private double capitalAmount;
	
	@Column(name = "INTEREST_RATE")
	private double interestRate;
	
	@Column(name = "NO_OF_MONTHS")
	private int noOfMonth;
	
	@Column(name = "EMI")
	private double emi;
	
	@Column(name = "TIMESTAMP")
	private Timestamp timestamp;

	public int getTrialCalculationId() {
		return trialCalculationId;
	}

	public void setTrialCalculationId(int trialCalculationId) {
		this.trialCalculationId = trialCalculationId;
	}

	public String getTrialCalculationNumber() {
		return trialCalculationNumber;
	}

	public void setTrialCalculationNumber(String trialCalculationNumber) {
		this.trialCalculationNumber = trialCalculationNumber;
	}

	public int getStakeholderId() {
		return stakeholderId;
	}

	public void setStakeholderId(int stakeholderId) {
		this.stakeholderId = stakeholderId;
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

}
