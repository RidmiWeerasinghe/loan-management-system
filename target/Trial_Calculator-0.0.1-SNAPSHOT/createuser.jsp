<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<!-- Boxiocns CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="css/createuser.css" />
<link rel="stylesheet" href="css/common.css" />
<script src="js/common.js"></script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

.home-content {
	padding: 20px;
	background-color: #f4f4f4;
	font-size: 14px;
}
body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	margin: 40px;
	padding: 0;
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
</style>
</head>
<body onload="loadUsers();">
	<div class="home-content">
		<h2>Create User</h2>
		<div class="form-container">
			<form action="saveUser" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label for="username">Username</label> <input type="text"
							id="username" name="username" required
							onclick="clearErrorMessages('username-error')">
						<p id="username-error" class="validationerror"></p>
						<input type="hidden" id="userId" name="userId">
					</div>
					<div class="form-group-element">
						<label for="password">Password</label> <input type="password"
							id="password" name="password" required
							onclick="clearErrorMessages('password-error')">
						<p id="password-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="confirmPassword">Confirm Password</label> <input
							type="password" id="confirmPassword" name="confirmPassword"
							onblur="validateConfirmPassword()" required
							onclick="clearErrorMessages('confirmPassword-error')">
						<p id="confirmPassword-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label for="userGroup">User Group</label>
						<div class="select-group">
							<select id="groupId" name="groupId" required
								onclick="clearErrorMessages('groupId-error')">
							</select>
							<p id="groupId-error" class="validationerror"></p>
						</div>
					</div>
					<div class="form-group-element">
						<label for="confirmPassword">Account Status</label>
						<div class="select-group">
							<select id="status" name="status" required>
								<option value="A" selected="selected">Active</option>
								<option value="D">Inactive</option>
							</select>
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
			<h3>Existing Users</h3>
			<div class="search-box">
				<input type="text" id="searchInput" placeholder="Search by User name">
				<button onclick="search()">
					<i class='bx bx-search'></i>
				</button>
			</div>
		</div>
		<div class="table-container">
			<table id="usertbl">
				<thead>
					<tr>
						<th>User ID</th>
						<th>Username</th>
						<th>User Group Id</th>
						<th style="display: none;">Password</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="tbody">

				</tbody>
			</table>
		</div>
	</div>

</body>
<script>
function search(){
	var searchText = document.getElementById('searchInput').value.trim();
	if (searchText === "") {
		loadUsers();
	}
	else{
		filterTable('usertbl', 'searchInput');
	}
}
	function loadUsers() {
		document.getElementById('clearBtn').style.display = 'none';
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						console.log("getTableData");
						console.log(response);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.usergroups) {
							setUserGroupsSelectBox(response.result.usergroups);
							 getAllUsers();
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
	function userGroupSubmit(event) {
		event.preventDefault();
		var btnName = document.getElementById('btn-submit').innerHTML;
		console.log("name : " + btnName);
		if (btnName === "Save") {
			createUser();
		} else {
			updateUser();
		}
	}
	
	function validateUser() {
		const username = document.getElementById('username').value.trim();
		const password = document.getElementById('password').value.trim();
		const confirmPassword = document.getElementById('confirmPassword').value
		.trim();
		const groupId = document.getElementById('groupId').value.trim();
	    // Object to store validation errors
	    const validationErrors = {};

	   	if (username !== undefined) {
	            if (!username) {
	                validationErrors["username-error"] = "Username is required";
	            } else if (!/^[a-zA-Z0-9]*$/.test(username)) {
	                validationErrors["username-error"] = "Username can only contain letters and numbers.";
	            }
	       	}
		if (password !== undefined) {
	            if (!password) {
	                validationErrors["password-error"] = "Password is required";
	            } else if (!/^.{6,10}$/.test(password)) {
	                validationErrors["password-error"] = "Password must be 6-10 characters long.";
	            }/*  else if (!/^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/.test(password)) {
	                validationErrors["password-error"] = "Password must contain at least one uppercase letter, one number, and one special character.";
	            } */
	        }
		if (confirmPassword !== undefined) {
            if (!confirmPassword) {
                validationErrors["confirmPassword-error"] = "Password confirmation is required";
            }
		}
		if (confirmPassword !== password) {
            validationErrors["confirmPassword-error"] = "Confirm password mismatch";
		}
		 if (groupId !== undefined) {
		        if (!groupId) {
		            validationErrors["groupId-error"] = "User Group selection is required.";
		        }
		    }
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	        	errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }
	    if (Object.keys(validationErrors).length > 0) {
	        return false;
	    } else {
	        return true;
	    }
	}

	
	function createUser() {
		// Retrieve form values
		var isValid = validateUser();
		console.log(isValid);
		if (isValid) {
			const username = document.getElementById('username').value.trim();
			const password = document.getElementById('password').value.trim();
			const confirmPassword = document.getElementById('confirmPassword').value
					.trim();
			const userId = document.getElementById('userId').value;
			const groupId = document.getElementById('groupId').value;
			const status = document.getElementById('status').value;

			// Create and configure XMLHttpRequest
			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("createUser");
							console.log(response);

							if (response.result.error) {
								alert(response.result.error);
							}
							
							if (response.result.success === true) {
								if (response.result.successmsg) {
									alert(response.result.successmsg);
									clearInputFields();
									getAllUsers();
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
			xhttp.open("POST", "/Trial_Calculator/userAction-createUser?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "user.username=" + username + "&user.password=" + password
					+ "&user.groupId=" + groupId + "&user.status=" + status;
			xhttp.send(data);
		}
		
	}
	
	function updateUser() {
		// Retrieve form values
		var isValid = validateUser();
		console.log(isValid);
		if (isValid) {
			const username = document.getElementById('username').value.trim();
			const password = document.getElementById('password').value.trim();
			const confirmPassword = document.getElementById('confirmPassword').value
					.trim();
			const userId = document.getElementById('userId').value;
			const groupId = document.getElementById('groupId').value;
			const status = document.getElementById('status').value;

			console.log("update user -> userId : "+userId);
			// Create and configure XMLHttpRequest
			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("updateUser");
							console.log(response);

							if (response.result.error) {
								alert(response.result.error);
							}
							
							if (response.result.success === true) {
								if (response.result.successmsg) {
									alert(response.result.successmsg);
									clearInputFields();
									getAllUsers();
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
			xhttp.open("POST", "/Trial_Calculator/userAction-updateUser?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "user.userId="+userId+"&user.username=" + username + "&user.password=" + password
					+ "&user.groupId=" + groupId + "&user.status=" + status;
			xhttp.send(data);
		}
		
	}
	
	function setUserGroupsSelectBox(userGroups) {
	    // Get the select element for the user groups
	    const groupSelect = document.getElementById('groupId');

	    // Clear existing options
	    groupSelect.innerHTML = '';

	    // Add a default "Select User Group" option
	    const defaultOption = document.createElement('option');
	    defaultOption.value = '';
	    defaultOption.textContent = 'Select User Group';
	    defaultOption.disabled = true;
	    defaultOption.selected = true;
	    groupSelect.appendChild(defaultOption);

	    // Loop through user groups and add them as options
	    userGroups.forEach(group => {
	        const option = document.createElement('option');
	        option.value = group.groupId; // Use the appropriate field for group ID
	        option.textContent = group.description; // Use the appropriate field for group code
	        groupSelect.appendChild(option);
	    });
	}
	function clearInputFields() {
		document.getElementById('username').value = "";
		document.getElementById('password').value = "";
		document.getElementById('confirmPassword').value = "";
	}
	function validateConfirmPassword() {
		const password = document.getElementById('password').value.trim();
		const confirmPassword = document.getElementById('confirmPassword').value.trim();
		if (password !== confirmPassword) {
			document.getElementById('confirmPassword-error').innerHTML="Password and confirm password does not match";
		}
	}
	function getAllUsers() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						console.log("getAllUsers");
						console.log(response);

						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.users) {
							setTableData(response.result.users);
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
		xhttp.open("POST", "/Trial_Calculator/adminAction-getAllUsers?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}
	function setTableData(users) {
		const tbody = document.getElementById('tbody');
		tbody.innerHTML = "";
		for (var i = 0; i < users.length; i++) {
			const tr = document.createElement('tr');
			var id = users[i].userId;
			tr.innerHTML = "<td>" + users[i].userId + "</td><td>"
					+ users[i].username + "</td><td>"
					+ users[i].groupId + "</td><td style='display:none;'>"
					+ users[i].password + "</td>"+ "</td><td>"
					+ users[i].status + "</td>";

			tr.addEventListener('click', function() {
				getUser(event);
			});
			tbody.appendChild(tr);
		}

	}
	function getUser(event) {
		document.getElementById('btn-submit').innerHTML = "Update";
		document.getElementById('clearBtn').style.display = 'block';
		const clickedRow = event.currentTarget;
		const cells = clickedRow.children;
		const userId = cells[0].textContent;
		const username = cells[1].textContent;
		const groupId = cells[2].textContent;
		const password = cells[3].textContent;
		const status = cells[4].textContent;

		document.getElementById('userId').value = userId;
		document.getElementById('username').value = username;
		document.getElementById('groupId').value = groupId;
		document.getElementById('password').value = password;
		document.getElementById('confirmPassword').value = password;
		document.getElementById('status').value = status;
	}
	function clearForm(){
		document.getElementById('clearBtn').style.display = 'none';
		document.getElementById('btn-submit').innerHTML = "Save";
	}
</script>

</html>