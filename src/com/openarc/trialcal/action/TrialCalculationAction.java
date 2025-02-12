package com.openarc.trialcal.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.TrialCalculation;
import com.opensymphony.xwork2.ActionSupport;

public class TrialCalculationAction extends ActionSupport {
	private TrialCalBDImpl trialCalBDImpl;
	private TrialCalculation trialCalculation;
	private Map<String, Object> result = new HashMap<>();

	public String createTrialCalculation() {
		System.out.println("createTrialCalculation");
		TrialCalculation trialCalculationFromDb = trialCalBDImpl.createTrialCalculation(trialCalculation);
		if (trialCalculationFromDb != null) {
			//generate the schedule and save in database
			ArrayList<HashMap<String, Double>>generatedSchedule = trialCalBDImpl.generateSchedule(trialCalculationFromDb);
			trialCalBDImpl.saveSchedule(generatedSchedule, trialCalculationFromDb.getTrialCalculationId());
			
			result.put("successmsg", "Trial calculation saved successfully!");
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to save trial calculation");
		return ERROR;
	}

	public String getTrialCalculationById() {
		if (trialCalculation == null) {
			return ERROR;
		}
		TrialCalculation trialCalculationFromDb = trialCalBDImpl
				.getTrialCalculationById(trialCalculation.getTrialCalculationId());
		if (trialCalculationFromDb != null) {
			result.put("trialCalculation", trialCalculationFromDb);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("trialCalculation", null);
		result.put("success", false);
		return ERROR;
	}

	//get all trial cals without applications
	public String getAllTrialCalculations() {
		List<TrialCalculation> trialCalculations = trialCalBDImpl.getAllTrialCalculations();
		if (!trialCalculations.isEmpty()) {
			result.put("trialCalculationsWithoutApplications", trialCalculations);
			result.put("error", null);
			return SUCCESS;
		}
		// result.put("error", "No trial calculations are available");
		result.put("trialCalculationsWithoutApplications", null);
		return ERROR;
	}

	public String getAllTrialCalculationsByStakeHolderId() {
		if (trialCalculation == null) {
			result.put("trialCalculations", null);
			return ERROR;
		}
		List<TrialCalculation> trialCalculations = trialCalBDImpl
				.getAllTrialCalculationsByStakeHolderId(trialCalculation.getStakeholderId());
		if (!trialCalculations.isEmpty()) {
			result.put("trialCalculations", trialCalculations);
			result.put("error", null);
			return SUCCESS;
		}
		//result.put("error", "No trial calculations are available for given stakeholder  id");
		result.put("trialCalculations", null);
		return ERROR;
	}

	public String updateTrialCalculation() {
		if (trialCalBDImpl.updateTrialCalculation(trialCalculation)) {
			result.put("success", true);
			result.put("error", null);
			result.put("successmsg", "Trial Calculation updated successfully!");
			return SUCCESS;
		}
		result.put("error", "Failed to update");
		return ERROR;
	}

	public String getAllTrialCalculationsWithoutApplicationsByStakeHolderId() {
		if (trialCalculation == null) {
			result.put("trialCalculations", null);
			return ERROR;
		}
		List<TrialCalculation> trialCalculations = trialCalBDImpl
				.getAllTrialCalculationsWithoutApplicationsByStakeHolderId(trialCalculation.getStakeholderId());
		if (!trialCalculations.isEmpty()) {
			result.put("trialCalculations", trialCalculations);
			result.put("error", null);
			return SUCCESS;
		}
		//result.put("error", "No trial calculations are available for given stakeholder  id");
		result.put("trialCalculations", null);
		return ERROR;
	}
	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public TrialCalculation getTrialCalculation() {
		return trialCalculation;
	}

	public void setTrialCalculation(TrialCalculation trialCalculation) {
		this.trialCalculation = trialCalculation;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

}
