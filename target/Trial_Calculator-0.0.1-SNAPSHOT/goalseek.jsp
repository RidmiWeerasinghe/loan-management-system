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
	gap: 4px;
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
function clearForm() {
	document.querySelector('form').reset();
}

function openModal() {
	document.getElementById("scheduleModal").style.display = "block";
}

function closeModal() {
	document.getElementById("scheduleModal").style.display = "none";
}

window.onclick = function (event) {
	const
		modal = document.getElementById("scheduleModal");
	if (event.target === modal) {
		modal.style.display = "none";
	}
};

function vaidateEmiCal() {
	const capitalAmount = unformatNumber(document.getElementById('capitalAmount').value.trim());
	const interestRate = unformatNumber(document.getElementById('interestRate').value.trim());
	const paymentPeriod = unformatNumber(document.getElementById('paymentPeriod').value.trim());

	const validationErrors = {};

	// Validate Capital Amount (e.g., non-empty, numeric, positive)
	if (!capitalAmount) {
		validationErrors["capitalAmount-error"] = "Capital Amount is required.";
	} else if (isNaN(capitalAmount) || parseFloat(capitalAmount) <= 0) {
		validationErrors["capitalAmount-error"] = "Capital Amount must be a positive number.";
	}

	// Validate Interest Rate (e.g., non-empty, numeric, between 0 and
	// 100)
	if (!interestRate) {
		validationErrors["interestRate-error"] = "Interest Rate is required.";
	} else if (isNaN(interestRate) || parseFloat(interestRate) <= 0 || parseFloat(interestRate) > 100) {
		validationErrors["interestRate-error"] = "Interest Rate must be a number between 0 and 100.";
	}

	// Validate Payment Period (e.g., non-empty, integer, positive)
	if (!paymentPeriod) {
		validationErrors["paymentPeriod-error"] = "Payment Period is required.";
	} else if (isNaN(paymentPeriod) || !Number.isInteger(parseFloat(paymentPeriod)) || parseInt(paymentPeriod) <= 0) {
		validationErrors["paymentPeriod-error"] = "Payment Period must be a positive integer.";
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

function validateCapitalCal() {
	const interestRate = unformatNumber(document.getElementById('interestRate').value.trim());
	const paymentPeriod = unformatNumber(document.getElementById('paymentPeriod').value.trim());
	const emi = unformatNumber(document.getElementById('emi').value.trim());

	const validationErrors = {};

	// Validate Interest Rate (e.g., non-empty, numeric, between 0 and
	// 100)
	if (!interestRate) {
		validationErrors["interestRate-error"] = "Interest Rate is required.";
	} else if (isNaN(interestRate) || parseFloat(interestRate) <= 0 || parseFloat(interestRate) > 100) {
		validationErrors["interestRate-error"] = "Interest Rate must be a number between 0 and 100.";
	}

	// Validate Payment Period (e.g., non-empty, integer, positive)
	if (!paymentPeriod) {
		validationErrors["paymentPeriod-error"] = "Payment Period is required.";
	} else if (isNaN(paymentPeriod) || !Number.isInteger(parseFloat(paymentPeriod)) || parseInt(paymentPeriod) <= 0) {
		validationErrors["paymentPeriod-error"] = "Payment Period must be a positive integer.";
	}

	// Validate EMI (e.g., non-empty, numeric, positive)
	if (!emi) {
		validationErrors["emi-error"] = "EMI is required.";
	} else if (isNaN(emi) || parseFloat(emi) <= 0) {
		validationErrors["emi-error"] = "EMI must be a positive number.";
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

function validateRateCal() {
	const capitalAmount = unformatNumber(document.getElementById('capitalAmount').value.trim());
	const paymentPeriod = unformatNumber(document.getElementById('paymentPeriod').value.trim());
	const emi = unformatNumber(document.getElementById('emi').value.trim());

	const validationErrors = {};

	// Validate Capital Amount (e.g., non-empty, numeric, positive)
	if (!capitalAmount) {
		validationErrors["capitalAmount-error"] = "Capital Amount is required.";
	} else if (isNaN(capitalAmount) || parseFloat(capitalAmount) <= 0) {
		validationErrors["capitalAmount-error"] = "Capital Amount must be a positive number.";
	}

	// Validate Payment Period (e.g., non-empty, integer, positive)
	if (!paymentPeriod) {
		validationErrors["paymentPeriod-error"] = "Payment Period is required.";
	} else if (isNaN(paymentPeriod) || !Number.isInteger(parseFloat(paymentPeriod)) || parseInt(paymentPeriod) <= 0) {
		validationErrors["paymentPeriod-error"] = "Payment Period must be a positive integer.";
	}

	// Validate EMI (e.g., non-empty, numeric, positive)
	if (!emi) {
		validationErrors["emi-error"] = "EMI is required.";
	} else if (isNaN(emi) || parseFloat(emi) <= 0) {
		validationErrors["emi-error"] = "EMI must be a positive number.";
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

function validatePeriodCal() {
	const capitalAmount = unformatNumber(document.getElementById('capitalAmount').value.trim());
	const interestRate = unformatNumber(document.getElementById('interestRate').value.trim());
	const emi = unformatNumber(document.getElementById('emi').value.trim());

	const validationErrors = {};

	// Validate Capital Amount (e.g., non-empty, numeric, positive)
	if (!capitalAmount) {
		validationErrors["capitalAmount-error"] = "Capital Amount is required.";
	} else if (isNaN(capitalAmount) || parseFloat(capitalAmount) <= 0) {
		validationErrors["capitalAmount-error"] = "Capital Amount must be a positive number.";
	}

	// Validate Interest Rate (e.g., non-empty, numeric, between 0 and
	// 100)
	if (!interestRate) {
		validationErrors["interestRate-error"] = "Interest Rate is required.";
	} else if (isNaN(interestRate) || parseFloat(interestRate) <= 0 || parseFloat(interestRate) > 100) {
		validationErrors["interestRate-error"] = "Interest Rate must be a number between 0 and 100.";
	}

	// Validate EMI (e.g., non-empty, numeric, positive)
	if (!emi) {
		validationErrors["emi-error"] = "EMI is required.";
	} else if (isNaN(emi) || parseFloat(emi) <= 0) {
		validationErrors["emi-error"] = "EMI must be a positive number.";
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

function generateSchedule() {
    const scheduleBtn = document.getElementById('scheduleBtn');
    scheduleBtn.innerText = "Loading...";

    // Allow the button text to update before continuing the processing
    setTimeout(() => {
        const emivalue = unformatNumber(document.getElementById('emi').value);
        var capitalAmount = unformatNumber(document.getElementById('capitalAmount').value);
        const interestRate = unformatNumber(document.getElementById('interestRate').value);
        const paymentPeriod = unformatNumber(document.getElementById('paymentPeriod').value);

        if (emivalue === "") {
            alert("Calculate the result to generate schedule");
            scheduleBtn.innerText = "Schedule"; // Reset the button text
            return;
        }

        const emi = calculateEmiValue(capitalAmount, interestRate, paymentPeriod);
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
        scheduleBtn.innerText = "Schedule"; // Reset the button text
    }, 100); // Slight delay (100ms) to ensure the UI updates
}


function emiOnblur() {
	const emi = formatNumber(document.getElementById('emi').value.trim());
	document.getElementById('emi').value = emi;
}
function monthOnblur() {
}
function rateOnblur() {
	const annualRate = formatNumber(document.getElementById('interestRate').value.trim());
	document.getElementById('interestRate').value = annualRate;
}
function capitalAmountOnblur() {
	const capitalAmount = formatNumber(document.getElementById('capitalAmount').value.trim());
	document.getElementById('capitalAmount').value = capitalAmount;
}
// Function to calculate the EMI
function calculateEmi() {
	var isValid = validateEmiCalculation();
	if (isValid) {
		const capitalAmount = document.getElementById('capitalAmount').value;
		const interestRate = document.getElementById('interestRate').value;
		const paymentPeriod = document.getElementById('paymentPeriod').value;

		const emi = calculateEmiValue(capitalAmount, interestRate, paymentPeriod);
		document.getElementById('emi').value = emi.toFixed(2);
	}
}

// Helper function to calculate EMI
function calculateEmiValue(capitalAmount, annualRate, paymentPeriod) {
	const monthlyRate = annualRate / 12 / 100;
	return (
		(capitalAmount * monthlyRate * Math.pow(1 + monthlyRate, paymentPeriod)) /
		(Math.pow(1 + monthlyRate, paymentPeriod) - 1)
	);
}

// Function to calculate the monthly interest rate
function calculateMonthlyRate(annualRate) {
	return annualRate / 12 / 100;
}

// Function to calculate capital
function calculateCapital(emi, annualRate, paymentPeriod) {
	const monthlyRate = annualRate / 12 / 100;
	return (
		emi * (Math.pow(1 + monthlyRate, paymentPeriod) - 1) /
		(monthlyRate * Math.pow(1 + monthlyRate, paymentPeriod))
	);
}

// Function to calculate payment period
function calculatePaymentPeriod(emi, capitalAmount, annualRate) {
    const monthlyRate = annualRate / 12 / 100;

    const denominator = emi - capitalAmount * monthlyRate;

    if (denominator <= 0) {
        console.error("Invalid calculation: Denominator is less than or equal to zero.");
        return NaN;
    }

    const numerator = emi / denominator;
    console.log("Numerator (emi / denominator):", numerator);

    if (numerator <= 0) {
        console.error("Invalid calculation: Numerator is less than or equal to zero.");
        return NaN;
    }

    const period = Math.log(numerator) / Math.log(1 + monthlyRate);
    console.log("Payment Period:", period);

    return period;
}


// Function to calculate interest rate iteratively
function calculateInterestRate(emi, capitalAmount, paymentPeriod) {
	let low = 0; // Lower bound for annual interest rate
	let high = 100; // Upper bound for annual interest rate
	const tolerance = 0.0001; // Precision tolerance for the result

	while (high - low > tolerance) {
		const mid = (low + high) / 2;
		const monthlyRate = mid / 12 / 100;
		const calculatedEmi = calculateEmiValue(capitalAmount, mid, paymentPeriod);

		if (calculatedEmi > emi) {
			high = mid; // Too high, reduce the rate
		} else {
			low = mid; // Too low, increase the rate
		}
	}

	return (low + high) / 2;
	// Approximate annual interest rate
}

function disableFields() {
	// clearForm();
	const type = document.getElementById('type').value;

	document.getElementById("emi").disabled = false;
	document.getElementById("interestRate").disabled = false;
	document.getElementById("capitalAmount").disabled = false;
	document.getElementById("paymentPeriod").disabled = false;
	console.log(type);
	switch (type) {
		case "emi":
			document.getElementById("emi").disabled = true;
			break;
		case "rate":
			document.getElementById("interestRate").disabled = true;
			break;
		case "capital":
			document.getElementById("capitalAmount").disabled = true;
			break;
		case "period":
			document.getElementById("paymentPeriod").disabled = true;
			break;
	}
}


function formatNumber(value) {
	if (!isNaN(value)) {

		return parseFloat(value).toLocaleString(undefined, {
			minimumFractionDigits: 2,
			maximumFractionDigits: 2,
		});
	}
	return value;
}

function unformatNumber(value) {
	if (typeof value === "string") {
		return parseFloat(value.replace(/,/g, '')) || value;
	}
	return value;
}

// Main calculate function
function calculate() {
	const capitalAmount = unformatNumber(document.getElementById('capitalAmount').value.trim());
	const annualRate = unformatNumber(document.getElementById('interestRate').value.trim());
	const paymentPeriod = unformatNumber(document.getElementById('paymentPeriod').value.trim());
	const emi = unformatNumber(document.getElementById('emi').value.trim());
	const type = document.getElementById('type').value;

	switch (type) {
		case "emi":
			var isValid = vaidateEmiCal();
			if (isValid) {
				const emiValue = calculateEmiValue(capitalAmount, annualRate, paymentPeriod);
				document.getElementById("emi").value = formatNumber(emiValue);
			}
			break;

		case "rate":
			var isValid = validateRateCal();
			if (isValid) {
				const interestRate = calculateInterestRate(emi, capitalAmount, paymentPeriod);
				document.getElementById("interestRate").value = formatNumber(interestRate);
			}
			break;

		case "capital":
			var isValid = validateCapitalCal();
			if (isValid) {
				const capital = calculateCapital(emi, annualRate, paymentPeriod);
				document.getElementById("capitalAmount").value = formatNumber(capital);
			}
			break;

		case "period":
			document.getElementById("paymentPeriod").value = "";
			var isValid = validatePeriodCal();
			if (isValid) {
		        const period = calculatePaymentPeriod(emi, capitalAmount, annualRate);
		        const roundedPeriod = Math.round(period);
		        // Check if the rounded period is within the valid range (1 to 128)
		        if(isNaN(roundedPeriod)){
		        	document.getElementById("paymentPeriod-error").innerText = "Invalid";
		        }
		        if (roundedPeriod >= 1 && roundedPeriod <= 128) {
		            document.getElementById("paymentPeriod").value = roundedPeriod; // Set the rounded value in the select box
		            document.getElementById("paymentPeriod-error").innerText = ""; // Clear any previous error message
		        } else if(roundedPeriod > 128){
		            // Display an error message if the value is out of range
		            document.getElementById("paymentPeriod-error").innerText = "The payment period can not exceed 128.";
		        }
		    }
			break;
	}
}

</script>
</head>
<body>
	<div class="home-content">
		<h2>Goal Seek</h2>
		<div class="form-container">
			<form action="calculateEMI" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label>Amount to be calculated</label> <select id="type"
							name="type" required onclick="clearErrorMessages('type-error')"
							onchange="disableFields()">
							<option value="emi">Monthly Installment</option>
							<option value="rate">Annual Interest Rate</option>
							<option value="capital">Capital Amount</option>
							<option value="period">Payment Period</option>
						</select>
						<p id="type-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label>Capital Amount</label> <input type="text"
							id="capitalAmount" name="capitalAmount" required
							onclick="clearErrorMessages('capitalAmount-error')"
							onblur="capitalAmountOnblur()">
						<p id="capitalAmount-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Annual Interest Rate (%)</label> <input type="number"
							step="0.01" id="interestRate" name="interestRate" required
							onclick="clearErrorMessages('interestRate-error')"
							onblur="rateOnblur()">
						<p id="interestRate-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label>Payment Period (Months)</label> <select id="paymentPeriod"
							name="paymentPeriod" required
							onclick="clearErrorMessages('paymentPeriod-error')"
							onblur="monthOnblur()">
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

				<div class="form-group">
					<div class="form-group-element">
						<label>Equated Monthly Installment (EMI)</label> <input
							type="text" id="emi" name="emi" onblur="emiOnblur()"
							onclick="clearErrorMessages('emi-error')">
						<p id="emi-error" class="validationerror"></p>
					</div>
				</div>

				<!-- View Schedule Button -->
				<div class="form-actions">
					<button type="button" onclick="calculate()">Calculate</button>
					<button type="button" onclick="generateSchedule()" id="scheduleBtn">Schedule</button>
					<button type="button" onclick="clearForm()">Clear</button>
				</div>
			</form>
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
	</div>
</body>
</html>
