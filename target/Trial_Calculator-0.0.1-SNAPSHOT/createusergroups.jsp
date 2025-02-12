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
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	margin: 40px;
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
	padding: 0 10px;
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
	width: 80px;
}

.form-actions button:hover {
	background: #38833d;
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

table tr:hover {
	cursor: pointer;
	background: #eeeeee;
}

table th {
	background: #242424;
	color: #fff;
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
	padding-left: 30px;
	position: relative;
	margin-bottom: 8px;
}

.access-modules input[type=checkbox] {
	position: absolute;
	left: 0;
	top: 0;
	margin-left: 60px;
}

.topic-label {
	font-weight: bold;
	margin-left: 10px;
}
</style>
</head>
<body onload="">
	<div class="home-content">
		<h2>Create User Group</h2>
		<div class="form-container">
			<form action="" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label for="groupCode">Group Code</label> <input type="text"
							id="groupCode" name="groupCode" required
							onkeyup="convertToUpperCase('groupCode')"
							onclick="clearErrorMessages('groupCode-error')" maxlength="3">
						<p id="groupCode-error" class="validationerror"></p>
						<input type="hidden" id="groupId" name="groupId">
					</div>
					<div class="form-group-element">
						<label for="groupDescription">Group Description</label> <input
							type="text" id="groupDescription" name="groupDescription"
							required onclick="clearErrorMessages('groupDescription-error')">
						<p id="groupDescription-error" class="validationerror"></p>
					</div>
				</div>
				<label class="topic-label" for="accessModules">Access
					Modules</label>
				<div class="access-modules">
					<div class="form-group">
						<div class="form-group-element">
							<label>Admin</label>
							<div class="submodules">
								<label><input type="checkbox" name="accessModules"
									value="createuser"> Create User</label> <label><input
									type="checkbox" name="accessModules"
									value="createusergroups"> Create User Group</label>
							</div>
							<label onclick="getAccessModules()">Report</label>
							<div class="submodules">
								<label><input type="checkbox" name="accessModules"
									value="printReport"> Print Report</label>
							</div>
							<label onclick="getAccessModules()">Settings</label>
							<div class="submodules">
								<label><input type="checkbox" name="accessModules"
									value="myprofile">Change Password </label>
							</div>
						</div>
						<div class="form-group-element">
							<div class="module">
								<label>Loan</label>
								<div class="submodules">
									<label><input type="checkbox" name="accessModules"
										value="stakeholders"> Create Stakeholder</label><label><input
										type="checkbox" name="accessModules"
										value="viewupdatestakeholders">View/Update
										Stakeholder</label> <label><input type="checkbox"
										name="accessModules" value="goalseek"> Goal Seek</label> <label><input
										type="checkbox" name="accessModules" value="emicalculator">
										EMI Calculator</label> <label><input type="checkbox"
										name="accessModules" value="viewupdateemicalculator">
										View/Update</label> <label><input type="checkbox"
										name="accessModules" value="createapplication">
										Create Application</label> <label><input type="checkbox"
										name="accessModules" value="viewapplications">
										View Application</label> <label><input type="checkbox"
										name="accessModules" value="applicationapprove">
										Application Approval</label>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="form-actions">
					<button type="button" onclick="userGroupSubmit(event)"
						id="btn-submit">Save</button>
					<button type="reset" onclick="clearForm()" id="clearBtn">Clear</button>
				</div>
			</form>
		</div>
		<div class="search-container">
			<h3>Existing User Groups</h3>
			<div class="search-box">
				<input type="text" id="searchInput" placeholder="User group Id">
				<button onclick="search()">
					<i class='bx bx-search'></i>
				</button>
			</div>
		</div>
		<div class="table-container">
			<table id="tblUserGroup">
				<thead>
					<tr>
						<th>Group ID</th>
						<th>Group Code</th>
						<th>Group Description</th>
					</tr>
				</thead>
				<tbody id="tbody">
					<tr>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">
	function search() {
		var searchText = document.getElementById('searchInput').value.trim();
		if (searchText === "") {
			getTableData();
		} else {
			filterTable('tblUserGroup', 'searchInput');
		}
	}
	function userGroupSubmit(event) {
		event.preventDefault();
		var btnName = document.getElementById('btn-submit').innerHTML;
		if (btnName === "Save") {
			createUserGroup();
		} else {
			updateUserGroup();
		}
	}

	function getAccessModules() {
		let checkboxes = document.getElementsByName('accessModules');
		let accessModules = [];
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].checked) {
				accessModules.push(checkboxes[i].value);
			}
		}
		return accessModules;
	}
	function createUserGroup() {
		// Retrieve form values
		const accessModules = getAccessModules();
		if (accessModules.length === 0) {
			alert('Give access to at least one module');
			return;
		}
		const groupCode = document.getElementById('groupCode').value.trim();
		const groupDescription = document.getElementById('groupDescription').value
				.trim();

		if (!groupDescription || !groupCode) {
			alert('Group description and Group Code are required!');
			return;
		}

		// Create and configure XMLHttpRequest
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						if (response.result.success === true) {
							if (response.result.successmsg) {
								alert(response.result.successmsg);
								clearInputFields();
								getTableData();
								return;
							}
						}
						if (response.result.error) {
							alert(response.result.error);
						}
						const validationErrors = response.result.validationErrors;
						for ( const key in validationErrors) {
							if (validationErrors.hasOwnProperty(key)) {
								let errorField = document.getElementById(key);
								errorField.style.display = "block";
								errorField.innerHTML = validationErrors[key];
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
		xhttp.open("POST", "/Trial_Calculator/adminAction-createUserGroup?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "userGroup.groupCode=" + groupCode
				+ "&userGroup.description=" + groupDescription
				+ "&userGroup.accessModules=" + accessModules;
		xhttp.send(data);
	}

	function updateUserGroup() {
		// Retrieve form values
		const accessModules = getAccessModules();
		if (accessModules.length === 0) {
			alert('Give access to at least one module');
			return;
		}
		const groupCode = document.getElementById('groupCode').value.trim();
		const groupDescription = document.getElementById('groupDescription').value
				.trim();
		const groupId = document.getElementById('groupId').value;
		if (!groupDescription || !groupCode) {
			alert('Group description and Group Code are required!');
			return;
		}

		// Create and configure XMLHttpRequest
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						if (response.result.success === true) {
							if (response.result.successmsg) {
								alert(response.result.successmsg);
								clearInputFields();
								document.getElementById('btn-submit').innerHTML = "Save";
								getTableData();
								return;
							}

						}
						if (response.result.error) {
							alert(response.result.error);
						}
						const validationErrors = response.result.validationErrors;
						for ( const key in validationErrors) {
							if (validationErrors.hasOwnProperty(key)) {
								let errorField = document.getElementById(key);
								errorField.style.display = "block";
								errorField.innerHTML = validationErrors[key];
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
		xhttp.open("POST", "/Trial_Calculator/adminAction-updateUserGroup?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		const data = "userGroup.groupId=" + groupId + "&userGroup.groupCode="
				+ groupCode + "&userGroup.description=" + groupDescription
				+ "&userGroup.accessModules=" + accessModules;
		xhttp.send(data);
	}
	function getTableData() {
		document.getElementById('clearBtn').style.display = 'none';
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.usergroups) {
							setTableData(response.result.usergroups);
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
		xhttp.open("POST", "/Trial_Calculator/adminAction-getAllUserGroups?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}

	function setTableData(usergroups) {
		const tbody = document.getElementById('tbody');
		tbody.innerHTML = "";
		for (var i = 0; i < usergroups.length; i++) {
			const tr = document.createElement('tr');
			var id = usergroups[i].groupId;
			tr.innerHTML = "<td>" + usergroups[i].groupId + "</td><td>"
					+ usergroups[i].groupCode + "</td><td>"
					+ usergroups[i].description
					+ "</td><td style='display: none;'>"
					+ usergroups[i].accessModules + "</td>";

			tr.addEventListener('click', function() {
				getUserGroup(event);
			});
			tbody.appendChild(tr);
		}

	}
	function clearInputFields() {
		document.getElementById('groupCode').value = "";
		document.getElementById('groupDescription').value = "";

		var checkboxes = document.getElementsByName('accessModules');
		for (var i = 0; i < checkboxes.length; i++) {
			checkboxes[i].checked = false;
		}
	}

	function getUserGroup(event) {
		document.getElementById('btn-submit').innerHTML = "Update";
		document.getElementById('clearBtn').style.display = 'block';
		const clickedRow = event.currentTarget;
		const cells = clickedRow.children;

		const groupId = cells[0].textContent;
		const groupCode = cells[1].textContent;
		const description = cells[2].textContent;
		const accessModules = cells[3].textContent;

		document.getElementById('groupDescription').value = description;
		document.getElementById('groupCode').value = groupCode;
		document.getElementById('groupId').value = groupId;
		setCheckBoxes(accessModules);
	}
	function setCheckBoxes(accessModules) {
		let modulesArray = accessModules.split(',');

		let checkboxes = document.getElementsByName('accessModules');

		for (var i = 0; i < checkboxes.length; i++) {
			if (modulesArray.includes(checkboxes[i].value)) {
				checkboxes[i].checked = true;
			} else {
				checkboxes[i].checked = false;
			}
		}
	}

	function clearForm() {
		document.getElementById('clearBtn').style.display = 'none';
		document.getElementById('btn-submit').innerHTML = "Save";
	}
</script>
<script src="js/common.js"></script>
</html>