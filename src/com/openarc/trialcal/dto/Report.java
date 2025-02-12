package com.openarc.trialcal.dto;

import java.util.Date;

public class Report {
	private int reportCategoryId;
	private String fromDate;
	private String toDate;

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

	
}

