package com.openarc.trialcal.dto;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ln_schedule")
public class Schedule {
	@Id
	@GeneratedValue
	@Column(name = "ID")
	private int Id;

	@Column(name = "TC_ID")
	private int trialCalculationId;
	
	@Column(name = "EMI_NO")
	private int emiNo;
	
	@Column(name = "INSTALLMENT")
	private double installment;
	
	@Column(name = "INTEREST")
	private double interest;
	
	@Column(name = "CAPITAL")
	private double capital;
	
	@Column(name = "CAPITAL_BLNC")
	private double capitalBalance;

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getTrialCalculationId() {
		return trialCalculationId;
	}

	public void setTrialCalculationId(int trialCalculationId) {
		this.trialCalculationId = trialCalculationId;
	}

	public int getEmiNo() {
		return emiNo;
	}

	public void setEmiNo(int emiNo) {
		this.emiNo = emiNo;
	}

	public double getInstallment() {
		return installment;
	}

	public void setInstallment(double installment) {
		this.installment = installment;
	}

	public double getInterest() {
		return interest;
	}

	public void setInterest(double interest) {
		this.interest = interest;
	}

	public double getCapital() {
		return capital;
	}

	public void setCapital(double capital) {
		this.capital = capital;
	}

	public double getCapitalBalance() {
		return capitalBalance;
	}

	public void setCapitalBalance(double capitalBalance) {
		this.capitalBalance = capitalBalance;
	}

	
}
