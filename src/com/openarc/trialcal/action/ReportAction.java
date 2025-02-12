package com.openarc.trialcal.action;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.ReportGen;
import com.openarc.trialcal.dto.Stakeholder;
import com.openarc.trialcal.dto.StakeholderApplicationReportDTO;
import com.openarc.trialcal.dto.StakeholderReportDTO;
import com.openarc.trialcal.dto.StakeholderTrialCalculationReportDTO;
import com.openarc.trialcal.dto.TrialCalculation;
import com.openarc.trialcal.dto.User;
import com.opensymphony.xwork2.ActionSupport;

public class ReportAction extends ActionSupport {
	private TrialCalBDImpl trialCalBDImpl;
	private ReportGen reportGen;
	private User user;
	private Map<String, Object> result = new HashMap<>();

	public String generateReport() {
		System.out.println("getReportCategoryId");
		System.out.println(reportGen.getReportCategoryId());
		Map<String, Object> generatedReport = new HashMap<String, Object>();
		String fromDate = reportGen.getFromDate();
		String toDate = reportGen.getToDate();
		int stakeholderId = reportGen.getStakeholderId();
		Date sqlFromDate = null;
		Date sqlToDate = null;
		if (fromDate != null && toDate != null) {
			sqlFromDate = dateStringToSQLDate(fromDate);
			sqlToDate = dateStringToSQLDate(toDate);
		}

		switch (reportGen.getReportCategoryId()) {
		case 1:
			ArrayList<StakeholderReportDTO> stakeholderReportDTOs = trialCalBDImpl.generateStakeHolderReport(sqlFromDate, sqlToDate);
			if (stakeholderReportDTOs != null) {
				generatedReport.put("report", stakeholderReportDTOs);
			}
			break;
		case 3:
			ArrayList<TrialCalculation> trialCalculations = trialCalBDImpl.generateTrialCalculationReport(sqlFromDate, sqlToDate);
			if (trialCalculations != null) {
				generatedReport.put("report", trialCalculations);
			}
			break;
		case 2:

			break;
		case 4:

			break;
		case 5:
			ArrayList<StakeholderTrialCalculationReportDTO> stakeholderTrialCalculationReportDTOs = trialCalBDImpl.generateStakeHolderTrialCalculationsReport(stakeholderId);
			if (!stakeholderTrialCalculationReportDTOs.isEmpty()) {
				generatedReport.put("tc", stakeholderTrialCalculationReportDTOs);
			}
			break;
		case 6:
			System.out.println("case 6");
			ArrayList<StakeholderApplicationReportDTO> stakeholderApplicationReportDTOs = trialCalBDImpl.generateStakeHolderApplicationsReport(stakeholderId);
			if (stakeholderApplicationReportDTOs != null) {
				generatedReport.put("tc", stakeholderApplicationReportDTOs);
			}
			break;
		default:
			break;
		}
		if (generatedReport.size() != 0) {
			System.out.println("length");
			System.out.println(generatedReport.size());
			result.put("report", generatedReport);
			result.put("success", true);
			result.put("error", null);
			result.put("successmsg", "Report generated successfully !");
			return SUCCESS;
		}
		result.put("success", false);
		result.put("successmsg", "");
		result.put("error", "No data available to generate report");
		return ERROR;
	}

	public Date dateStringToSQLDate(String dateString) {
		LocalDate localDate = LocalDate.parse(dateString);
		Date sqlDate = Date.valueOf(localDate);
		return sqlDate;

	}

	public String test() {
		System.out.println("test");
		System.out.println("getReportCategoryId");
		if (reportGen != null) {
			System.out.println(reportGen.getReportCategoryId());
			result.put("successmsg", "success");
			return SUCCESS;
		} else {
			System.out.println("dsd");
			result.put("error", "faild");
			return SUCCESS;
		}
	}


	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

	public ReportGen getReportGen() {
		return reportGen;
	}

	public void setReportGen(ReportGen reportGen) {
		this.reportGen = reportGen;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
