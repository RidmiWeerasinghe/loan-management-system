package com.openarc.trialcal.dto;

import java.sql.Timestamp;


public class LoanApplication {
	private int applicationId;
	
	private String applicationNumber;
	
	private int trialCalculationId;
	
	private int stakeholderId;
	
	private String applicationStatus;
	
	private int createdUserId;
	
	private int approvedUserId;

	private Timestamp createdTimestamp;
	
	private Timestamp approvedTimestamp;
	
	public int getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(int applicationId) {
		this.applicationId = applicationId;
	}

	public String getApplicationNumber() {
		return applicationNumber;
	}

	public void setApplicationNumber(String applicationNumber) {
		this.applicationNumber = applicationNumber;
	}

	public int getTrialCalculationId() {
		return trialCalculationId;
	}

	public void setTrialCalculationId(int trialCalculationId) {
		this.trialCalculationId = trialCalculationId;
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

	public int getApprovedUserId() {
		return approvedUserId;
	}

	public void setApprovedUserId(int approvedUserId) {
		this.approvedUserId = approvedUserId;
	}

	public int getStakeholderId() {
		return stakeholderId;
	}

	public void setStakeholderId(int stakeholderId) {
		this.stakeholderId = stakeholderId;
	}

	public Timestamp getCreatedTimestamp() {
		return createdTimestamp;
	}

	public void setCreatedTimestamp(Timestamp createdTimestamp) {
		this.createdTimestamp = createdTimestamp;
	}

	public Timestamp getApprovedTimestamp() {
		return approvedTimestamp;
	}

	public void setApprovedTimestamp(Timestamp approvedTimestamp) {
		this.approvedTimestamp = approvedTimestamp;
	}
}
