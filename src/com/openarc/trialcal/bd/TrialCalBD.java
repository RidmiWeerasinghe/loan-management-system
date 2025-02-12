package com.openarc.trialcal.bd;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.openarc.trialcal.action.AdminAction;
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

public interface TrialCalBD {
	/*
	 ***************************************************************************
	 * admin
	 ***************************************************************************
	 */
	public UserGroup createUserGroup(UserGroup userGroup);

	public List<UserGroup> getAllUserGroups();

	public boolean updateUserGroup(UserGroup userGroup);

	public UserGroup getUserGroupById(int groupId);

	/*
	 ***************************************************************************
	 * user
	 ***************************************************************************
	 */
	public User createUser(User user);

	public User login(User user);

	public List<User> getAllUsers();

	public boolean updateUser(User user);

	public boolean updateUserStatus(User user, String sts);

	public boolean updateUserPassword(int userId, String password);

	public User getUserByUserId(int userId);

	/*
	 ***************************************************************************
	 * stakeholder
	 ***************************************************************************
	 */
	public Stakeholder createStakeholder(Stakeholder stakeholder);

	public List<Stakeholder> getAllStakeHolders();

	public boolean updateStakeholder(Stakeholder stakeholder);

	public boolean deleteStakeholder(int id);

	public Stakeholder getStakeholderById(int id);

	/*
	 ***************************************************************************
	 * stakeholder-address
	 ***************************************************************************
	 */
	public Address createAddress(Address address);

	public Address getAddressByAddressId(int addressId);

	public boolean updateAddress(Address address);

	public boolean deleteAddress(int id);

	/*
	 ***************************************************************************
	 * postal-code
	 ***************************************************************************
	 */
	public List<PostalCode> getAllPostalCodes();

	public PostalCode getPostalCodeById(int postalCodeId);

	/*
	 ***************************************************************************
	 * trial calculation
	 ***************************************************************************
	 */
	public TrialCalculation createTrialCalculation(TrialCalculation trialCalculation);

	public TrialCalculation getTrialCalculationById(int id);

	public List<TrialCalculation> getAllTrialCalculations();

	public List<TrialCalculation> getAllTrialCalculationsByStakeHolderId(int id);

	public List<TrialCalculation> getAllTrialCalculationsWithoutApplicationsByStakeHolderId(int id);

	public List<TrialCalculation> getAllTrialCalculationsWithoutApplications();

	public boolean updateTrialCalculation(TrialCalculation trialCalculation);

	public boolean deleteTrialCalculation(int id);

	/*
	 ***************************************************************************
	 * application
	 ***************************************************************************
	 */
	public Application createApplication(Application application);

	public Application getApplicationById(int id);

	public List<Application> getAllApplications();

	public List<Application> getAllApplicationsByStakeHolderId(int id);

	public List<Application> getAllPendingApplications();

	public boolean updateApplication(Application application);

	public boolean updateApplicationStatus(int id, String sts, int userId);

	public boolean deleteApplication(int id);

	/*
	 **************************************************************************
	 * User history
	 **************************************************************************
	 */
	public UserHistory saveOldPassword(UserHistory userHistory);

	public List<UserHistory> getAllUserHistoryByUserId(int userId);

	/*
	 **************************************************************************
	 * Report
	 **************************************************************************
	 */
	public ArrayList<StakeholderReportDTO> generateStakeHolderReport(Date fromDate, Date toDate);

	public ArrayList<StakeholderTrialCalculationReportDTO> generateStakeHolderTrialCalculationsReport(
			int stakeholderId);

	public ArrayList<StakeholderApplicationReportDTO> generateStakeHolderApplicationsReport(int stakeholderId);

	public ArrayList<TrialCalculation> generateTrialCalculationReport(Date fromDate, Date toDate);

	/*
	 **************************************************************************
	 * Schedule
	 **************************************************************************
	 */
	public ArrayList<HashMap<String, Double>> generateSchedule(TrialCalculation trialCalculation);

	public boolean saveSchedule(ArrayList<HashMap<String, Double>> schedule, int trialCalId);
}
