<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@page import="com.openarc.trialcal.dto.UserHistory"%>
<%@page import="com.openarc.trialcal.dto.User"%>
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

body {
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	margin: 150px;
	padding: 0;
}

.home-content {
	display: flex;
	justify-content: center;
	flex-direction: column;
	padding: 20px;
	background-color: #f4f4f4;
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
}

.form-container {
	background: #fff;
	padding: 40px;
	border-radius: 8px;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	min-width: 500px;
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
<body onload="setUserId()">
	<div class="home-content">
		<h2>Change Password</h2>
		<div class="form-container">
			<form action="saveUser" method="post">
				<div class="form-group">
					<div class="form-group-element">
						<label for="password">Current Password</label> <input type="password"
							id="oldPassword" name="oldPassword" required
							onclick="clearErrorMessages('oldPassword-error')"
							onblur="isOldPasswordCorrect()">
						<p id="oldPassword-error" class="validationerror"></p>
						<input type="hidden" id="userId" name="userId">
						<input type="hidden" id="hashedPassword" name="hashedPassword">
						<input type="hidden" id="oldPasswords" name="oldPasswords">
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label for="newPassword">New Password</label> <input
							type="password" id="newPassword" name="newPassword" required
							onblur="compareNewPasswordAndOldPassword()"
							onclick="clearErrorMessages('newPassword-error')">
						<p id="newPassword-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label for="confirmPassword">Confirm Password</label> <input
							type="password" id="confirmPassword" name="confirmPassword"
							onblur="validateConfirmPassword()" required
							onclick="clearErrorMessages('confirmPassword-error')">
						<p id="confirmPassword-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-actions">
					<button type="button" onclick="updatePassword()" id="btn-submit">Reset</button>
					<button type="reset" onclick="clearForm()" id="clearBtn">Clear</button>
				</div>
			</form>
		</div>
	</div>
</body>
<script>
	const oldPasswords = [];
	
	function setUserId() {
	<%
		User currentUser = (User) session.getAttribute("currentUser");
		List<UserHistory> currentUserHistories = (List<UserHistory>) session.getAttribute("currentUserHistories");
		int id = currentUser != null ? currentUser.getUserId() : 0;
		String hashedPassword = currentUser != null ? currentUser.getPassword() : null;
	%>
			
	<%
	for (UserHistory userHistory : currentUserHistories) {
		%>
		oldPasswords.push('<%=userHistory.getPassword()%>');
		<%
	}
	%>
	console.log(oldPasswords);
			document.getElementById('userId').value = '<%=id%>';
			document.getElementById('hashedPassword').value = '<%=hashedPassword%>';
	}

	function compareNewPasswordAndOldPassword() {
		const oldPassword = document.getElementById('oldPassword').value.trim();
		const newPassword = document.getElementById('newPassword').value.trim();
		const errorField = document.getElementById('newPassword-error');
		if (oldPassword === newPassword) {
			errorField.style.display = "block";
            errorField.textContent = "New Password Can not be same as old password";
            return;
		}
		else if(oldPasswords.includes(newPassword)){
			errorField.style.display = "block";
            errorField.textContent = "You have already used that password, try another";
            return;
		}
	}
	
	function isOldPasswordCorrect() {
		const oldPassword = document.getElementById('oldPassword').value.trim();
		const hashedPassword = document.getElementById('hashedPassword').value;
		const userId = document.getElementById('userId').value.trim();
		const errorField = document.getElementById('oldPassword-error');
	        
		console.log("oldPassword : "+ oldPassword);
		console.log("hashedPassword: "+ hashedPassword);
		if (oldPassword !== "") {
			if(oldPassword === hashedPassword){
				return;
			}
			else{
				errorField.style.display = "block";
	            errorField.textContent = "Current Password is Incorrect";
				return;
			}
		}
		else{
		errorField.style.display = "block";
        errorField.textContent = "Current Password is required";
		}
	}

	
	function validateInputs() {
		const oldPassword = document.getElementById('oldPassword').value.trim();
		const newPassword = document.getElementById('newPassword').value.trim();
		const confirmPassword = document.getElementById('confirmPassword').value.trim();
		const userId = document.getElementById('userId').value.trim();
	    // Object to store validation errors
	    const validationErrors = {};

	    if (oldPassword !== undefined) {
            if (!oldPassword) {
                validationErrors["newPassword-error"] = "Old Password is required";
            }
        }
	    
		if (newPassword !== undefined) {
	            if (!newPassword) {
	                validationErrors["newPassword-error"] = "New Password is required";
	            } else if (!/^.{6,10}$/.test(newPassword)) {
	                validationErrors["newPassword-error"] = "Password must be 6-10 characters long.";
	            }/*  else if (!/^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/.test(password)) {
	                validationErrors["password-error"] = "Password must contain at least one uppercase letter, one number, and one special character.";
	            } */
	        }
		if (confirmPassword !== undefined) {
            if (!confirmPassword) {
                validationErrors["confirmPassword-error"] = "Password confirmation is required";
            }
            else if (newPassword !== confirmPassword) {
            	validationErrors["confirmPassword-error"] = "confirm password does not match";
			}
		}
		if (oldPassword === newPassword) {
			validationErrors["newPassword-error"] = "New Password Can not be same as old password";
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
	
	function updatePassword() {
		var isValidInputs = validateInputs();
		//var isValidInputs = false;
		if (isValidInputs) {
			const oldPassword = document.getElementById('oldPassword').value.trim();
			const newPassword = document.getElementById('newPassword').value.trim();
			const userId = document.getElementById('userId').value;

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
			xhttp.open("POST", "/Trial_Calculator/userAction-updatePassword?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "user.userId="+userId+"&user.password=" + newPassword+"&user.username="+oldPassword;
			xhttp.send(data);
		}		
	}

	function clearInputFields() {
		document.getElementById('newPassword').value = "";
		document.getElementById('oldPassword').value = "";
		document.getElementById('confirmPassword').value = "";
	}
	function validateConfirmPassword() {
		/* const password = document.getElementById('newPassword').value.trim();
		const confirmPassword = document.getElementById('confirmPassword').value.trim();
		if (!password === confirmPassword) {
			document.getElementById('confirmPassword-error').innerHTML="Password and confirm password does not match";
		} */
	}
	
</script>

</html>