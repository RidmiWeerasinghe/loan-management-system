package com.openarc.trialcal.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "CP_USER_GROUP")
public class UserGroup {

	@Id
	@GeneratedValue
	@Column(name = "GROUP_ID")
	private int groupId;

	@Column(name = "GROUP_CODE")
	private String groupCode;

	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "ACCESS_PAGES")
	private String accessModules;

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAccessModules() {
		return accessModules;
	}

	public void setAccessModules(String accessModules) {
		this.accessModules = accessModules;
	}
}
