package com.openarc.trialcal.bd.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import com.openarc.trialcal.bd.TrialCalBD;
import com.openarc.trialcal.dao.impl.TrialCalDAOImpl;
import com.openarc.trialcal.dto.Address;
import com.openarc.trialcal.dto.Application;
import com.openarc.trialcal.dto.PostalCode;
import com.openarc.trialcal.dto.Stakeholder;
import com.openarc.trialcal.dto.StakeholderApplicationReportDTO;
import com.openarc.trialcal.dto.StakeholderReportDTO;
import com.openarc.trialcal.dto.StakeholderTrialCalculationReportDTO;
import com.openarc.trialcal.dto.TrialCalculation;
import com.openarc.trialcal.dto.User;
import com.openarc.trialcal.dto.UserGroup;
import com.openarc.trialcal.dto.UserHistory;
import com.sun.swing.internal.plaf.synth.resources.synth_sv;

public class TrialCalBDImpl implements TrialCalBD {
	private TrialCalDAOImpl trialCalDAOImpl;

	public TrialCalDAOImpl getTrialCalDAOImpl() {
		return trialCalDAOImpl;
	}

	public void setTrialCalDAOImpl(TrialCalDAOImpl trialCalDAOImpl) {
		this.trialCalDAOImpl = trialCalDAOImpl;
	}

	@Override
	public UserGroup getUserGroupById(int groupId) {
		return trialCalDAOImpl.getUserGroupById(groupId);
	}

	/*
	 ***************************************************************************
	 * userGroups
	 ***************************************************************************
	 */
	@Override
	public UserGroup createUserGroup(UserGroup userGroup) {
		return trialCalDAOImpl.createUserGroup(userGroup);
	}

	@Override
	public List<UserGroup> getAllUserGroups() {
		return trialCalDAOImpl.getAllUserGroups();
	}

	@Override
	public boolean updateUserGroup(UserGroup userGroup) {
		return trialCalDAOImpl.updateUserGroup(userGroup);
	}

	/*
	 ***************************************************************************
	 * user
	 ***************************************************************************
	 */
	@Override
	public User createUser(User user) {
		return trialCalDAOImpl.createUser(user);
	}

	@Override
	public User login(User user){
		return trialCalDAOImpl.login(user);
	}
	@Override
	public List<User> getAllUsers() {
		return trialCalDAOImpl.getAllUsers();
	}

	@Override
	public boolean updateUser(User user) {
		return trialCalDAOImpl.updateUser(user);
	}

	@Override
	public boolean updateUserStatus(User user, String sts) {
		return trialCalDAOImpl.updateUserStatus(user, sts);
	}
	
	@Override
	public boolean updateUserPassword(int userId, String password){
		return trialCalDAOImpl.updateUserPassword(userId, password);
	}
	
	@Override
	public User getUserByUserId(int userId){
		return trialCalDAOImpl.getUserByUserId(userId);
	}

	/*
	 ***************************************************************************
	 * stakeholder
	 ***************************************************************************
	 */

	@Override
	public Stakeholder createStakeholder(Stakeholder stakeholder) {
		return trialCalDAOImpl.createStakeholder(stakeholder);
	}

	@Override
	public List<Stakeholder> getAllStakeHolders() {
		return trialCalDAOImpl.getAllStakeHolders();
	}

	@Override
	public boolean updateStakeholder(Stakeholder stakeholder) {
		return trialCalDAOImpl.updateStakeholder(stakeholder);
	}

	@Override
	public boolean deleteStakeholder(int id) {
		return trialCalDAOImpl.deleteStakeholder(id);
	}

	/*
	 ***************************************************************************
	 * stakeholder-address
	 ***************************************************************************
	 */

	@Override
	public Address createAddress(Address address) {
		return trialCalDAOImpl.createAddress(address);
	}

	@Override
	public Address getAddressByAddressId(int addressId) {
		return trialCalDAOImpl.getAddressByAddressId(addressId);
	}

	@Override
	public boolean updateAddress(Address address) {
		return trialCalDAOImpl.updateAddress(address);
	}

	@Override
	public boolean deleteAddress(int id) {
		return trialCalDAOImpl.deleteAddress(id);
	}

	@Override
	public Stakeholder getStakeholderById(int id) {
		return trialCalDAOImpl.getStakeholderById(id);
	}
	/*
	 ***************************************************************************
	 * postal-code
	 ***************************************************************************
	 */

	@Override
	public List<PostalCode> getAllPostalCodes() {
		return trialCalDAOImpl.getAllPostalCodes();
	}

	@Override
	public PostalCode getPostalCodeById(int postalCodeId) {
		return trialCalDAOImpl.getPostalCodeById(postalCodeId);
	}

	/*
	 ***************************************************************************
	 * trial calculation
	 ***************************************************************************
	 */
	@Override
	public TrialCalculation createTrialCalculation(TrialCalculation trialCalculation) {
		return trialCalDAOImpl.createTrialCalculation(trialCalculation);
	}

	@Override
	public TrialCalculation getTrialCalculationById(int id) {
		return trialCalDAOImpl.getTrialCalculationById(id);
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculations() {
		return trialCalDAOImpl.getAllTrialCalculations();
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsByStakeHolderId(int id) {
		return trialCalDAOImpl.getAllTrialCalculationsByStakeHolderId(id);
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsWithoutApplicationsByStakeHolderId(int id) {
		return trialCalDAOImpl.getAllTrialCalculationsWithoutApplicationsByStakeHolderId(id);
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsWithoutApplications(){
		return trialCalDAOImpl.getAllTrialCalculationsWithoutApplications();
	}
	@Override
	public boolean updateTrialCalculation(TrialCalculation trialCalculation) {
		return trialCalDAOImpl.updateTrialCalculation(trialCalculation);
	}

	@Override
	public boolean deleteTrialCalculation(int id) {
		return trialCalDAOImpl.deleteTrialCalculation(id);
	}

	/*
	 ***************************************************************************
	 * application
	 ***************************************************************************
	 */

	@Override
	public Application createApplication(Application application) {
		return trialCalDAOImpl.createApplication(application);
	}

	@Override
	public Application getApplicationById(int id) {
		return trialCalDAOImpl.getApplicationById(id);
	}

	@Override
	public List<Application> getAllApplications() {
		return trialCalDAOImpl.getAllApplications();
	}

	@Override
	public List<Application> getAllApplicationsByStakeHolderId(int id) {
		return trialCalDAOImpl.getAllApplicationsByStakeHolderId(id);
	}

	@Override
	public List<Application> getAllPendingApplications() {
		return trialCalDAOImpl.getAllPendingApplications();
	}

	@Override
	public boolean updateApplication(Application application) {
		return trialCalDAOImpl.updateApplication(application);
	}
	
	@Override
	public boolean updateApplicationStatus(int id , String sts, int userId){
		return trialCalDAOImpl.updateApplicationStatus(id, sts, userId);
	}

	@Override
	public boolean deleteApplication(int id) {
		return trialCalDAOImpl.deleteApplication(id);
	}

	/*
	 **************************************************************************
	 * User history
	 **************************************************************************
	 * */
	@Override
	public UserHistory saveOldPassword(UserHistory userHistory){
		return trialCalDAOImpl.saveOldPassword(userHistory);
	}

	@Override
	public List<UserHistory> getAllUserHistoryByUserId(int userId){
		return trialCalDAOImpl.getAllUserHistoryByUserId(userId);
	}
	
	/*
	 **************************************************************************
	 * Report
	 **************************************************************************
	 * */
	@Override
	public ArrayList<StakeholderReportDTO> generateStakeHolderReport(Date fromDate, Date toDate){
		ArrayList<Stakeholder> stakeholders = trialCalDAOImpl.generateStakeHolderReport(fromDate, toDate);
		if (stakeholders.isEmpty()) {
			return null;
		}
		ArrayList<StakeholderReportDTO> stakeholderReportDTOs = new ArrayList<>();
		
		for (Stakeholder stakeholder : stakeholders) {
			StakeholderReportDTO stakeholderReportDTO = new StakeholderReportDTO();
			stakeholderReportDTO.setStakeholderId(stakeholder.getStakeholderId());
			stakeholderReportDTO.setNic(stakeholder.getNic());
			stakeholderReportDTO.setFirstName(stakeholder.getFirstName());
			stakeholderReportDTO.setLastName(stakeholder.getLastName());
			stakeholderReportDTO.setFullName(stakeholder.getFullName());
			stakeholderReportDTO.setDateOfBirth(stakeholder.getDateOfBirth());
			stakeholderReportDTO.setEmail(stakeholder.getEmail());
			stakeholderReportDTO.setPhone(stakeholder.getPhone());
			stakeholderReportDTO.setOccupation(stakeholder.getOccupation());
			stakeholderReportDTO.setRegisteredDate(stakeholder.getRegisteredDate());
			stakeholderReportDTO.setGender(stakeholder.getGender());
			
			stakeholderReportDTOs.add(stakeholderReportDTO);
		}
		return stakeholderReportDTOs;
	}
	
	@Override
	public ArrayList<StakeholderTrialCalculationReportDTO> generateStakeHolderTrialCalculationsReport(int stakeholderId){
		ArrayList<TrialCalculation> trialCalculations = (ArrayList<TrialCalculation>) trialCalDAOImpl.getAllTrialCalculationsByStakeHolderId(stakeholderId);
		if (trialCalculations.isEmpty()) {
			return null;
		}
		return (ArrayList<StakeholderTrialCalculationReportDTO>) trialCalculations.stream().map(trialCalculation ->{
			
			Application application = trialCalDAOImpl.getApplicationByTCId(trialCalculation.getTrialCalculationId());
			StakeholderTrialCalculationReportDTO stakeholderTrialCalculationReportDTO = new StakeholderTrialCalculationReportDTO();
			stakeholderTrialCalculationReportDTO.setTrialCalculationNumber(trialCalculation.getTrialCalculationNumber());
			stakeholderTrialCalculationReportDTO.setApplicationSts(application != null?application.getApplicationStatus():"No Application" );
			stakeholderTrialCalculationReportDTO.setCapitalAmount(trialCalculation.getCapitalAmount());
			stakeholderTrialCalculationReportDTO.setEmi(trialCalculation.getEmi());
			stakeholderTrialCalculationReportDTO.setInterestRate(trialCalculation.getInterestRate());
			stakeholderTrialCalculationReportDTO.setNoOfMonth(trialCalculation.getNoOfMonth());
			stakeholderTrialCalculationReportDTO.setTimestamp(trialCalculation.getTimestamp());
			
			return stakeholderTrialCalculationReportDTO;
		}).collect(Collectors.toList());	
	}
	
	@Override
	public ArrayList<StakeholderApplicationReportDTO> generateStakeHolderApplicationsReport(int stakeholderId){
		ArrayList<Application> applications = (ArrayList<Application>) trialCalDAOImpl.getAllApplicationsByStakeHolderId(stakeholderId);
		if (applications.isEmpty()) {
			return null;
		}
		ArrayList<StakeholderApplicationReportDTO> stakeholderApplicationReportDTOs = new ArrayList<>();
		
		return (ArrayList<StakeholderApplicationReportDTO>) applications.stream().map(application ->{
			TrialCalculation trialCalculation = trialCalDAOImpl.getTrialCalculationById(application.getTrialCalculationId());
			StakeholderApplicationReportDTO stakeholderApplicationReportDTO = new StakeholderApplicationReportDTO();
			stakeholderApplicationReportDTO.setApplicationNumber(application.getApplicationNumber());
			stakeholderApplicationReportDTO.setApplicationStatus(application.getApplicationStatus());
			stakeholderApplicationReportDTO.setTrialCalculationNumber(trialCalculation.getTrialCalculationNumber());
			stakeholderApplicationReportDTO.setCapitalAmount(trialCalculation.getCapitalAmount());
			stakeholderApplicationReportDTO.setEmi(trialCalculation.getEmi());
			stakeholderApplicationReportDTO.setInterestRate(trialCalculation.getInterestRate());
			stakeholderApplicationReportDTO.setNoOfMonth(trialCalculation.getNoOfMonth());
			stakeholderApplicationReportDTO.setCreatedUserId(application.getCreatedUserId());
			stakeholderApplicationReportDTO.setCreatedTimestamp(application.getCreatedTimestamp());
			return stakeholderApplicationReportDTO;
			
		}).collect(Collectors.toList());	
	}
	
	@Override
	public ArrayList<TrialCalculation> generateTrialCalculationReport(Date fromDate, Date toDate){
		return trialCalDAOImpl.generateTrialCalculationReport(fromDate, toDate);
	}
	
	/*
	 **************************************************************************
	 * Schedule
	 **************************************************************************
	 * */
	
	public ArrayList<HashMap<String, Double>> generateSchedule(TrialCalculation trialCalculation) {
		ArrayList<HashMap<String, Double>> schedule = new ArrayList<HashMap<String, Double>>();
		
		double emi = trialCalculation.getEmi();
		double annualInterestRate = trialCalculation.getInterestRate();
		double capitalAmount = trialCalculation.getCapitalAmount();
		double noOfMonths = trialCalculation.getNoOfMonth();

		double interest, capital, capitalBalance;
		
		for (int i = 1; i <= noOfMonths; i++) {
			
			interest = capitalAmount * (annualInterestRate / 100) / 12;
			capital = emi - interest;
			capitalBalance = capitalAmount - capital;
			

			HashMap<String, Double> scheduleRow = new HashMap<String, Double>();
			scheduleRow.put("emiNo", (double) i);
			scheduleRow.put("installment",emi);
			scheduleRow.put("interest", interest);
			scheduleRow.put("capital", capital);
			scheduleRow.put("capitalBalance", capitalBalance);
			
			schedule.add(scheduleRow);
			capitalAmount = capitalBalance;
		}
		return schedule;
	}
	
	@Override
	public boolean saveSchedule(ArrayList<HashMap<String, Double>> schedule, int trialCalId){
		return trialCalDAOImpl.saveSchedule(schedule, trialCalId);
	}
}
