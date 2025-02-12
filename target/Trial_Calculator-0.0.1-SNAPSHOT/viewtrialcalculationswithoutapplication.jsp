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
<script src="js/common.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

body {
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table th, table td {
	text-align: left;
	padding: 10px;
	border: 1px solid #ddd;
}

table th {
	background: #242424;
	color: #fff;
}

table tr:hover {
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
	function getAllTrialCalculationsWithoutApplication() {
		const stakeholderName = window.opener.document
				.getElementById('stakeholderName').value;
		const stakeholderId = window.opener.document
				.getElementById('stakeholderId').value;
		document.getElementById('stkName').textContent = "Stakeholder : "
				+ stakeholderName;
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						console
								.log("getAllTrialCalculationsWithoutApplication");
						console.log(response);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.trialCalculations) {
							setTableData(response.result.trialCalculations);
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
		xhttp
				.open(
						"POST",
						"/Trial_Calculator/trialCalculationAction-getAllTrialCalculationsWithoutApplicationsByStakeHolderId?t="
								+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "trialCalculation.stakeholderId=" + stakeholderId;
		xhttp.send(data);
	}
	function setTableData(trialCalculations) {
		const tbody = document.getElementById('tbody');
		tbody.innerHTML = "";

		for (var i = 0; i < trialCalculations.length; i++) {
			const tr = document.createElement('tr');

			tr.innerHTML = "<td style='display: none;'>"
					+ trialCalculations[i].stakeholderId
					+ "</td><td style='display: none;'>"
					+ trialCalculations[i].trialCalculationId + "</td><td>"
					+ trialCalculations[i].trialCalculationNumber + "</td><td>"
					+ trialCalculations[i].capitalAmount + "</td><td>"
					+ trialCalculations[i].interestRate + "</td><td>"
					+ trialCalculations[i].noOfMonth + "</td><td>"
					+ trialCalculations[i].emi + "</td><td>"
					+ trialCalculations[i].timestamp + "</td>";

			tr.addEventListener('click', function() {
				getTrialCalcutation(event);
			});

			tbody.appendChild(tr);
		}
	}

	function getTrialCalcutation(event) {
		console.log("getTrialCalcutation(event);");

		const clickedRow = event.currentTarget;
		const cells = clickedRow.children;

		const stakeholderId = cells[0].textContent;
		const trialCalculationId = cells[1].textContent;
		const trialCalculationNumber = cells[2].textContent;
		sendToParent(trialCalculationId, trialCalculationNumber);
	}
	function sendToParent(trialCalculationId, trialCalculationNumber) {
		if (window.opener && !window.opener.closed) {
			window.opener.document.getElementById('trialCalculationId').value = trialCalculationId;
			window.opener.document.getElementById('trialCalculationNumber').value = trialCalculationNumber;
			window.close(); // Close the child window
		} else {
			alert('Parent window is not accessible.');
		}
	}
</script>
</head>
<body onload="getAllTrialCalculationsWithoutApplication()">
	<div class="search-container">
		<h4 id="stkName"></h4>
		<h3>Trial Calculations</h3>
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
					<th style="display: none;">Stakeholder Id</th>
					<th style="display: none;">Trial Cal Id</th>
					<th>Trial Cal Number</th>
					<th>Capital Amount</th>
					<th>Interest Rate</th>
					<th>Payment Period</th>
					<th>EMI</th>
					<th>TimeStamp</th>
				</tr>
			</thead>
			<tbody id="tbody">

			</tbody>
		</table>
	</div>
</body>
</html>
