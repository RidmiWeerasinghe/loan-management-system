package com.openarc.trialcal.dto;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ln_application")
public class Application {
	@Id
	@GeneratedValue
	@Column(name = "APP_ID")
	private int applicationId;
	
	@Column(name="APP_NO")
	private String applicationNumber;
	
	@Column(name = "TC_ID")
	private int trialCalculationId;
	
	@Column(name="STK_ID")
	private int stakeholderId;
	
	@Column(name = "APP_STS")
	private String applicationStatus;
	
	@Column(name = "CREATED_USER_ID")
	private int createdUserId;
	
	@Column(name = "APPROVED_USER_ID")
	private int approvedUserId;
	
	@Column(name = "REJECTED_USER_ID")
	private int rejectedUserId;

	@Column(name = "CRERATED_TIMESTAMP")
	private Timestamp createdTimestamp;
	
	@Column(name = "REJECTED_TIMESTAMP")
	private Timestamp rejectedTimestamp;
	
	@Column(name = "APPROVED_TIMESTAMP")
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

	public int getRejectedUserId() {
		return rejectedUserId;
	}

	public void setRejectedUserId(int rejectedUserId) {
		this.rejectedUserId = rejectedUserId;
	}

	public Timestamp getRejectedTimestamp() {
		return rejectedTimestamp;
	}

	public void setRejectedTimestamp(Timestamp rejectedTimestamp) {
		this.rejectedTimestamp = rejectedTimestamp;
	}
}
