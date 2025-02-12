package com.openarc.trialcal.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.User;
import com.openarc.trialcal.dto.UserGroup;
import com.opensymphony.xwork2.ActionSupport;

public class AdminAction extends ActionSupport {
	private TrialCalBDImpl trialCalBDImpl;
	private UserGroup userGroup;
	private Map<String, Object> result = new HashMap<>();

	public HashMap<String, String> validations() {
		// clearFieldErrors();
		HashMap<String, String> validationErrors = new HashMap<>();
		if (userGroup != null && userGroup.getGroupCode() != null) {
			if (!userGroup.getGroupCode().matches("[a-zA-Z]+")) {
				validationErrors.put("groupCode-error", "Group code can not contain numbers or special characters");
			}
			if (userGroup.getGroupCode().length() != 3) {
				validationErrors.put("groupCode-error", "Group code must contain 3 characters");
			}
		}
		if (userGroup != null && userGroup.getDescription() != null) {
			if (!userGroup.getDescription().matches("[a-zA-Z0-9 ]+")) {
				validationErrors.put("groupDescription-error", "Description can not contain special characters");
			}
		}
		// result.put("success", false);
		// addFieldError("errors", "true");
		// result.put("validationErrors", validationErrors);
		return validationErrors;
	}

	public String createUserGroup() {
		HashMap<String, String> validationErrors = validations();
		if (!validationErrors.isEmpty()) {
			result.put("success", false);
			result.put("validationErrors", validationErrors);
			return ERROR;
		}
		List<UserGroup> userGroups = trialCalBDImpl.getAllUserGroups();
		if (!userGroups.isEmpty()) {
			for (UserGroup ug : userGroups) {
				if (ug.getGroupCode().equals(userGroup.getGroupCode())) {
					result.put("error", "Group code already exists !");
					result.put("success", false);
					return ERROR;
				}
			}
		}
		UserGroup userGroupFromDb = trialCalBDImpl.createUserGroup(userGroup);
		if (userGroupFromDb != null) {
			result.put("successmsg", "User Group created successfully!");
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to create user group");
		result.put("success", false);
		return ERROR;
	}

	public String getAllUserGroups() {
		List<UserGroup> userGroups = trialCalBDImpl.getAllUserGroups();
		if (!userGroups.isEmpty()) {
			result.put("usergroups", userGroups);
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		//result.put("error", "No user groups are available");
		result.put("success", false);
		return ERROR;
	}

	public String updateUserGroup() {
		HashMap<String, String> validationErrors = validations();
		if (!validationErrors.isEmpty()) {
			result.put("success", false);
			result.put("validationErrors", validationErrors);
			return ERROR;
		}
		if (trialCalBDImpl.updateUserGroup(userGroup)) {
			result.put("success", true);
			result.put("error", null);
			result.put("successmsg", "User Group updated successfully!");
			return SUCCESS;
		}
		result.put("error", "Failed to update");
		result.put("success", false);
		return ERROR;
	}

	public String getAllUsers() {
		List<User> users = trialCalBDImpl.getAllUsers();
		if (!users.isEmpty()) {
			result.put("users", users);
			result.put("success", true);
			result.put("error", null);
			result.put("errorrr", null);
			return SUCCESS;
		}
		// result.put("error", "No users are available");
		result.put("success", false);
		return ERROR;
	}
	
	public String getUserGroupById() {
		/*
		 * UserGroup userGroupFromDb =
		 * trialCalBDImpl.getUserGroupById(userGroup.getGroupId()); if
		 * (userGroupFromDb != null) { result.put("userGroup", userGroupFromDb);
		 * result.put("success", true); return SUCCESS; } result.put("success",
		 * false);
		 */
		return ERROR;
	}

	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public UserGroup getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

}
