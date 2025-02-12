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
	margin: 50px;
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
	padding: 40px;
	border-radius: 8px;
	margin-bottom: 50px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 20px;
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap:10px;
}

.form-group-element {
	flex: 1;
	box-sizing: border-box;
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

select{
	width: 100%;
	padding: 8px; /* Adjusted padding for select boxes */
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left; /* Align text to the left */
}

.form-group .input-inline {
	display: flex;
	align-items: center;
	gap: 5px;
}

.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
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

.emi-container {
	margin: 20px;
}

.emi-container input {
	width: 97%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f9f9f9;
	color: #333;
}

.schedule-button-container {
	margin-top: 10px;
	text-align: right;
}

.schedule-button-container button {
	padding: 10px 20px;
	font-size: 14px;
	color: #fff;
	background: #439c47;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.schedule-button-container button:hover {
	background: #38833d;
}
</style>
<script>
	// JavaScript function to load stakeholders in a small window
	function loadStakeholders() {
		window.open('viewstakeholders.jsp', 'ChildWindow',
				'width=900,height=400,resizable=yes,scrollbars=yes');
	}
	function loadStakeholderTrialCalculations() {
		const stakeholderId = document.getElementById('stakeholderId').value.trim();
		if (stakeholderId) {      
			window.open('viewtrialcalculationswithoutapplication.jsp',
				'ChildWindow',
				'width=900,height=400,resizable=yes,scrollbars=yes');
	    }else{
	    			alert("Select stakeholder first");
	    }
	}
	// JavaScript to clear the form
	function clearForm() {
		document.querySelector('form').reset();
		document.getElementById('applicationNumber').value = '';
	}
	function validateCreateApplication() {
	    // Extract input values
	    const stakeholderId = document.getElementById('stakeholderId').value.trim();
	    const stakeholderName = document.getElementById('stakeholderName').value.trim();
	    const trialCalculationId = document.getElementById('trialCalculationId').value.trim();
	    const trialCalculationNumber = document.getElementById('trialCalculationNumber').value.trim();
	    const applicationStatus = document.getElementById('applicationStatus').value.trim();

	    // Object to store validation errors
	    const validationErrors = {};

	    // Validate Stakeholder ID
	    if (!stakeholderId) {
	        validationErrors['stakeholderId-error'] = "Stakeholder ID is required.";
	    }

	    // Validate Stakeholder Name
	    if (!stakeholderName) {
	        validationErrors['stakeholderName-error'] = "Stakeholder Name is required.";
	    }

	    // Validate Trial Calculation ID
	    if (!trialCalculationId) {
	        validationErrors['trialCalculationId-error'] = "Trial Calculation ID is required.";
	    }

	    // Validate Trial Calculation Number
	    if (!trialCalculationNumber) {
	        validationErrors['trialCalculationNumber-error'] = "Trial Calculation Number is required.";
	    }

	    // Validate Application Status
	    if (!applicationStatus) {
	        validationErrors['applicationStatus-error'] = "Application Status is required.";
	    } else if (applicationStatus !== "Pending") {
	        validationErrors['applicationStatus-error'] = "Application Status must be 'Pending'.";
	    }

	    // Display error messages and highlight errors
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	            errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }

	    // Return validation result
	    return Object.keys(validationErrors).length === 0;
	}

	function createApplication() {
		var isValid = validateCreateApplication();
		if (isValid) {
			const stakeholderId = document.getElementById('stakeholderId').value
					.trim();
			const trialCalculationId = document
					.getElementById('trialCalculationId').value.trim();

			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("createApplication()");
							console.log(response.result);

							if (response.result.error) {
								alert(response.result.error);
							}

							if (response.result.success === true || response.result.successmsg) {
								if (response.result.successmsg) {
									alert(response.result.successmsg);
									document.getElementById('applicationNumber').value = response.result.applicationNumber;
								}
							}
						} catch (e) {
							console.error('Invalid response:', e);
							alert('An error occurred while processing the server response.');
						}
					} else {
						console.error('Request failed with status:',
								this.status);
						alert('Failed to create user group. Please try again.');
					}
				}
			};

			// Open and send the POST request
			xhttp.open("POST",
					"/Trial_Calculator/applicationAction-createApplication?t="
							+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "loanApplication.stakeholderId=" + stakeholderId
					+ "&loanApplication.trialCalculationId=" + trialCalculationId
					+ "&application.trialCalculationId=" + trialCalculationId
					+ "&trialCalculation.trialCalculationId=" + trialCalculationId;
			console.log(data);
			xhttp.send(data);
		}
	}
</script>
</head>
<body>
	<div class="home-content">
		<h2>Create Application</h2>
		<div class="form-container">
			<form action="calculateEMI" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label>Stakeholder ID</label>
						<div class="form-group-element-button">
							<input type="text" id="stakeholderId" name="stakeholderId"
								required onclick="clearErrorMessages('stakeholderId-error')"
								readonly="readonly">
							<button type="button" onclick="loadStakeholders()">...</button>
						</div>
						<div id="stakeholderId-error" class="validationerror"></div>
					</div>
					<div class="form-group-element">
						<label>Stakeholder Name</label> <input type="text"
							id="stakeholderName" name="stakeholderName" required readonly
							onclick="clearErrorMessages('stakeholderName-error')">
						<div id="stakeholderName-error" class="validationerror"></div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label>Trial Calculation ID</label>
						<div class="form-group-element-button">
							<input type="text" id="trialCalculationId"
								name="trialCalculationId" required
								onclick="clearErrorMessages('trialCalculationId-error')"
								readonly="readonly">
							<button type="button"
								onclick="loadStakeholderTrialCalculations(); clearErrorMessages('trialCalculationId-error')">...</button>
						</div>
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
						<label>Application Status</label> <input type="text"
							id="applicationStatus" name="applicationStatus" required readonly
							value="Pending"
							onclick="clearErrorMessages('applicationStatus-error')">
					</div>
					<div id="applicationStatus-error" class="validationerror"></div>
				</div>

				<!-- Calculate and Clear Buttons -->
				<div class="form-actions">
					<button type="button" onclick="createApplication()">Create
						Application</button>
				</div>

				<div class="form-group">
					<div class="form-group-element">
						<label>Application Number</label> <input type="text"
							id="applicationNumber" name="applicationNumber" readonly>
					</div>
					<div id="applicationStatus-error" class="validationerror"></div>
				</div>
				<div class="form-actions">
					<button type="button" onclick="clearForm()">Clear</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
