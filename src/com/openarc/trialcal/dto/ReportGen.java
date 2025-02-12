package com.openarc.trialcal.dto;

import java.sql.Date;

public class ReportGen {
	private int reportCategoryId;
	private String fromDate;
	private String toDate;
	public int stakeholderId;

	public int getReportCategoryId() {
		return reportCategoryId;
	}

	public void setReportCategoryId(int reportCategoryId) {
		this.reportCategoryId = reportCategoryId;
	}

	public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public int getStakeholderId() {
		return stakeholderId;
	}

	public void setStakeholderId(int stakeholderId) {
		this.stakeholderId = stakeholderId;
	}


}
