package com.openarc.trialcal.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.openarc.trialcal.bd.impl.TrialCalBDImpl;
import com.openarc.trialcal.dto.Schedule;
import com.opensymphony.xwork2.ActionSupport;

public class ScheduleAction extends ActionSupport {
	private TrialCalBDImpl trialCalBDImpl;
	private Schedule schedule;
	private List<Schedule> scheduleData;
	private Map<String, Object> result = new HashMap<>();

	public String saveSchedule(){
		/*System.out.println("size : "+scheduleData.size());
		result.put("scheduleData", scheduleData);*/
		return ERROR;
	}
	
	public List<Schedule> getScheduleData() {
		return scheduleData;
	}
	public void setScheduleData(List<Schedule> scheduleData) {
		this.scheduleData = scheduleData;
	}

	public TrialCalBDImpl getTrialCalBDImpl() {
		return trialCalBDImpl;
	}

	public void setTrialCalBDImpl(TrialCalBDImpl trialCalBDImpl) {
		this.trialCalBDImpl = trialCalBDImpl;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public Map<String, Object> getResult() {
		return result;
	}

	public void setResult(Map<String, Object> result) {
		this.result = result;
	}

}
