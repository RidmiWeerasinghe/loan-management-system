<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Loan Installment Calculator</title>
<!-- Boxicons CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/createapplication.css">
<script src="js/common.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	margin:20px;
	padding: 0;
}

.home-content {
	padding: 20px;
	background-color: #f4f4f4;
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
}

.form-container {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 50px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
	display: flex;
	flex-wrap: wrap;
	align-items: center;
}

.form-group-element {
	flex: 1;
	box-sizing: border-box;
	padding: 0 10px;
}

.form-group-element-button {
	display: flex;
	flex-direction: row;
}

.form-group-element-button button {
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
	text-align: left;
}

.form-group input {
	width: 97%;
	padding: 8px; /* Adjusted padding for standard height */
	font-size: 14px; /* Ensure readable font size */
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left; /* Align text to the left */
}

select {
	width: 100%;
	padding: 8px; /* Adjusted padding for select boxes */
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left; /* Align text to the left */
}

.form-group button {
	
}

.form-group .input-inline {
	display: flex;
	align-items: center;
	gap: 5px;
}

.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 5px;
}

.form-actions button {
	padding: 10px 20px;
	font-size: 14px;
	color: #fff;
	background: #439c47;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.form-actions button:hover {
	background: #38833d;
}

.table-container {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table-container table {
	width: 100%;
	border-collapse: collapse;
	font-size: 12px;
}

.table-container table th, table td {
	text-align: left;
	padding: 10px;
	border: 1px solid #ddd;
}

.table-container table th {
	background: #242424;
	color: #fff;
}

.table-container table tr:hover {
	cursor: pointer;
	background: #eeeeee;
}

.search-container {
	margin-bottom: 2px;
	margin-top: 10px;
}

.search-box {
	display: flex;
	justify-content: flex-end;
	gap: 0px;
}

.search-box input {
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px 0 0 4px;
}

.search-box button {
	padding: 8px;
	background: #439c47;
	color: white;
	border: none;
	border-radius: 0 4px 4px 0;
	cursor: pointer;
	font-size: 18px;
}

.search-box button:hover {
	background: #38833d;
}
</style>
<script>
	// JavaScript function to load stakeholders in a small window
	function loadStakeholders() {
		window.open('viewstakeholders.jsp', 'ChildWindow',
				'width=900,height=400,resizable=yes,scrollbars=yes');
	}
	// JavaScript to clear the form
	function clearForm() {
		document.querySelector('form').reset();
		document.getElementById('emi').value = '';
	}

	function getAllPendingApplications() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.applications) {
							setTableData(response.result.applications);
						} else {
							const tbody = document
									.getElementById('tableContainer');
							tbody.innerHTML = "<div style='color: red; text-align: center; font-weight: bold;'>No pending applications are currently available.</div>";
						}
					} catch (e) {
						console.error('Invalid response:', e);
						alert('An error occurred while processing the server response.');
					}
				} else {
					console.error('Request failed with status:', this.status);
					alert('Failed to get all user groups. Please try again.');
				}
			}
		};

		// Open and send the POST request
		xhttp.open("POST",
				"/Trial_Calculator/applicationActionBean-getAllPendingApplication?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}

	function setTableData(applications) {
		const tbody = document.getElementById('tbody');
		tbody.innerHTML = "";

		function processApplication(index) {
			if (index >= applications.length)
				return; // Exit when all applications are processed

			const application = applications[index];
			let stakeholderFullName = "";
			let trialCalculationNumber = "";
			let applicationNumber = "";

			getStakeholderByStakeholderId(
					application.stakeholderId,
					function(stakeholder) {
						if (stakeholder) {
							stakeholderFullName = stakeholder.fullName;

							getTrialCalculationByTrialCalculationId(
									application.trialCalculationId,
									function(trialCalculation) {
										if (trialCalculation) {
											trialCalculationNumber = trialCalculation.trialCalculationNumber;

											getApplicationByApplicationId(
													application.applicationId,
													function(applicationData) {
														if (applicationData) {
															applicationNumber = applicationData.applicationNumber;
														}

														// Create and populate the table row
														const tr = document
																.createElement('tr');
														tr.innerHTML = "<td>"
																+ application.applicationId
																+ "</td><td style='display: none;'>"
																+ application.trialCalculationId
																+ "</td><td style='display: none;'>"
																+ application.stakeholderId
																+ "</td><td>"
																+ application.applicationStatus
																+ "</td><td>"
																+ stakeholderFullName
																+ "</td><td>"
																+ applicationNumber
																+ "</td><td>"
																+ trialCalculationNumber
																+ "</td>";

														tr
																.addEventListener(
																		'click',
																		function() {
																			getApplication(event);
																		});

														tbody.appendChild(tr);

														processApplication(index + 1);
													});
										} else {
											processApplication(index + 1);
										}
									});
						} else {
							processApplication(index + 1);
						}
					});
		}

		processApplication(0);
	}

	function getApplication(event) {

		const clickedRow = event.currentTarget;
		const cells = clickedRow.children;

		const applicationId = cells[0].textContent;
		const stakeholderId = cells[1].textContent;
		const trialCalculationId = cells[2].textContent;
		const applicationStatus = cells[3].textContent;
		const stakeholderName = cells[4].textContent;
		const applicationNumber = cells[5].textContent;
		const trialCalculationNumber = cells[6].textContent;

		document.getElementById('stakeholderId').value = stakeholderId;
		document.getElementById('trialCalculationId').value = trialCalculationId;
		document.getElementById('applicationStatus').value = applicationStatus;
		document.getElementById('stakeholderName').value = stakeholderName;
		document.getElementById('trialCalculationNumber').value = trialCalculationNumber;
		document.getElementById('applicationNumber').value = applicationNumber;
		document.getElementById('applicationId').value = applicationId;

	}
	function getApplicationByApplicationId(applicationId, callback) {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.success === true) {
							callback(response.result.application);
						}
					} catch (e) {
						console.error('Invalid response:', e);
						alert('An error occurred while processing the server response.');
					}
				} else {
					console.error('Request failed with status:', this.status);
					alert('Failed to load stakeholder address. Please try again.');
				}
			}
		};

		// Open and send the POST request
		xhttp.open("POST",
				"/Trial_Calculator/applicationActionBean-getApplicationByApplicationId?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "loanApplication.applicationId=" + applicationId;
		xhttp.send(data);
	}
	function getStakeholderByStakeholderId(stakeholderId, callback) {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.success === true) {
							callback(response.result.stakeholder);
						}
					} catch (e) {
						console.error('Invalid response:', e);
						alert('An error occurred while processing the server response.');
					}
				} else {
					console.error('Request failed with status:', this.status);
					alert('Failed to load stakeholder address. Please try again.');
				}
			}
		};

		// Open and send the POST request
		xhttp.open("POST",
				"/Trial_Calculator/stakeholderAction-getStakeholderByStakeholderId?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "stakeholder.stakeholderId=" + stakeholderId;
		xhttp.send(data);
	}
	function getTrialCalculationByTrialCalculationId(trialCalculationId,
			callback) {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.success === true) {
							callback(response.result.trialCalculation);
						}
					} catch (e) {
						console.error('Invalid response:', e);
						alert('An error occurred while processing the server response.');
					}
				} else {
					console.error('Request failed with status:', this.status);
					alert('Failed to load stakeholder address. Please try again.');
				}
			}
		};

		// Open and send the POST request
		xhttp.open("POST",
				"/Trial_Calculator/trialCalculationAction-getTrialCalculationById?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "trialCalculation.trialCalculationId="
				+ trialCalculationId;
		xhttp.send(data);
	}

	function clearInputFields() {
		document.getElementById('stakeholderId').value = "";
		document.getElementById('stakeholderName').value = "";
		document.getElementById('trialCalculationId').value = "";
		document.getElementById('trialCalculationNumber').value = "";
		document.getElementById('applicationStatus').value = "";
		document.getElementById('applicationNumber').value = "";
	}

	function Submit() {
		const applicationId = document.getElementById('applicationId').value
				.trim();
		const applicationStatus = document.getElementById('applicationStatus').value
				.trim();
		const currentUserId = 10;
		if (applicationId !== "" && applicationStatus !== "") {
			if (applicationStatus !== "P") {
				const xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() {
					if (this.readyState === 4) {
						if (this.status === 200) {
							try {
								const response = JSON.parse(this.responseText);

								if (response.result.error) {
									alert(response.result.error);
								}

								if (response.result.success === true) {
									alert(response.result.successmsg);
									clearInputFields();
									getAllPendingApplications();
								}
							} catch (e) {
								console.error('Invalid response:', e);
								alert('An error occurred while processing the server response.');
							}
						} else {
							console.error('Request failed with status:',
									this.status);
							alert('Failed to load stakeholder address. Please try again.');
						}
					}
				};

				// Open and send the POST request
				xhttp.open("POST",
						"/Trial_Calculator/applicationActionBean-updateApplicationStatus?t="
								+ new Date().getTime(), true);
				xhttp.setRequestHeader("Content-Type",
						"application/x-www-form-urlencoded");
				const data = "loanApplication.applicationId=" + applicationId
						+ "&loanApplication.applicationStatus="
						+ applicationStatus + "&loanApplication.createdUserId="
						+ currentUserId;
				xhttp.send(data);
			} else {
				alert("Can not update status as 'Pending' ");
			}
		} else {
			alert("Select an application");
		}
	}

	function clearInputFields() {
		document.getElementById('stakeholderId').value = "";
		document.getElementById('trialCalculationId').value = "";
		document.getElementById('applicationStatus').value = "";
		document.getElementById('stakeholderName').value = "";
		document.getElementById('trialCalculationNumber').value = "";
		document.getElementById('applicationNumber').value = "";
		document.getElementById('applicationId').value = "";
	}
</script>
</head>
<body onload="getAllPendingApplications()">
	<div class="home-content">
		<h2>Application Approval</h2>
		<div class="form-container">
			<form action="calculateEMI" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label>Stakeholder ID</label> <input type="text"
							id="stakeholderId" name="stakeholderId" required readonly
							onclick="clearErrorMessages('stakeholderId-error')">
						<div id="stakeholderId-error" class="validationerror"></div>
					</div>
					<div class="form-group-element">
						<label>Stakeholder Name</label> <input type="text"
							id="stakeholderName" name="stakeholderName" required readonly
							onclick="clearErrorMessages('stakeholderName-error')">
						<div id="stakeholderId-error" class="validationerror"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label>Trial Calculation ID</label> <input type="text"
							id="trialCalculationId" name="trialCalculationId" required
							readonly onclick="clearErrorMessages('trialCalculationId-error')">
						<div id="trialCalculationId-error" class="validationerror"></div>
					</div>
					<div class="form-group-element">
						<label>Trial Calculation Number</label> <input type="text"
							id="trialCalculationNumber" name="trialCalculationNumber"
							required readonly
							onclick="clearErrorMessages('trialCalculationNumber-error')">
						<div id="trialCalculationNumber-error" class="validationerror"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label>Application Status</label> <select id="applicationStatus"
							name="paymentPeriod" required
							onclick="clearErrorMessages('applicationStatus-error')">
							<option value="">Update status...</option>
							<option value="P">Pending</option>
							<option value="A">Approve</option>
							<option value="R">Reject</option>
							<!-- <option value="C">Cancelled</option> -->
						</select>
						<div id="applicationStatus-error" class="validationerror"></div>
					</div>
					<div class="form-group-element">
						<label>Application Number</label> <input type="text"
							id="applicationNumber" name="applicationNumber" readonly
							onclick="clearErrorMessages('applicationNumber-error')">
						<input type="hidden" id="applicationId" name="applicationNumber">
						<div id="applicationNumber-error" class="validationerror"></div>
					</div>
				</div>

				<!-- Calculate and Clear Buttons -->
				<div class="form-actions">
					<button type="button" onclick="Submit()">Submit</button>
					<button type="button" onclick="clearForm()">Clear</button>
				</div>
			</form>
		</div>
		<div id="tableContainer">
			<div class="search-container">
				<h3>Pending Applications</h3>
				<div class="search-box">
					<input type="text" id="searchInput"
						placeholder="Search by Stakeholder ID">
					<button onclick="filterTable('usertbl', 'searchInput')">
						<i class='bx bx-search'></i>
					</button>
				</div>
			</div>
			<div class="table-container">
				<table id="stakeholertbl">
					<thead>
						<tr>
							<th>Application Id</th>
							<th>Application Status</th>
							<th>Stakeholder Name</th>
							<th>Application Number</th>
							<th>Trial Calculation Number</th>
						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>
			</div>
		</div>
</body>
</html>
