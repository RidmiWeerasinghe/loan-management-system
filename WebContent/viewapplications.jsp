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
	margin: 20px;
	padding: 0;
}

.home-content {
	padding: 20px;
	background-color: #f4f4f4;
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
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
/* pop up */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
	font-size: 13px;
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

#applicationDetails {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

#applicationDetails td {
	padding: 8px 10px;
	border: 1px solid #ddd;
}

#applicationDetails td:first-child {
	background-color: #f9f9f9; /* Light background for labels */
	font-weight: bold;
}

.modal-btn {
	margin-top: 20px;
	padding: 10px 20px;
	background: #439c47;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 90px;
}

.modal-btn-div {
	display: flex;
	justify-content: flex-end;
}
</style>
<script>
	function getAllApplications() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						
						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.allapplications) {
							setTableData(response.result.allapplications);
						}
						else{
							const tbody = document.getElementById('home-content');
							tbody.innerHTML = "<div style='color: red; text-align: center; font-weight: bold;'>No applications are currently available.</div>";
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
				"/Trial_Calculator/applicationActionBean-getAllApplications?t="
						+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
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
			let capitalAmount = "";
			let interestRate = "";
			let noOfMonth = "";
			let emi = "";
			let trialCalTimestamp = "";

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
											capitalAmount = trialCalculation.capitalAmount;
											interestRate = trialCalculation.interestRate;
											noOfMonth = trialCalculation.noOfMonth;
											emi = trialCalculation.emi;
											trialCalTimestamp = trialCalculation.timestamp;

											const tr = document
													.createElement('tr');
											tr.innerHTML = "<td style='display: none;'>"
													+ application.applicationId
													+ "</td><td style='display: none;'>"
													+ application.trialCalculationId
													+ "</td><td style='display: none;'>"
													+ application.stakeholderId
													+ "</td><td>"
													+ application.applicationNumber
													+ "</td><td>"
													+ application.applicationStatus
													+ "</td><td style='display: none;'>"
													+ application.createdUserId
													+ "</td><td style='display: none;'>"
													+ application.createdTimestamp
													+ "</td><td style='display: none;'>"
													+ application.approvedUserId
													+ "</td><td style='display: none;'>"
													+ application.approvedTimestamp
													+ "</td><td style='display: none;'>"
													+ ""
													+ "</td><td style='display: none;'>"
													+ ""
													+ "</td><td>"
													+ stakeholderFullName
													+ "</td><td>"
													+ trialCalculationNumber
													+ "</td><td style='display: none;'>"
													+ formatNumber(capitalAmount)
													+ "</td><td style='display: none;'>"
													+ formatNumber(interestRate)
													+ "</td><td style='display: none;'>"
													+ noOfMonth
													+ "</td><td style='display: none;'>"
													+ formatNumber(emi)
													+ "</td><td style='display: none;'>"
													+ trialCalTimestamp
													+ "</td><td style='display: none;'>"
													+ application.rejectedUserId
													+ "</td><td style='display: none;'>"
													+ application.rejectedTimestamp
													+ "</td>";

											tr.addEventListener('click',
													function() {
														getApplication(event);
													});

											tbody.appendChild(tr);
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
		loadApplicationDetails(cells);

	    loadApplicationDetails(cells);
	    openModal();
	}
	function openModal() {
		document.getElementById("applicationModal").style.display = "block";
	}
	function closeModal() {
		document.getElementById("applicationModal").style.display = "none";
	}
	
	function loadApplicationDetails(cells) {
	    // Map application status codes to their labels
	    let applicationSts = "default";
	    switch (cells[4].textContent) {
	        case "P":
	            applicationSts = "Pending";
	            break;
	        case "A":
	            applicationSts = "Active";
	            break;
	        case "R":
	            applicationSts = "Rejected";
	            break;
	    }

	    // Static details map
	    let detailsMap = [
	        { label: "Application Status", value: applicationSts },
	        { label: "Created User ID", value: cells[5].textContent },
	        { label: "Created Timestamp", value: cells[6].textContent },
	        { label: "Approved User ID", value: cells[7].textContent },
	        { label: "Approved Timestamp", value: cells[8].textContent },
	        { label: "Stakeholder Full Name", value: cells[11].textContent },
	        { label: "Trial Calculation Number", value: cells[12].textContent },
	        { label: "Capital Amount", value: cells[13].textContent },
	        { label: "Interest Rate", value: cells[14].textContent },
	        { label: "Number of Months", value: cells[15].textContent },
	        { label: "EMI", value: cells[16].textContent },
	        { label: "Trial Calculation Timestamp", value: cells[17].textContent },
	        { label: "Rejected User Id", value: cells[18].textContent },
	        { label: "Rejected Timestamp", value: cells[19].textContent }
	    ];

	    // Apply filters based on the application status
	    if (applicationSts === "Pending") {
	        detailsMap = detailsMap.filter(detail =>
	            !["Approved User ID", "Approved Timestamp", "Rejected User Id", "Rejected Timestamp"].includes(detail.label)
	        );
	    }else if (applicationSts === "Active") {
	        detailsMap = detailsMap.filter(detail =>
            !["Rejected User Id", "Rejected Timestamp"].includes(detail.label)
        );
    	}else if (applicationSts === "Rejected") {
	        detailsMap = detailsMap.filter(detail =>
	            !["Approved User ID", "Approved Timestamp"].includes(detail.label)
	        );
	    }

	    // Get the table body for the vertical table
	    const tableBody = document.getElementById("applicationTblBody");
	    document.getElementById("tblTopic").textContent = "Application No : " + cells[3].textContent;

	    // Clear previous rows
	    tableBody.innerHTML = "";

	    // Populate the table with details
	    detailsMap.forEach(detail => {
	        const row = document.createElement("tr");

	        const labelCell = document.createElement("td");
	        labelCell.textContent = detail.label;
	        labelCell.style.fontWeight = "bold"; // Optional: Make the label bold

	        const valueCell = document.createElement("td");
	        valueCell.textContent = detail.value;

	        row.appendChild(labelCell);
	        row.appendChild(valueCell);
	        tableBody.appendChild(row);
	    });
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
	
	function printApplication(divId){
		 var divContent = document.getElementById(divId);
		 var tblTopic = document.getElementById('tblTopic').textContent;

		    if (!divContent) {
		        alert("Content not found!");
		        return;
		    }

		    // Open a new window
		    var printWindow = window.open("", "_blank");

		    // Write the content into the new window
		    printWindow.document.write(
		        '<!DOCTYPE html>' +
		        '<html>' +
		        '<head>' +
		        '<title>Print Report</title>' +
		        '<style>' +
		        '#applicationDetails {width: 100%;border-collapse: collapse;margin-top: 10px;}'+
		        '#applicationDetails td {padding: 8px 10px;border: 1px solid #ddd;}'+
		        '#applicationDetails td:first-child {background-color: #f9f9f9;font-weight: bold;}'+
		        '</style>' +
		        '</head>' +
		        '<body>' +
		        '<h2>'+ tblTopic +'</h2>'+
		        divContent.innerHTML + // Include the content of the div
		        '</body>' +
		        '</html>'
		    );

		    printWindow.document.close(); // Close the document stream

		    // Automatically print the report
		    printWindow.print();
	}
</script>
</head>
<body onload="getAllApplications()">
	<div id="home-content" class="home-content">
		<h2>All Applications</h2>

		<div class="search-container">
			<div class="search-box">
				<input type="text" id="searchInput" placeholder="Application number">
				<button onclick="filterTable('applicationtbl', 'searchInput')">
					<i class='bx bx-search'></i>
				</button>
			</div>
		</div>
		<div class="table-container">
			<table id="applicationtbl">
				<thead>
					<tr>
						<th>Application Number</th>
						<th>Application Status</th>
						<th>Stakeholder Name</th>
						<th>TrialCal Number</th>
					</tr>
				</thead>
				<tbody id="tbody">

				</tbody>
			</table>
		</div>
	</div>
	<div id="applicationModal" class="modal">
		<div class="modal-content">
			<span class="close-button" onclick="closeModal()">&times;</span>
			<h3 id="tblTopic">Application No : 0001</h3>
			<div class="schedule-container" id="applicationDetails-div">
				<table id="applicationDetails">
					<tbody id="applicationTblBody">
						<!-- Dynamic rows will go here -->
					</tbody>
				</table>
			</div>
			<div class="modal-btn-div">
				<button class="modal-btn" type="button"
					onclick="printApplication('applicationDetails-div')"
					id="btn-submit">
					<i class='bx bx-printer'></i>&nbsp;&nbsp;Print
				</button>
			</div>
		</div>
	</div>
</body>
</html>
