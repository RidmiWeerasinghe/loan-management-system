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
	function getAllStakeholders() {
		const
		xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const
						response = JSON.parse(this.responseText);
						console.log("getAllStakeholders");
						console.log(response);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.stakeholders) {
							setTableData(response.result.stakeholders);
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
				"/Trial_Calculator/stakeholderAction-getAllStakeholders?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}
	function setTableData(stakeholders) {
		const
		tbody = document.getElementById('tbody');
		tbody.innerHTML = "";

		for (var i = 0; i < stakeholders.length; i++) {
			const
			tr = document.createElement('tr');

			tr.innerHTML = "<td style='display: none;'>" + stakeholders[i].stakeholderId + "</td>"
					+ "<td>" + stakeholders[i].nic
					+ "</td>" + "<td>" + stakeholders[i].firstName + "</td>"
					+ "<td>" + stakeholders[i].lastName + "</td>"
					+ "<td style='display: none;'>" + stakeholders[i].fullName
					+ "</td>" + "<td>" + stakeholders[i].dateOfBirth + "</td>"
					+ "<td>" + stakeholders[i].gender + "</td>" + "<td>"
					+ stakeholders[i].phone + "</td>" + "<td>"
					+ stakeholders[i].email + "</td>"
					+ "<td style='display: none;'>"
					+ stakeholders[i].occupation + "</td>"
					+ "<td style='display: none;'>" + stakeholders[i].addressId
					+ "</td>";

			tr.addEventListener('click', function() {
				getStakeHolder(event);
			});

			tbody.appendChild(tr);
		}
	}

	function getStakeHolder(event) {
		console.log("getStakeHolder(event);");

		const
		clickedRow = event.currentTarget;
		const
		cells = clickedRow.children;

		const
		stakeholderId = cells[0].textContent;
		const
		nic = cells[1].textContent;
		const
		firstName = cells[2].textContent;
		const
		lastName = cells[3].textContent;
		const
		fullName = cells[4].textContent;
		const
		dob = cells[5].textContent;
		const
		gender = cells[6].textContent;
		const
		phone = cells[7].textContent;
		const
		email = cells[8].textContent;
		const
		occupation = cells[9].textContent;
		const
		addressId = cells[10].textContent;
		sendToParent(stakeholderId, fullName);
	}
	function sendToParent(stakeholderId, stakeholderName) {
		// Access the input box in the parent window
		console.log(stakeholderName);
		if (window.opener && !window.opener.closed) {
			window.opener.document.getElementById('stakeholderId').value = stakeholderId;
			window.opener.document.getElementById('stakeholderName').value = stakeholderName;
			window.close(); // Close the child window
		} else {
			alert('Parent window is not accessible.');
		}
	}
</script>
</head>
<body onload="getAllStakeholders()">
	<div class="search-container">
		<h3>Stakeholders</h3>
		<div class="search-box">
			<input type="text" id="searchInput"
				placeholder="Search by Stakeholder NIC">
			<button onclick="filterTable('stakeholertbl', 'searchInput')">
				<i class='bx bx-search'></i>
			</button>
		</div>
	</div>
	<div class="table-container">
		<table id="stakeholertbl">
			<thead>
				<tr>
					<th style="display: none;">Stakeholder Id</th>
					<th>NIC</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th style="display: none;">Full Name</th>
					<th>Date of Birth</th>
					<th>Gender</th>
					<th>Phone</th>
					<th>Email</th>
					<th style="display: none;">Occupation</th>
					<th style="display: none;">AddressId</th>
				</tr>
			</thead>
			<tbody id="tbody">
				
			</tbody>
		</table>
	</div>
</body>
</html>
