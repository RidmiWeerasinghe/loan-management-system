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
<link rel="stylesheet" href="css/emicalculator.css">
<script src="js/common.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	margin: 100px;
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
	padding: 30px;
	border-radius: 8px;
	margin-bottom: 50px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
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

.form-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	padding-right: 15px;
}

.form-actions button {
	padding: 10px 20px;
	font-size: 14px;
	color: #fff;
	background: #439c47;
	border: none;
	border-radius: 4px;
	width: 100px;
	cursor: pointer;
}

.form-actions button:hover {
	background: #38833d;
}

.schedule-button-container {
	margin-top: 10px;
	text-align: right;
	gap: 10px;
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

.table-container {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.table-container table {
	width: 100%;
	border-collapse: collapse;
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

.schedule-container table {
	width: 100%;
	border-collapse: collapse;
}

.schedule-container table th, table td {
	text-align: left;
	padding: 10px;
	border: 1px solid #ddd;
}

.schedule-container table th {
	background: #204a23;
	color: #fff;
}

.schedule-container table tr:hover {
	cursor: pointer;
	background: #eeeeee;
}

.search-container {
	margin-bottom: 2px;
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
/* pop up */
.modal {
	display: none; /* Hidden by default */
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto; /* Enable scroll if needed */
	background-color: rgba(0, 0, 0, 0.5); /* Black with opacity */
}

.modal-content {
	background-color: white;
	margin: 10% auto; /* Centered vertically */
	padding: 20px;
	border-radius: 8px;
	width: 60%; /* Adjust modal width */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.close-button {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close-button:hover, .close-button:focus {
	color: black;
	text-decoration: none;
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

	function openModal() {
		document.getElementById("scheduleModal").style.display = "block";
		generateSchedule();
	}

	function closeModal() {
		document.getElementById("scheduleModal").style.display = "none";
	}

	// Close modal when clicking outside of it
	window.onclick = function(event) {
		const
		modal = document.getElementById("scheduleModal");
		if (event.target === modal) {
			modal.style.display = "none";
		}
	};
	
	function getAllTrialCalculations() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.trialCalculationsWithoutApplications) {
							setTableData(response.result.trialCalculationsWithoutApplications);
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
		xhttp.open("POST", "/Trial_Calculator/trialCalculationAction-getAllTrialCalculations?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}
	function setTableData(trialCalculations) {
		const tbody = document.getElementById('tbody');
		tbody.innerHTML = "";
		for (var i = 0; i < trialCalculations.length; i++) {
			const tr = document.createElement('tr');
			var id = trialCalculations[i].trialCalculationId;
			tr.innerHTML = "<td style='display:none;'>" + trialCalculations[i].trialCalculationId + "</td><td>"
					+ trialCalculations[i].trialCalculationNumber + "</td><td>"
					+ trialCalculations[i].stakeholderId + "</td><td>"
					+ trialCalculations[i].timestamp + "</td><td style='display:none;'>"
					+ trialCalculations[i].capitalAmount + "</td><td style='display:none;'>"
					+ trialCalculations[i].interestRate + "</td><td style='display:none;'>"
					+ trialCalculations[i].noOfMonth + "</td><td style='display:none;'>"
					+ trialCalculations[i].emi + "</td>";

			tr.addEventListener('click', function() {
				getTrialCalculation(event);
			});
			tbody.appendChild(tr);
		}

	}
	function getTrialCalculation(event) {
		
	    const clickedRow = event.currentTarget;
	    const cells = clickedRow.children;

	    const trialCalculationId = cells[0].textContent;
	    const trialCalculationNumber = cells[1].textContent;
	    const stakeholderId = cells[2].textContent;
	    const timestamp = cells[3].textContent;
	    const capitalAmount = cells[4].textContent;
	    const interestRate = cells[5].textContent;
	    const noOfMonth = cells[6].textContent;
	    const emi = cells[7].textContent;
	    

	    document.getElementById('trialCalculationId').value=trialCalculationId;
	    document.getElementById('trialCalculationNumber').value=trialCalculationNumber;
	    document.getElementById('stakeholderId').value=stakeholderId;
	    document.getElementById('capitalAmount').value=capitalAmount;
	    document.getElementById('interestRate').value=interestRate;
	    document.getElementById('paymentPeriod').value=noOfMonth;
	    document.getElementById('emi').value=emi;
	    
	    getStakeholderByStakeholderId(stakeholderId, function(stakeholder) {
	        if (stakeholder) {
			    document.getElementById('stakeholderName').value=stakeholder.fullName;
	        }
	    });
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
		xhttp.open("POST", "/Trial_Calculator/stakeholderAction-getStakeholderByStakeholderId?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "stakeholder.stakeholderId=" + stakeholderId;
		xhttp.send(data);
	}

	function validateEmiCalculation() {
	    const stakeholderId = document.getElementById('stakeholderId').value.trim();
	    const trialCalculationNumber = document.getElementById('trialCalculationNumber').value.trim();
		const trialCalculationId = document.getElementById('trialCalculationId').value.trim();
	    const stakeholderName = document.getElementById('stakeholderName').value.trim();
	    const capitalAmount = document.getElementById('capitalAmount').value.trim();
	    const interestRate = document.getElementById('interestRate').value.trim();
	    const paymentPeriod = document.getElementById('paymentPeriod').value.trim();

	    const validationErrors = {};

	    // Validate Stakeholder ID (e.g., non-empty, alphanumeric)
	    if (!stakeholderId) {
	        validationErrors["stakeholderId-error"] = "Stakeholder ID is required.";
	    }

	    // Validate Stakeholder Name (e.g., non-empty, only letters and spaces)
	    if (!stakeholderName) {
	        validationErrors["stakeholderName-error"] = "Stakeholder Name is required.";
	    }
	    // Validate Capital Amount (e.g., non-empty, numeric, positive)
	    if (!capitalAmount) {
	        validationErrors["capitalAmount-error"] = "Capital Amount is required.";
	    } else if (isNaN(capitalAmount) || parseFloat(capitalAmount) <= 0) {
	        validationErrors["capitalAmount-error"] = "Capital Amount must be a positive number.";
	    }

	    // Validate Interest Rate (e.g., non-empty, numeric, between 0 and 100)
	    if (!interestRate) {
	        validationErrors["interestRate-error"] = "Interest Rate is required.";
	    } else if (isNaN(interestRate) || parseFloat(interestRate) <= 0 || parseFloat(interestRate) > 100) {
	        validationErrors["interestRate-error"] = "Interest Rate must be a number between 0 and 100.";
	    }

	    // Validate Payment Period (e.g., non-empty, integer, positive)
	    if (!paymentPeriod) {
	        validationErrors["paymentPeriod-error"] = "Payment Period is required.";
	    }
	    if (!trialCalculationId) {
	        validationErrors["trialCalculationId-error"] = "trialCalculationId is required.";
	    }
	    if (!trialCalculationNumber) {
	        validationErrors["trialCalculationNumber-error"] = "trialCalculationNumber is required.";
	    }

	    // Display Validation Errors
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	            errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }

	    // Clear Errors for Valid Fields
	    const allErrorFields = document.querySelectorAll('.error-message');
	    allErrorFields.forEach(field => {
	        if (!validationErrors[field.id]) {
	            field.style.display = "none";
	            field.textContent = "";
	        }
	    });

	    // Return Validation Result
	    return Object.keys(validationErrors).length === 0;
	}
	function calculateEmi() {
		clearErrorMessages('emi-error');
		var isValid = validateEmiCalculation();
		if (isValid) {
			const capitalAmount = document.getElementById('capitalAmount').value;
			const interestRate = document.getElementById('interestRate').value;
			const paymentPeriod = document.getElementById('paymentPeriod').value;
			var monthlyRate = interestRate / 12 / 100;
			var emi = (capitalAmount * monthlyRate * Math.pow(1 + monthlyRate,paymentPeriod))/ (Math.pow(1 + monthlyRate, paymentPeriod) - 1);
			document.getElementById('emi').value = emi.toFixed(2);
		}
		
	}
	function generateSchedule() {
		if (document.getElementById('emi').value === "") {
			alert("Calculate EMI to generate scheudle");
			return;
		}
		const emi = parseFloat(document.getElementById('emi').value);
	    var capitalAmount = parseFloat(document.getElementById('capitalAmount').value);
	    const interestRate = parseFloat(document.getElementById('interestRate').value);
	    const paymentPeriod = parseInt(document.getElementById('paymentPeriod').value);
	    const monthlyRate = interestRate / 12 / 100;
	    var tableBody = "";

	    // Formatter for numbers with commas and two decimal places
	    const formatter = new Intl.NumberFormat('en-US', {
	        minimumFractionDigits: 2,
	        maximumFractionDigits: 2,
	    });

	    for (var i = 1; i <= paymentPeriod; i++) {
	        const interest = capitalAmount * monthlyRate;
	        const capital = emi - interest;
	        const capitalBalance = capitalAmount - capital;

	        var row = "<tr><td>" +
	            i + "</td><td>" +
	            formatter.format(emi) + "</td><td>" +
	            formatter.format(interest) + "</td><td>" +
	            formatter.format(capital) + "</td><td>" +
	            formatter.format(capitalBalance) + "</td></tr>";

	        capitalAmount = capitalBalance;

	        tableBody += row;
	    }

	    document.getElementById('scheduleBody').innerHTML = tableBody;
	    openModal();
	}

	function validateSaveTrialCalculation() {
	    const stakeholderId = document.getElementById('stakeholderId').value.trim();
	    const trialCalculationNumber = document.getElementById('trialCalculationNumber').value.trim();
		const trialCalculationId = document.getElementById('trialCalculationId').value.trim();
	    const stakeholderName = document.getElementById('stakeholderName').value.trim();
	    const capitalAmount = document.getElementById('capitalAmount').value.trim();
	    const interestRate = document.getElementById('interestRate').value.trim();
	    const paymentPeriod = document.getElementById('paymentPeriod').value.trim();
	    const emi = document.getElementById('emi').value.trim();

	    const validationErrors = {};

	    // Validate Stakeholder ID (e.g., non-empty, alphanumeric)
	    if (!stakeholderId) {
	        validationErrors["stakeholderId-error"] = "Stakeholder ID is required.";
	    }

	    // Validate Stakeholder Name (e.g., non-empty, only letters and spaces)
	    if (!stakeholderName) {
	        validationErrors["stakeholderName-error"] = "Stakeholder Name is required.";
	    }
	    // Validate Capital Amount (e.g., non-empty, numeric, positive)
	    if (!capitalAmount) {
	        validationErrors["capitalAmount-error"] = "Capital Amount is required.";
	    } else if (isNaN(capitalAmount) || parseFloat(capitalAmount) <= 0) {
	        validationErrors["capitalAmount-error"] = "Capital Amount must be a positive number.";
	    }

	    // Validate Interest Rate (e.g., non-empty, numeric, between 0 and 100)
	    if (!interestRate) {
	        validationErrors["interestRate-error"] = "Interest Rate is required.";
	    } else if (isNaN(interestRate) || parseFloat(interestRate) <= 0 || parseFloat(interestRate) > 100) {
	        validationErrors["interestRate-error"] = "Interest Rate must be a number between 0 and 100.";
	    }

	    // Validate Payment Period (e.g., non-empty, integer, positive)
	    if (!paymentPeriod) {
	        validationErrors["paymentPeriod-error"] = "Payment Period is required.";
	    }
	    if (!emi) {
	        validationErrors["emi-error"] = "EMI calculation is required.";
	    }
	    if (!trialCalculationId) {
	        validationErrors["trialCalculationId-error"] = "trialCalculationId is required.";
	    }
	    if (!trialCalculationNumber) {
	        validationErrors["trialCalculationNumber-error"] = "trialCalculationNumber is required.";
	    }

	    // Display Validation Errors
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	            errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }

	    // Clear Errors for Valid Fields
	    const allErrorFields = document.querySelectorAll('.error-message');
	    allErrorFields.forEach(field => {
	        if (!validationErrors[field.id]) {
	            field.style.display = "none";
	            field.textContent = "";
	        }
	    });

	    // Return Validation Result
	    return Object.keys(validationErrors).length === 0;
	}
	
	function updateTrialCalculation() {
		var isValid = validateSaveTrialCalculation();
		if (isValid) {
			const stakeholderId = document.getElementById('stakeholderId').value.trim();
			const trialCalculationNumber = document.getElementById('trialCalculationNumber').value.trim();
			const trialCalculationId = document.getElementById('trialCalculationId').value.trim();
		    const capitalAmount = document.getElementById('capitalAmount').value.trim();
		    const interestRate = document.getElementById('interestRate').value.trim();
		    const paymentPeriod = document.getElementById('paymentPeriod').value.trim();
		    const emi = document.getElementById('emi').value.trim();
		    
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
								if (response.result.successmsg) {
									alert(response.result.successmsg);
									clearInputFields();
									getAllTrialCalculations();
								}
							}
						} catch (e) {
							console.error('Invalid response:', e);
							alert('An error occurred while processing the server response.');
						}
					} else {
						console.error('Request failed with status:', this.status);
						alert('Failed to create user group. Please try again.');
					}
				}
			};

			// Open and send the POST request
			xhttp.open("POST", "/Trial_Calculator/trialCalculationAction-createTrialCalculation?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "trialCalculation.stakeholderId=" + stakeholderId + 
			"&trialCalculation.capitalAmount=" + capitalAmount+ 
			"&trialCalculation.interestRate=" + interestRate + 
			"&trialCalculation.emi=" + emi + 
			"&trialCalculation.noOfMonth=" + paymentPeriod;
			xhttp.send(data);
		}
	}
	function clearInputFields() {
		document.getElementById('stakeholderId').value="";
		document.getElementById('trialCalculationId').value="";
		document.getElementById('trialCalculationNumber').value="";
	    document.getElementById('stakeholderName').value="";
	    document.getElementById('capitalAmount').value="";
	    document.getElementById('interestRate').value="";
	    document.getElementById('paymentPeriod').value="";
	    document.getElementById('emi').value="";
	}

</script>
</head>
<body onload="getAllTrialCalculations()">
	<div class="home-content">
		<h2>View/Renew Trial Calculations</h2>
		<div class="form-container">
			<form action="calculateEMI" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label>Stakeholder ID</label> <input type="text"
							id="stakeholderId" name="stakeholderId" required
							readonly="readonly"
							onclick="clearErrorMessages('stakeholderId-error')">
						<p id="stakeholderId-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Stakeholder Name</label> <input type="text"
							id="stakeholderName" name="stakeholderName" required
							readonly="readonly"
							onclick="clearErrorMessages('stakeholderName-error')">
						<p id="stakeholderName-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label>Trial Calculation ID</label> <input type="text"
							id="trialCalculationId" name="trialCalculationId"
							readonly="readonly"
							onclick="clearErrorMessages('trialCalculationId-error')">
						<p id="trialCalculationId-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Trial Calculation Number</label> <input type="text"
							id="trialCalculationNumber" name="trialCalculationNumber"
							readonly="readonly"
							onclick="clearErrorMessages('trialCalculationNumber-error')">
						<p id="trialCalculationNumber-error" class="validationerror"></p>
					</div>
				</div>
				<!-- Loan Amount, Annual Interest Rate, and Payment Period -->
				<div class="form-group">
					<div class="form-group-element">
						<label>Capital Amount</label> <input type="number"
							id="capitalAmount" name="capitalAmount" required
							onclick="clearErrorMessages('capitalAmount-error')">
						<p id="capitalAmount-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Annual Interest Rate (%)</label> <input type="number"
							step="0.01" id="interestRate" name="interestRate" required
							onclick="clearErrorMessages('interestRate-error')">
						<p id="interestRate-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Payment Period (Months)</label> <select id="paymentPeriod"
							name="paymentPeriod" required
							onclick="clearErrorMessages('paymentPeriod-error')">
							<option value="">Select...</option>
							<%
								for (int i = 1; i <= 128; i++) {
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
								}
							%>
						</select>
						<p id="paymentPeriod-error" class="validationerror"></p>
					</div>
				</div>

				<!-- Calculate and Clear Buttons -->
				<div class="form-actions">
					<button type="button" onclick="calculateEmi()">Calculate</button>
				</div>

				<div class="form-group">
					<div class="form-group-element">
						<label>Equated Monthly Installment (EMI)</label> <input
							type="text" id="emi" name="emi" readonly
							onclick="clearErrorMessages('emi-error')">
						<p id="emi-error" class="validationerror"></p>
					</div>
				</div>

				<div class="form-actions">
					<button type="button" onclick="generateSchedule()">Schedule</button>
					<button type="button" onclick="updateTrialCalculation()">Save</button>
				</div>
			</form>
		</div>

		<div class="search-container">
			<h3>Trial Calculations</h3>
			<div class="search-box">
				<input type="text" id="searchInput"
					placeholder="TC Number">
				<button onclick="filterTable('stakeholertbl', 'searchInput')">
					<i class='bx bx-search'></i>
				</button>
			</div>
		</div>
		<div class="table-container">
			<table id="stakeholertbl">
				<thead>
					<tr>
						<th>Trial Calculation Number</th>
						<th>Stakeholder Id</th>
						<th>Date Time</th>
					</tr>
				</thead>
				<tbody id="tbody">

				</tbody>
			</table>
		</div>

		<div id="scheduleModal" class="modal">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal()">&times;</span>
				<h3>Loan Schedule</h3>
				<div class="schedule-container">
					<table id="schedule">
						<thead>
							<tr>
								<th>EMI No</th>
								<th>Installment</th>
								<th>Interest</th>
								<th>Capital</th>
								<th>Capital Balance</th>
							</tr>
						</thead>
						<tbody id="scheduleBody">
							<!-- Dynamic rows will go here -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
</body>
</html>
