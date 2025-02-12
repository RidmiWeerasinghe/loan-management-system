package com.openarc.trialcal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.Application;
import com.openarc.trialcal.dto.LoanApplication;
import com.openarc.trialcal.dto.TrialCalculation;
import com.openarc.trialcal.dto.User;
import com.opensymphony.xwork2.ActionSupport;

public class ApplicationAction extends ActionSupport implements SessionAware{
	private TrialCalBDImpl trialCalBDImpl;
	private Application application;
	private LoanApplication loanApplication;
	private Map<String, Object> result = new HashMap<>();
	private Map<String, Object> session;

	public String createApplication() {
		User currentUser = (User) session.get("currentUser");
		Application application = new Application();
		application.setStakeholderId(loanApplication.getStakeholderId());
		application.setTrialCalculationId(loanApplication.getTrialCalculationId());
		application.setCreatedUserId(currentUser.getUserId());
		Application applicationFromDb = trialCalBDImpl.createApplication(application);
		if (applicationFromDb != null) {
			result.put("applicationNumber", applicationFromDb.getApplicationNumber());
			result.put("successmsg", "Application created successfully!");
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to create application");
		result.put("success", false);
		return ERROR;
	}

	public String updateApplication() {
		if (trialCalBDImpl.updateApplication(application)) {
			result.put("success", true);
			result.put("successmsg", "Application updated successfully!");
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to update");
		result.put("success", false);
		return ERROR;
	}

	public String getAllPendingApplication() {
		List<Application> applications = trialCalBDImpl.getAllPendingApplications();
		if (!applications.isEmpty()) {
			result.put("applications", applications);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		// result.put("error", "No pending applications are available");
		result.put("applications", null);
		result.put("success", false);
		return ERROR;
	}

	public String getApplicationByApplicationId() {
		if (loanApplication == null) {
			result.put("success", false);
			result.put("application", null);
			return ERROR;
		}
		Application application = new Application();
		application.setApplicationId(loanApplication.getApplicationId());
		Application applicationFromDb = trialCalBDImpl.getApplicationById(application.getApplicationId());
		if (applicationFromDb != null) {
			result.put("application", applicationFromDb);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("application", null);
		result.put("success", false);
		return ERROR;
	}

	public String updateApplicationStatus() {
		if (loanApplication == null) {
			result.put("success", false);
			return ERROR;
		}
		User currentUser = (User) session.get("currentUser");
		String string = loanApplication.getApplicationStatus();
		System.out.println("currentUser.getUserId() : "+ currentUser.getUserId());
		int userId = 0;
		switch (string) {
		case "A":
			string = "Approved";
			break;
		case "R":
			string = "Rejected";
			break;
		case "C":
			string = "Cancelled";
			break;
		default:
			break;
		}
		if (trialCalBDImpl.updateApplicationStatus(loanApplication.getApplicationId(),loanApplication.getApplicationStatus(),currentUser.getUserId())) {
			result.put("success", true);
			result.put("error", null);
			result.put("successmsg", "Application is "+ string +" successfully!");
			return SUCCESS;
		}
		result.put("error", "Failed to update");
		result.put("success", false);
		return ERROR;
	}

	public String getAllApplications() {
		List<Application> applications = trialCalBDImpl.getAllApplications();
		if (!applications.isEmpty()) {
			result.put("allapplications", applications);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		// result.put("error", "No pending applications are available");
		result.put("allapplications", null);
		result.put("success", false);
		return ERROR;
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

	public Application getApplication() {
		return application;
	}

	public void setApplication(Application application) {
		this.application = application;
	}

	public LoanApplication getLoanApplication() {
		return loanApplication;
	}

	public void setLoanApplication(LoanApplication loanApplication) {
		this.loanApplication = loanApplication;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
