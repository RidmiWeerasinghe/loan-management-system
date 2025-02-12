package com.openarc.trialcal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.User;
import com.openarc.trialcal.dto.UserGroup;
import com.openarc.trialcal.dto.UserHistory;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport implements SessionAware {
	private TrialCalBDImpl trialCalBDImpl;
	private User user;
	private String requestToken;
	private Map<String, Object> result = new HashMap<>();
	private Map<String, Object> session;

	public String createUser() {
		List<User> users = trialCalBDImpl.getAllUsers();
		if (!users.isEmpty()) {
			for (User u : users) {
				if (u.getUsername().equals(user.getUsername())) {
					result.put("error", "Username already exists !");
					result.put("success", false);
					return ERROR;
				}
			}
		}
		User userFromDb = trialCalBDImpl.createUser(user);
		if (userFromDb != null) {
			result.put("successmsg", "User created successfully!");
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Failed to create user");
		result.put("success", false);
		return ERROR;
	}

	public String updateUser() {
		if (trialCalBDImpl.updateUser(user)) {
			result.put("success", true);
			result.put("error", null);
			result.put("successmsg", "User updated successfully!");
			return SUCCESS;
		}
		result.put("error", "Failed to update");
		result.put("success", false);
		return ERROR;
	}

	public String login() {
		System.out.println("login");
		System.out.println(user.getUsername());
		User userFromDb = trialCalBDImpl.login(user);
		if (userFromDb != null) {
			System.out.println("not null");
			UserGroup currentUserGroup = trialCalBDImpl.getUserGroupById(userFromDb.getGroupId());
			List<UserHistory> currentUserHistories = trialCalBDImpl.getAllUserHistoryByUserId(userFromDb.getUserId());
			String currentUserAccessModules = currentUserGroup.getAccessModules();
			if (userFromDb.getStatus().equals("A")) {
				System.out.println("A");
				session.put("currentUser", userFromDb);
				session.put("currentUserAccessModules", currentUserAccessModules);
				session.put("currentUserHistories", currentUserHistories);
				result.put("success", true);
				result.put("error", null);
				result.put("successmsg", "Login Successfull !");
				result.put("currentUser", userFromDb);
				result.put("requestToken", requestToken);
				return SUCCESS;
			}
			System.out.println("D");
			result.put("success", false);
			result.put("error", "User Acount is diactivated, Contact the admin");
			return ERROR;
		}
		System.out.println("null");
		result.put("success", false);
		result.put("error", "Invalide Username or Password");
		return ERROR;
	}

	public String logout() {
		if (session != null) {
			session.remove("currentUser");
			session.clear();
		}
		result.clear();
		result.put("success", true);
		result.put("error", null);
		result.put("successmsg", "Logout successful!");
		return SUCCESS;
	}

	public String isOldPasswordCorrect() {
		String oldPassword = user.getPassword();
		System.out.println("oldPassword "+ oldPassword);
		User userFromDb = trialCalBDImpl.getUserByUserId(user.getUserId());
		if (oldPassword.equals(userFromDb.getPassword())) {
			result.put("success", true);
			result.put("error", null);
			return SUCCESS;
		}
		result.put("error", "Password is incorrect");
		return ERROR;
	}

	public boolean isNewPasswordValid(){
		if (user == null) {
			return false;
		}
		String newPassword = user.getPassword();
		List<UserHistory> userHistories = trialCalBDImpl.getAllUserHistoryByUserId(user.getUserId());
		for (UserHistory userHistory : userHistories) {
			if (userHistory.getPassword().equals(newPassword)) {
				return false;
			}
		}
		return true;
	}
	public String updatePassword() {
		int userId = user.getUserId();
		String newPassword = user.getPassword();
		String oldPasswordFromFrontEnd = user.getUsername();
		
		User userFromDb = trialCalBDImpl.getUserByUserId(userId);
		String oldPassword = userFromDb.getPassword();
		
		if (!oldPassword.equals(oldPasswordFromFrontEnd)) {
			result.put("success", false);
			result.put("error", "Current Password is incorrect");
			return ERROR;
		}
		
		UserHistory userHistory = new UserHistory();
		userHistory.setUserId(userId);
		userHistory.setPassword(oldPassword);
		
		if (newPassword != null && userId != 0) {
			
			if (!isNewPasswordValid()) {
				result.put("success", false);
				result.put("successmsg",null);
				result.put("error", "You have already used that password, try another");
				return ERROR;
			}
			if (trialCalBDImpl.updateUserPassword(userId, newPassword)) {
				trialCalBDImpl.saveOldPassword(userHistory);
				result.put("success", true);
				result.put("successmsg", "Password changed successfully!");
				result.put("error", null);
				return SUCCESS;
			}
		}
		result.put("success", false);
		result.put("successmsg",null);
		result.put("error", "Something went wrong !");
		return ERROR;
	}

	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public String getRequestToken() {
		return requestToken;
	}

	public void setRequestToken(String requestToken) {
		this.requestToken = requestToken;
	}

}
