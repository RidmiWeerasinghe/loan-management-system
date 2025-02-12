package com.openarc.trialcal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.Address;
import com.openarc.trialcal.dto.PostalCode;
import com.openarc.trialcal.dto.Stakeholder;
import com.openarc.trialcal.dto.User;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.xml.internal.bind.v2.model.core.ID;

public class StakeholderAction extends ActionSupport {
	private TrialCalBDImpl trialCalBDImpl;
	private Stakeholder stakeholder;
	private Address address;
	private Map<String, Object> result = new HashMap<>();

	public String createStakeholder() {
		List<Stakeholder> stakeholders = trialCalBDImpl.getAllStakeHolders();
		if (!stakeholders.isEmpty()) {
			for (Stakeholder stk : stakeholders) {
				if (stk.getNIC().equals(stakeholder.getNIC())) {
					result.put("error", "Stakeholder with same NIC already exists !");
					result.put("success", false);
					return ERROR;
				}
			}
		}
		int addressId = trialCalBDImpl.createAddress(address).getAddressId();
		stakeholder.setAddressId(addressId);
		Stakeholder stakeholderFromDb = trialCalBDImpl.createStakeholder(stakeholder);
		if (stakeholderFromDb != null) {
			result.put("successmsg", "Stakeholder created successfully!");
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to create stakeholder");
		result.put("success", false);
		return ERROR;
	}

	public String updateStakeholder() {
		Stakeholder stakeholderFromDb = trialCalBDImpl.getStakeholderById(stakeholder.getStakeholderId());
		stakeholder.setRegisteredDate(stakeholderFromDb.getRegisteredDate());
		if (trialCalBDImpl.updateStakeholder(stakeholder)) {
			if (trialCalBDImpl.updateAddress(address)) {
				result.put("success", true);
				result.put("error", null);
				result.put("successmsg", "Stakeholder updated successfully!");
				return SUCCESS;
			}
			result.put("success", false);
			result.put("error", "Stakeholder address update failed !");
			return ERROR;
		}
		result.put("error", "Failed to update");
		result.put("success", false);
		return ERROR;
	}

	public String getAllStakeholders() {
		List<Stakeholder> stakeholders = trialCalBDImpl.getAllStakeHolders();
		if (!stakeholders.isEmpty()) {
			result.put("stakeholders", stakeholders);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		//result.put("error", "No stakeholders are available");
		result.put("success", false);
		return ERROR;
	}

	public String getAllPostalCodes() {
		List<PostalCode> postalCodes = trialCalBDImpl.getAllPostalCodes();
		if (!postalCodes.isEmpty()) {
			result.put("postalCodes", postalCodes);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "No postalcodes are available");
		result.put("success", false);
		return ERROR;
	}

	public String getAddressByAddressId() {
		if (address != null) {
			Address addressFromdb = trialCalBDImpl.getAddressByAddressId(address.getAddressId());
			if (addressFromdb != null) {
				result.put("success", true);
				result.put("error", null);
				result.put("address", addressFromdb);
				return SUCCESS;
			}
		}
		//result.put("error", "Failed to load address");
		result.put("success", false);
		return ERROR;
	}

	public String getStakeholderByStakeholderId() {
		if (stakeholder != null) {
			Stakeholder stakeholderFromdb = trialCalBDImpl.getStakeholderById(stakeholder.getStakeholderId());
			if (stakeholderFromdb != null) {
				result.put("success", true);
				result.put("error", null);
				result.put("stakeholder", stakeholderFromdb);
				return SUCCESS;
			}
		}
		//result.put("error", "Failed to load address");
		result.put("success", false);
		return ERROR;
	}
	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public Stakeholder getStakeholder() {
		return stakeholder;
	}

	public void setStakeholder(Stakeholder stakeholder) {
		this.stakeholder = stakeholder;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

}
