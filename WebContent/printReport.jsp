<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create User Groups</title>
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/createusergroups.css" />
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<script src="js/common.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

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
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
	width: 100%;
	display: flex;
	flex-wrap: wrap;
}

.form-group-element {
	flex: 1;
	box-sizing: border-box;
	padding: 0 20px;
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
}

.form-group input {
	width: 96%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.form-actions {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	gap: 5px;
}

.form-actions button {
	padding: 10px 20px;
	background: #439c47;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 90px;
}

.form-actions button:hover {
	background: #38833d;
}

.access-modules {
	margin-top: 10px;
}

.module {
	margin-bottom: 10px;
}

.submodules {
	margin-left: 20px;
	margin-top: 10px;
}

.access-modules label {
	font-weight: normal;
	display: block;
	vertical-align: top;
	padding-left: 25px;
	position: relative;
	margin-bottom: 8px;
}

.access-modules input[type=checkbox] {
	position: absolute;
	left: 0;
	top: 0;
	margin-left: 100px;
}

.topic-label {
	font-weight: bold;
	margin-left: 10px;
}

.select-group {
	display: flex;
	gap: 10px;
}

.select-group select, .select-group input {
	width: 100%;
	padding: 8px; /* Adjusted padding for select boxes */
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left; /* Align text to the left */
}

.table-container {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

.modal-btn {
	margin-right: 8px;
}
</style>
<script type="text/javascript">
	function openModal(reportId, reportName) {
		document.getElementById("scheduleModal").style.display = "block";
		document.getElementById("reportCategoryId").value = reportId;
		document.getElementById("reportName").value = reportName;
	}
	function openModal2(reportId, reportName) {
		document.getElementById("stakeholderModal").style.display = "block";
		document.getElementById("reportCategoryId").value = reportId;
		document.getElementById("reportName").value = reportName;
	}
	function closeModal() {
		document.getElementById("scheduleModal").style.display = "none";
		document.getElementById("stakeholderModal").style.display = "none";
	}

	// Close modal when clicking outside of it
	window.onclick = function(event) {
		const modal = document.getElementById("scheduleModal");
		const modal2 = document.getElementById("stakeholderModal");
		if (event.target === modal) {
			modal.style.display = "none";
		}if (event.target === modal2) {
			modal.style.display = "none";
		}
	};

	function dateValidation() {
	    const fromDate = document.getElementById("fromDate").value;
	    const toDate = document.getElementById("toDate").value;
	    const currentDate = new Date().toISOString().split("T")[0]; // Current date in YYYY-MM-DD format

	    // Object to store validation errors
	    const validationErrors = {};

	    // Validate fromDate
	    if (!fromDate) {
	        validationErrors["fromDate-error"] = "From Date is required.";
	    }

	    // Validate toDate
	    if (!toDate) {
	        validationErrors["toDate-error"] = "To Date is required.";
	    }

	    // Additional date validations
	    if (fromDate && toDate) {
	        if (new Date(fromDate) > new Date(toDate)) {
	            validationErrors["fromDate-error"] = "From Date must be earlier than To Date.";
	        }

	        if (new Date(toDate) > new Date(currentDate)) {
	            validationErrors["toDate-error"] = "To Date cannot exceed the current date.";
	        }
	    }

	    // Display errors
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	            errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }

	    // Hide error messages for fields that have no errors
	    const errorFields = ["fromDate-error", "toDate-error"];
	    for (const fieldId of errorFields) {
	        if (!validationErrors[fieldId]) {
	            const errorField = document.getElementById(fieldId);
	            if (errorField) {
	                errorField.style.display = "none";
	            }
	        }
	    }

	    // Return true if no errors, false otherwise
	    return Object.keys(validationErrors).length === 0;
	}
	
	function stakeholderNameValidation(){
		 const stakeholderId = document.getElementById('stakeholderId').value.trim();
		    const stakeholderName = document.getElementById('stakeholderName').value.trim();

		    const validationErrors = {};

		    // Validate Stakeholder ID (e.g., non-empty, alphanumeric)
		    if (!stakeholderId) {
		        validationErrors["stakeholderId-error"] = "Stakeholder ID is required.";
		    }

		    // Validate Stakeholder Name (e.g., non-empty, only letters and spaces)
		    if (!stakeholderName) {
		        validationErrors["stakeholderName-error"] = "Stakeholder Name is required.";
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
	
	function generateStakeholderTCReport(){
		var isValid = stakeholderNameValidation();
		if(isValid){
			const stakeholderId = document.getElementById('stakeholderId').value.trim();
			const reportCategoryId = document.getElementById("reportCategoryId").value;
			
			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("generateStakeholderTCReport");
							console.log(response);

							if (response.result.error) {
								alert(response.result.error);
							}

							else {
								if (response.result.success === true) {
									alert(response.result.successmsg)
									fetchDataAndOpenReport(response.result.report.tc);
								}
							}
							
						} catch (e) {
							console.error('Invalid response:', e);
							alert('An error occurred while processing the server response.');
						}
					} else {
						console.error('Request failed with status:',
								this.status);
						alert('Failed to Login. Please try again.');
					}
				}
			};

			// Open and send the POST request
			xhttp.open("POST", "/Trial_Calculator/reportAction-generateReport?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "reportGen.reportCategoryId=" + reportCategoryId+"&reportGen.stakeholderId="+stakeholderId;
			console.log(data);
			xhttp.send(data);
		}
	}
	function generateReport(){
		var isValid = dateValidation();
		if(isValid){
			const fromDate = document.getElementById("fromDate").value;
			const toDate = document.getElementById("toDate").value;
			const reportCategoryId = document.getElementById("reportCategoryId").value;
			
			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("generateReport");
							console.log(response.result.report);

							if (response.result.error) {
								alert(response.result.error);
							}

							else {
								if (response.result.success === true) {
									alert(response.result.successmsg)
									fetchDataAndOpenReport(response.result.report.report);
								}
							}
							
						} catch (e) {
							console.error('Invalid response:', e);
							alert('An error occurred while processing the server response.');
						}
					} else {
						console.error('Request failed with status:',
								this.status);
						alert('Failed to Login. Please try again.');
					}
				}
			};

			// Open and send the POST request
			xhttp.open("POST", "/Trial_Calculator/reportAction-generateReport?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "reportGen.fromDate=" + fromDate + "&reportGen.toDate="
					+ toDate + "&reportGen.reportCategoryId=" + reportCategoryId;
			console.log(data);
			xhttp.send(data);
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
	function openReportInNewWindow(dataArray) {
	    if (!dataArray || dataArray.length === 0) {
	        alert("No data available to display.");
	        return;
	    }

	    // Dynamically generate the table head based on object keys
	    var tableHead = '<thead><tr>';
	    var keys = Object.keys(dataArray[0]); // Get keys from the first object
	    for (var i = 0; i < keys.length; i++) {
	        tableHead += '<th>' + capitalize(keys[i]) + '</th>';
	    }
	    tableHead += '</tr></thead>';

	    // Dynamically generate the table body based on object values
	    var tableBody = '<tbody>';
	    for (var j = 0; j < dataArray.length; j++) {
	        var row = dataArray[j];
	        tableBody += '<tr>';
	        for (var k = 0; k < keys.length; k++) {
	            var cellValue = row[keys[k]];

	            // Format date fields (optional, based on your data structure)
	            if (keys[k].toLowerCase().includes('date')) {
	                cellValue = new Date(cellValue).toLocaleDateString();
	            }
	            if (!isNaN(keys[k])) {
	                cellValue = formatNumber(keys[k]);
	            }

	            tableBody += '<td>' + (cellValue || '') + '</td>';
	        }
	        tableBody += '</tr>';
	    }
	    tableBody += '</tbody>';

	    // Combine head and body
	    var tableContent = '<table border="1" style="width: 100%; border-collapse: collapse;">' + tableHead + tableBody + '</table>';
	    var reportHeader = document.getElementById("reportName").value;
	    const fromDate = document.getElementById("fromDate").value;
		const toDate = document.getElementById("toDate").value;
		const stakeholderName = document.getElementById("stakeholderName").value;
		var h5Inner = "-";
		if(stakeholderName !== ""){
			h5Inner = "Stakeholder Name : "+stakeholderName;
		}
		else{
			h5Inner = 'From :'+fromDate+'&nbsp;&nbsp;To : '+toDate;
		}
	    // Open the report in a new window
	    var reportWindow = window.open("", "_blank");

	    // Write the full HTML content for the report
	    reportWindow.document.write(
	        '<!DOCTYPE html>' +
	        '<html>' +
	        '<head>' +
	        '<title>Stakeholder Report</title>' +
	        '<style>' +
	        'table { font-family: Arial, sans-serif; font-size:12px; border-collapse: collapse; width: 100%; }' +
	        'th, td { border: 1px solid #ddd; text-align: left; padding: 8px; }' +
	        'th { background-color: #439c47; color: white; }' +
	        ' h1 { text-align: center; color: #439c47; }'+
	        ' h5 { text-align: right; }'+
	        '</style>' +
	        '</head>' +
	        '<body>' +
	        '<h1>'+reportHeader+'</h1><h5>'+h5Inner+'</h5>' +
	        tableContent +
	        '</body>' +
	        '</html>'
	    );

	    reportWindow.document.close(); // Close the document stream

	    // Automatically print the report
	    reportWindow.print();
	    closeModal();

	    // Utility function to capitalize the first letter of table headers
	    function capitalize(string) {
	        return string.charAt(0).toUpperCase() + string.slice(1).replace(/([A-Z])/g, ' $1'); // Adds space before camelCase words
	    }
	}


 // Function to fetch data and open the report
	        function fetchDataAndOpenReport(stakeholders) {
	            openReportInNewWindow(stakeholders);
	        }
 
	        function loadStakeholders() {
	    		window.open('viewstakeholders.jsp', 'ChildWindow',
	    				'width=900,height=400,resizable=yes,scrollbars=yes');
	    	}
</script>

</head>
<body>
	<div class="home-content">
		<h2>Generate Report</h2>
		<div class="form-container">
			<table id="stakeholertbl">
				<thead>
					<tr>
						<th style="display: none;">Stakeholder Id</th>
						<th>Report</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<tr onclick="openModal(1,'Stakeholders Report')">
						<td>Stakeholders Report</td>
					</tr>
					<!-- <tr onclick="openModal(2, 'Loan Applications Report')">
						<td>Loan Applications Report</td>
					</tr> -->
					<tr onclick="openModal(3 , 'Trial Calculations Report')">
						<td>Trial Calculations Report</td>
					</tr>
					<tr onclick="openModal2(5,'Stakeholder Trial Calculations Report')">
						<td>Stakeholder Trial Calculations Report</td>
					</tr>
					<tr onclick="openModal2(6,'Stakeholder Applications Report')">
						<td>Stakeholder Applications Report</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- <div class="form-actions">
			<button type="button" onclick="generateReport()" id="btn-submit">
				<i class='bx bx-printer'></i>&nbsp;&nbsp;Print
			</button>
		</div> -->
		<div id="scheduleModal" class="modal">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal()">&times;</span>
				<h3>Select date range</h3>
				<div class="schedule-container">
					<form action="" method="post">
						<div class="form-group">
							<div class="form-group-element">
								<label for="fromDate">From</label> <input type="date"
									id="fromDate" name="fromDate" required
									onclick="clearErrorMessages('fromDate-error')"> <input
									type="hidden" id="reportName" name="reportName" required>
								<input type="hidden" id="reportCategoryId"
									name="reportCategoryId" required>
								<p id="fromDate-error" class="validationerror"></p>
							</div>
							<div class="form-group-element">
								<label for="toDate">To</label> <input type="date" id="toDate"
									name="toDate" required
									onclick="clearErrorMessages('toDate-error')">
								<p id="toDate-error" class="validationerror"></p>
							</div>
						</div>
						<div class="form-actions modal-btn">
							<button type="button" onclick="generateReport()" id="btn-submit">
								<i class='bx bx-printer'></i>&nbsp;&nbsp;Print
							</button>
							<button type="reset"
								id="btn-submit">Clear</button>
						</div>
					</form>
				</div>
			</div>
		</div>


		<div id="stakeholderModal" class="modal">
			<div class="modal-content">
				<span class="close-button" onclick="closeModal()">&times;</span>
				<h3>Select Stakeholder</h3>
				<div class="schedule-container">
					<form action="" method="post">
						<div class="form-group">
							<div class="form-group-element">
								<label>Stakeholder ID</label>
								<div class="form-group-element-button">
									<input class="stakeholer-id-input" type="text"
										id="stakeholderId" name="stakeholderId" required
										readonly="readonly"
										onclick="clearErrorMessages('stakeholderId-error')"><input
										type="hidden" id="reportName" name="reportName" required>
									<button type="button" onclick="loadStakeholders()">...</button>
								</div>
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
						<div class="form-actions modal-btn">
							<button type="button" onclick="generateStakeholderTCReport()"
								id="btn-submit">
								<i class='bx bx-printer'></i>&nbsp;&nbsp;Print
							</button>
							<button type="reset"
								id="btn-submit">Clear</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>