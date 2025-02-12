package com.openarc.trialcal.dao.impl;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import com.openarc.trialcal.dao.TrialCalDAO;
import com.openarc.trialcal.dto.Address;
import com.openarc.trialcal.dto.Application;
import com.openarc.trialcal.dto.PostalCode;
import com.openarc.trialcal.dto.Schedule;
import com.openarc.trialcal.dto.Stakeholder;
import com.openarc.trialcal.dto.TrialCalculation;
import com.openarc.trialcal.dto.User;
import com.openarc.trialcal.dto.UserGroup;
import com.openarc.trialcal.dto.UserHistory;

public class TrialCalDAOImpl implements TrialCalDAO {
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	Session session = null;

	/*
	 ***************************************************************************
	 * admin
	 ***************************************************************************
	 */

	@Override
	public UserGroup createUserGroup(UserGroup userGroup) {
		session = sessionFactory.openSession();
		Transaction transaction = null;

		try {
			transaction = session.beginTransaction();

			session.save(userGroup);

			transaction.commit();
			return userGroup;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public List<UserGroup> getAllUserGroups() {
		List<UserGroup> userGroups = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM UserGroup l";
			Query query = session.createQuery(hql);

			userGroups = (List<UserGroup>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return userGroups;
	}

	@Override
	public boolean updateUserGroup(UserGroup userGroup) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		try {
			transaction = session.beginTransaction();

			// Update the license entity
			session.update(userGroup);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public UserGroup getUserGroupById(int groupId) {
		UserGroup userGroup = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM UserGroup ug WHERE ug.groupId = :groupId";
			Query query = session.createQuery(hql);
			query.setParameter("groupId", groupId);

			userGroup = (UserGroup) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return userGroup;
	}

	/*
	 ***************************************************************************
	 * user
	 ***************************************************************************
	 */

	@Override
	public User login(User user) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		User foundUser = null;

		try {
			transaction = session.beginTransaction();

			String hql = "FROM User WHERE username = :username AND password = :password";
			Query query = session.createQuery(hql);
			query.setParameter("username", user.getUsername());
			query.setParameter("password", user.getPassword());

			foundUser = (User) query.uniqueResult();

			transaction.commit();

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return foundUser;
	}

	@Override
	public User createUser(User user) {
		session = sessionFactory.openSession();
		Transaction transaction = null;

		try {
			transaction = session.beginTransaction();

			session.save(user);

			transaction.commit();
			return user;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM User l";
			Query query = session.createQuery(hql);

			users = (List<User>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return users;
	}

	@Override
	public boolean updateUser(User user) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		try {
			transaction = session.beginTransaction();

			session.update(user);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean updateUserStatus(User user, String sts) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;
		user.setStatus(sts);

		try {
			transaction = session.beginTransaction();

			session.update(user);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}
	
	@Override
	public boolean updateUserPassword(int userId, String password){
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		String hql = "UPDATE User SET password = :password  WHERE userId = :id";		
		try {
			transaction = session.beginTransaction();
			Query query = session.createQuery(hql);
			query.setParameter("password", password);
			query.setParameter("id", userId);

			int updateSts = query.executeUpdate();

			transaction.commit();
			isUpdated = updateSts != 0 ? true : false;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	public User getUserByUserId(int userId) {
		User user = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM User  WHERE userId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", userId);

			user = (User) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return user;
	}

	/*
	 ***************************************************************************
	 * stakeholder
	 ***************************************************************************
	 */
	@Override
	public Stakeholder createStakeholder(Stakeholder stakeholder) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		long millis = System.currentTimeMillis();  
        Date currentDate = new Date(millis);  
		stakeholder.setRegisteredDate(currentDate);
		try {
			transaction = session.beginTransaction();

			session.save(stakeholder);

			transaction.commit();
			return stakeholder;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public List<Stakeholder> getAllStakeHolders() {
		List<Stakeholder> stakeholders = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM Stakeholder l";
			Query query = session.createQuery(hql);

			stakeholders = (List<Stakeholder>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return stakeholders;
	}

	@Override
	public boolean updateStakeholder(Stakeholder stakeholder) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		try {
			transaction = session.beginTransaction();

			session.update(stakeholder);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean deleteStakeholder(int id) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isDeleted = false;

		try {
			transaction = session.beginTransaction();

			String hql = "DELETE FROM Stakeholder WHERE stakeholderId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			int result = query.executeUpdate();
			if (result > 0) {
				isDeleted = true;
			}

			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}

		return isDeleted;
	}

	public Stakeholder getStakeholderById(int id) {
		Stakeholder stakeholder = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Stakeholder WHERE stakeholderId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			stakeholder = (Stakeholder) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return stakeholder;
	}
	/*
	 ***************************************************************************
	 * stakeholder-address
	 ***************************************************************************
	 */

	@Override
	public Address createAddress(Address address) {
		session = sessionFactory.openSession();
		Transaction transaction = null;

		try {
			transaction = session.beginTransaction();

			session.save(address);

			transaction.commit();
			return address;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public Address getAddressByAddressId(int addressId) {
		Address address = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Address  WHERE addressId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", addressId);

			address = (Address) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return address;
	}

	@Override
	public boolean updateAddress(Address address) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		try {
			transaction = session.beginTransaction();

			session.update(address);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean deleteAddress(int id) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isDeleted = false;

		try {
			transaction = session.beginTransaction();

			String hql = "DELETE FROM Address WHERE addressId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			int result = query.executeUpdate();
			if (result > 0) {
				isDeleted = true;
			}

			transaction.commit();
		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();
		} finally {
			session.close();
		}

		return isDeleted;
	}

	/*
	 ***************************************************************************
	 * postal-code
	 ***************************************************************************
	 */
	@Override
	public List<PostalCode> getAllPostalCodes() {
		List<PostalCode> postalCodes = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM PostalCode l";
			Query query = session.createQuery(hql);

			postalCodes = (List<PostalCode>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return postalCodes;
	}

	@Override
	public PostalCode getPostalCodeById(int postalCodeId) {
		PostalCode postalCode = null;

		try {
			session = sessionFactory.openSession();

			String hql = "FROM PostalCode WHERE postalCodeId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", postalCodeId);

			postalCode = (PostalCode) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return postalCode;
	}

	/*
	 ***************************************************************************
	 * trial calculation
	 ***************************************************************************
	 */

	@Override
	public TrialCalculation createTrialCalculation(TrialCalculation trialCalculation) {
		session = sessionFactory.openSession();
		Transaction transaction = null;

		trialCalculation.setTimestamp(new Timestamp(System.currentTimeMillis()));
		try {
			transaction = session.beginTransaction();

			session.save(trialCalculation);
			trialCalculation.setTrialCalculationNumber("TC" + trialCalculation.getTrialCalculationId());
			session.update(trialCalculation);
			transaction.commit();
			return trialCalculation;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public TrialCalculation getTrialCalculationById(int id) {
		TrialCalculation trialCalculation = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM TrialCalculation  WHERE trialCalculationId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			trialCalculation = (TrialCalculation) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return trialCalculation;
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculations() {
		List<TrialCalculation> trialCalculations = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM TrialCalculation l";
			Query query = session.createQuery(hql);

			trialCalculations = (List<TrialCalculation>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return trialCalculations;
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsByStakeHolderId(int id) {
		List<TrialCalculation> trialCalculations = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			String hql = "FROM TrialCalculation  WHERE stakeholderId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			trialCalculations = (List<TrialCalculation>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return trialCalculations;
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsWithoutApplicationsByStakeHolderId(int stakeholderId) {
		List<TrialCalculation> trialCalculations = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			// HQL query to fetch TrialCalculations without matching entries in
			// Application table
			String hql = "FROM TrialCalculation tc WHERE tc.stakeholderId = :stakeholderId "
					+ "AND tc.trialCalculationId NOT IN (SELECT a.trialCalculationId FROM Application a)";
			Query query = session.createQuery(hql);
			query.setParameter("stakeholderId", stakeholderId);

			trialCalculations = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return trialCalculations;
	}

	@Override
	public List<TrialCalculation> getAllTrialCalculationsWithoutApplications() {
		List<TrialCalculation> trialCalculations = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			// HQL query to fetch TrialCalculations without matching entries in
			// Application table
			String hql = "FROM TrialCalculation tc WHERE "
					+ "tc.trialCalculationId NOT IN (SELECT a.trialCalculationId FROM Application a)";
			Query query = session.createQuery(hql);

			trialCalculations = query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return trialCalculations;
	}

	@Override
	public boolean updateTrialCalculation(TrialCalculation trialCalculation) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;
		trialCalculation.setTimestamp(new Timestamp(System.currentTimeMillis()));
		try {
			transaction = session.beginTransaction();

			// Update the license entity
			session.update(trialCalculation);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean deleteTrialCalculation(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	/*
	 ***************************************************************************
	 * application
	 * *************************************************************************
	 */

	@Override
	public Application createApplication(Application application) {
		session = sessionFactory.openSession();
		Transaction transaction = null;

		application.setApplicationStatus("P");
		application.setCreatedTimestamp(new Timestamp(System.currentTimeMillis()));
		try {
			transaction = session.beginTransaction();

			session.save(application);
			application.setApplicationNumber("APP" + application.getApplicationId());
			session.update(application);

			transaction.commit();
			return application;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}

	@Override
	public Application getApplicationById(int id) {
		Application application = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Application  WHERE applicationId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			application = (Application) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return application;
	}
	
	@Override
	public Application getApplicationByTCId(int id) {
		Application application = null;
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Application  WHERE trialCalculationId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			application = (Application) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return application;
	}


	@Override
	public List<Application> getAllApplications() {
		List<Application> applications = new ArrayList<>();

		try {
			session = sessionFactory.openSession();

			String hql = "FROM Application l";
			Query query = session.createQuery(hql);

			applications = (List<Application>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return applications;
	}

	@Override
	public List<Application> getAllApplicationsByStakeHolderId(int id) {
		List<Application> applications = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Application  WHERE stakeholderId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);

			applications = (List<Application>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return applications;
	}

	@Override
	public List<Application> getAllPendingApplications() {
		List<Application> applications = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			String hql = "FROM Application  WHERE applicationStatus = :sts";
			Query query = session.createQuery(hql);
			query.setParameter("sts", "P");

			applications = (List<Application>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return applications;
	}

	@Override
	public boolean updateApplication(Application application) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		try {
			transaction = session.beginTransaction();

			// Update the license entity
			session.update(application);

			transaction.commit();
			isUpdated = true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean updateApplicationStatus(int id, String sts, int userId) {
		session = sessionFactory.openSession();
		Transaction transaction = null;
		boolean isUpdated = false;

		Timestamp currentTimeStamp = new Timestamp(System.currentTimeMillis());
		String hql = "";
		if (sts.equals("A")) {
			hql = "UPDATE Application SET applicationStatus = :sts, approvedTimestamp = :time, approvedUserId = :userId  WHERE applicationId = :id";		
		}
		else{
			hql = "UPDATE Application SET applicationStatus = :sts, rejectedTimestamp = :time, rejectedUserId = :userId  WHERE applicationId = :id";					
		}
		try {
			transaction = session.beginTransaction();

			Query query = session.createQuery(hql);
			query.setParameter("sts", sts);
			query.setParameter("id", id);
			query.setParameter("time", currentTimeStamp);
			query.setParameter("userId", userId);

			int updateSts = query.executeUpdate();

			transaction.commit();
			isUpdated = updateSts != 0 ? true : false;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return isUpdated;
	}

	@Override
	public boolean deleteApplication(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	/*
	 **************************************************************************
	 * User history
	 **************************************************************************
	 * */
	public UserHistory saveOldPassword(UserHistory userHistory){
		session = sessionFactory.openSession();
		Transaction transaction = null;

		try {
			transaction = session.beginTransaction();

			session.save(userHistory);

			transaction.commit();
			return userHistory;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return null;
	}
	
	public List<UserHistory> getAllUserHistoryByUserId(int userId){
		List<UserHistory> userHistories = new ArrayList<>();
		try {
			session = sessionFactory.openSession();

			String hql = "FROM UserHistory  WHERE userId = :id";
			Query query = session.createQuery(hql);
			query.setParameter("id", userId);

			userHistories = (List<UserHistory>) query.list();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null) {
				session.close();
			}
		}
		return userHistories;
	}
	
	/*
	 **************************************************************************
	 * Report
	 **************************************************************************
	 * */
	public ArrayList<Stakeholder> generateStakeHolderReport(Date fromDate, Date toDate) {
	    ArrayList<Stakeholder> stakeholders = new ArrayList<>();

	    try {
	        session = sessionFactory.openSession();

	        // HQL to filter stakeholders based on the registeredDate within the given range
	        String hql = "FROM Stakeholder s WHERE s.registeredDate BETWEEN :fromDate AND :toDate";
	        Query query = session.createQuery(hql);
	        query.setParameter("fromDate", fromDate);
	        query.setParameter("toDate", toDate);

	        stakeholders = (ArrayList<Stakeholder>) query.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (session != null) {
	            session.close();
	        }
	    }
	    return stakeholders;
	}

	@Override
	public ArrayList<TrialCalculation> generateTrialCalculationReport(Date fromDate, Date toDate) {
		ArrayList<TrialCalculation> trialCalculations = new ArrayList<>();
		 try {
		        session = sessionFactory.openSession();

		        // HQL to filter stakeholders based on the registeredDate within the given range
		        String hql = "FROM TrialCalculation s WHERE s.timestamp BETWEEN :fromDate AND :toDate";
		        Query query = session.createQuery(hql);
		        query.setParameter("fromDate", fromDate);
		        query.setParameter("toDate", toDate);

		        trialCalculations = (ArrayList<TrialCalculation>) query.list();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        if (session != null) {
		            session.close();
		        }
		    }
		    return trialCalculations;
	}
	
	/*
	 **************************************************************************
	 * schedule
	 **************************************************************************
	 * */
	@Override
	public boolean saveSchedule(ArrayList<HashMap<String, Double>> schedule, int trialCalId){
		session = sessionFactory.openSession();
		Transaction transaction = null;

		try {
			transaction = session.beginTransaction();

			for (HashMap<String, Double> scheduleHashMap : schedule) {
				Schedule scheduleRow = new Schedule();

				scheduleRow.setTrialCalculationId(trialCalId);
				// Set schedule properties from the map
				scheduleRow.setEmiNo(scheduleHashMap.get("emiNo").intValue());
				scheduleRow.setInstallment(scheduleHashMap.get("installment"));
				scheduleRow.setInterest(scheduleHashMap.get("interest"));
				scheduleRow.setCapital(scheduleHashMap.get("capital"));
				scheduleRow.setCapitalBalance(scheduleHashMap.get("capitalBalance"));

				session.save(scheduleRow);
			}

			transaction.commit();
			return true;

		} catch (Exception e) {
			if (transaction != null) {
				transaction.rollback();
			}
			e.printStackTrace();

		} finally {
			session.close();
		}

		return false;
	}
}
