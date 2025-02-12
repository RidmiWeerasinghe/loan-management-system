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
<link rel="stylesheet" href="css/stakeholder.css" />
<link rel="stylesheet" href="css/common.css" />
<script src="js/common.js"></script>

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
	margin-bottom: 50px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
	display: flex;
	flex-direction: row;
	margin-bottom: 15px;
	width: 100%;
	flex-wrap: wrap;
	gap: 20px;
}

.form-group-element {
	flex: 1;
	box-sizing: border-box;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
	text-align: left;
}

.form-group input {
	width: 97%;
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left;
}

.form-group select {
	width: 100%;
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
	text-align: left;
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
</style>
<script>
function search(){
	var searchText = document.getElementById('searchInput').value.trim();
	if (searchText === "") {
		getAllStakeholders();
	}
	else{
		filterTable('stakeholertbl', 'searchInput');
	}
}
	function loadPostalCodes() {
		const xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				if (this.status === 200) {
					try {
						const response = JSON.parse(this.responseText);
						
						if (response.result.error) {
							alert(response.result.error);
						}

						if (response.result.postalCodes) {
							setPostalCodesSelectBox(response.result.postalCodes);
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
		xhttp.open("POST", "/Trial_Calculator/stakeholderAction-getAllPostalCodes?t="
				+ new Date().getTime(), true);
		xhttp.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");
		xhttp.send();
	}
	function stakeholderSubmit(event) {
		event.preventDefault();
		var btnName = document.getElementById('btn-submit').innerHTML;
		if (btnName === "Save") {
			createStakeholder();
		} else {
			updateStakeholder();
		}
	}
	function padZero(num) {
	    return num < 10 ? '0' + num : num;
	}

	function getDetailsFromNIC(nic) {
	    let year, dayOfYear, gender, dob;

	    if (nic.length === 10 && /^[0-9]{9}[vVxX]$/.test(nic)) {
	        // Old NIC format
	        year = parseInt("19" + nic.substring(0, 2)); // 19XX format
	        dayOfYear = parseInt(nic.substring(2, 5));
	    } else if (nic.length === 12 && /^[0-9]{12}$/.test(nic)) {
	        // New NIC format
	        year = parseInt(nic.substring(0, 4)); // 4-digit year
	        dayOfYear = parseInt(nic.substring(4, 7));
	    } else {
	        return { error: "Invalid NIC format" };
	    }

	    //gender
	    if (dayOfYear > 500) {
	        gender = "F";
	        dayOfYear -= 500; //females
	    } else {
	        gender = "M";
	    }

	    // Check if leap year
	    const isLeapYear = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);

	    // Days in month
	    const daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	    // Find the month and day
	    let month = 0;
	    while (dayOfYear > daysInMonths[month]) {
	        dayOfYear -= daysInMonths[month];
	        month++;
	    }

	    // YYYY-MM-DD
	    dob = year+"-"+padZero(month + 1)+"-"+padZero(dayOfYear);

	    return { dateOfBirth: dob, gender: gender };
	}

	function validateNIC() {
		const nic = document.getElementById('nic').value.trim();
		if (!nic || !/^\d{9}[vVxX]$|^\d{12}$/.test(nic)) {
			const errorField = document.getElementById("nic-error");
	        errorField.style.display = "block";
	        errorField.textContent = "NIC must be a valid format (9 digits with 'V/X' or 12 digits).";
	    }else{
	    	document.getElementById("gender").value = getDetailsFromNIC(nic).gender;
	    	document.getElementById("gender-error").style.display = "none";
	    	document.getElementById("dateOfBirth").value = getDetailsFromNIC(nic).dateOfBirth;
	    	document.getElementById("dateOfBirth-error").style.display = "none";
	    }
	}
	
	function validateDOB() {
		const nic = document.getElementById('nic').value.trim();
		if (nic === "") {
			const errorField = document.getElementById("nic-error");
	        errorField.style.display = "block";
	        errorField.textContent = "Enter NIC";
	    }else{
	    	const dateOfBirth = document.getElementById('dateOfBirth').value.trim();
			var dob = getDetailsFromNIC(nic).dateOfBirth;
			if(dateOfBirth !== dob){
				const errorField = document.getElementById("dateOfBirth-error");
		        errorField.style.display = "block";
		        errorField.textContent = "Mismatch with NIC Number";
			}
	    }
	}
	function validateGender() {
		const nic = document.getElementById('nic').value.trim();
		if (nic === "") {
			const errorField = document.getElementById("nic-error");
	        errorField.style.display = "block";
	        errorField.textContent = "Enter NIC";
	    }else{
			const gender = document.getElementById('gender').value.trim();
			var gen = getDetailsFromNIC(nic).gender;
			if(gender !== gen){
				const errorField = document.getElementById("gender-error");
		        errorField.style.display = "block";
		        errorField.textContent = "Mismatch with NIC Number";
			}
		}
	}
	
	function validateStakeHolderDetails() {
	    const firstName = document.getElementById('firstName').value.trim();
	    const lastName = document.getElementById('lastName').value.trim();
	    const fullName = document.getElementById('fullName').value.trim();
	    const nic = document.getElementById('nic').value.trim();
	    const dateOfBirth = document.getElementById('dateOfBirth').value.trim();
	    const gender = document.getElementById('gender').value.trim();
	    const phone = document.getElementById('phone').value.trim();
	    const email = document.getElementById('email').value.trim();
	    const occupation = document.getElementById('occupation').value.trim();
	    const addressLine1 = document.getElementById('addressLine1').value.trim();
	    const addressLine2 = document.getElementById('addressLine2').value.trim();
	    const postalCodeId = document.getElementById('postalCodeId').value.trim();
	    const city = document.getElementById('city').value.trim();
	    const province = document.getElementById('province').value.trim();

	    // Object to store validation errors
	    const validationErrors = {};

	    // Validate each field
	    if (!firstName) {
	        validationErrors["firstName-error"] = "First name is required.";
	    }
	    if (!lastName) {
	        validationErrors["lastName-error"] = "Last name is required.";
	    }
	    if (!fullName) {
	        validationErrors["fullName-error"] = "Full name is required.";
	    }
	    if (!nic || !/^\d{9}[vVxX]$|^\d{12}$/.test(nic)) {
	        validationErrors["nic-error"] = "NIC must be a valid format (9 digits with 'V/X' or 12 digits).";
	    }
	    if (!dateOfBirth) {
	        validationErrors["dateOfBirth-error"] = "Date of birth is required.";
	    }
	    if (!gender) {
	        validationErrors["gender-error"] = "Gender selection is required.";
	    }
	    if (!phone || !/^\d{10}$/.test(phone)) {
	        validationErrors["phone-error"] = "Phone number must be 10 digits.";
	    }
	    if (!email || !/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email)) {
	        validationErrors["email-error"] = "Email must be in a valid format.";
	    }
	    if (!occupation) {
	        validationErrors["occupation-error"] = "Occupation is required.";
	    }
	    if (!addressLine1) {
	        validationErrors["addressLine1-error"] = "Address Line 1 is required.";
	    }
	    if (!addressLine1) {
	        validationErrors["addressLine2-error"] = "Address Line 2 is required.";
	    }
	    if (!postalCodeId) {
	        validationErrors["postalCodeId-error"] = "Postal code is required.";
	    }
	    if (!city) {
	        validationErrors["city-error"] = "City is required.";
	    }
	    if (!province) {
	        validationErrors["province-error"] = "Province selection is required.";
	    }

	    // Display errors
	    for (const [fieldId, message] of Object.entries(validationErrors)) {
	        const errorField = document.getElementById(fieldId);
	        if (errorField) {
	            errorField.style.display = "block";
	            errorField.textContent = message;
	        }
	    }
	 // Return true if no errors, false otherwise
	    return Object.keys(validationErrors).length === 0;
	}

	
	function createStakeholder() {
		isValid = validateStakeHolderDetails();
		if (isValid) {
			const firstName = document.getElementById('firstName').value;
			const lastName = document.getElementById('lastName').value;
			const fullName = document.getElementById('fullName').value;
			const nic = document.getElementById('nic').value;
			const dateOfBirth = document.getElementById('dateOfBirth').value;
			const gender = document.getElementById('gender').value;
			const phone = document.getElementById('phone').value;
			const email = document.getElementById('email').value;
			const occupation = document.getElementById('occupation').value;
			const addressLine1 = document.getElementById('addressLine1').value;
			const addressLine2 = document.getElementById('addressLine2').value;
			const postalCodeId = document.getElementById('postalCodeId').value;
			const city = document.getElementById('city').value;
			const province = document.getElementById('province').value;

			// Create and configure XMLHttpRequest
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
			xhttp.open("POST", "/Trial_Calculator/stakeholderAction-createStakeholder?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "stakeholder.nic=" + nic+
			"&stakeholder.firstName=" + firstName+
			"&stakeholder.lastName=" + lastName+
			"&stakeholder.fullName=" + fullName+
			"&stakeholder.dateOfBirth=" + dateOfBirth+
			"&stakeholder.gender=" + gender+
			"&stakeholder.phone=" + phone+
			"&stakeholder.email=" + email+
			"&stakeholder.occupation=" + occupation+
			"&address.addressLine1=" + addressLine1+
			"&address.addressLine2=" + addressLine2+
			"&address.province=" + province+
			"&address.postalCodeId=" + postalCodeId;
			xhttp.send(data);
		}
		
	}
	
	function setPostalCodesSelectBox(postalCodes) {
	    const groupSelect = document.getElementById('postalCodeId');

	    // Clear existing options
	    groupSelect.innerHTML = '';

	    // Add a default "Select User Group" option
	    const defaultOption = document.createElement('option');
	    defaultOption.value = '';
	    defaultOption.textContent = 'Select Postal Code';
	    defaultOption.disabled = true;
	    defaultOption.selected = true;
	    groupSelect.appendChild(defaultOption);

	    // Loop through user groups and add them as options
	    postalCodes.forEach(postalCode => {
	        const option = document.createElement('option');
	        option.value = postalCode.postalCodeId;
	        option.textContent = postalCode.postalCode; 
	        option.setAttribute('data-city', postalCode.city);
	        groupSelect.appendChild(option);
	    });
	}
	function getCity(event) {
	    const selectElement = event.currentTarget;
	    const selectedOption = selectElement.options[selectElement.selectedIndex];  
	    const city = selectedOption.getAttribute('data-city'); 
		document.getElementById('city').value = city;
	}

	function clearInputFields() {
	    document.getElementById('stakeholderId').value = "";
	    document.getElementById('firstName').value = "";
	    document.getElementById('lastName').value = "";
	    document.getElementById('fullName').value = "";
	    document.getElementById('nic').value = "";
	    document.getElementById('dateOfBirth').value = "";
	    document.getElementById('gender').value = "";
	    document.getElementById('phone').value = "";
	    document.getElementById('email').value = "";
	    document.getElementById('occupation').value = "";
	    document.getElementById('addressLine1').value = "";
	    document.getElementById('addressId').value = "";
	    document.getElementById('addressLine2').value = "";
	    document.getElementById('postalCodeId').value = "";
	    document.getElementById('city').value = "";
	    document.getElementById('province').value = "";
	}

	function validateConfirmPassword() {
		const password = document.getElementById('password').value.trim();
		const confirmPassword = document.getElementById('confirmPassword').value.trim();
		if (password !== confirmPassword) {
			document.getElementById('confirmPassword-error').innerHTML="Password and confirm password does not match";
		}
	}
</script>
</head>
<body onload="loadPostalCodes()">
	<div class="home-content">
		<h2>Create Stakeholder</h2>
		<div class="form-container">
			<form action="saveStakeholder" method="post">
				<div class="form-group">

					<div class="form-group-element">
						<label for="firstName">First Name</label> <input type="text"
							id="firstName" name="firstName" required
							onclick="clearErrorMessages('firstName-error')"> <input
							type="hidden" id="stakeholderId" name="stakeholderId"> <input
							type="hidden" id="addressId" name="stakeholderId">
						<p id="firstName-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="lastName">Last Name</label> <input type="text"
							id="lastName" name="lastName" required
							onclick="clearErrorMessages('lastName-error')">
						<p id="lastName-error" class="validationerror"></p>
					</div>
				</div>
				<div class="form-group">
					<div class="form-group-element">
						<label for="fullName">Full Name</label> <input type="text"
							id="fullName" name="fullName" required
							onclick="clearErrorMessages('fullName-error')">
						<p id="fullName-error" class="validationerror"></p>
					</div>
				</div>
				<!-- Full Name -->
				<div class="form-group">
					<div class="form-group-element">
						<label for="NIC">NIC</label> <input type="text" id="nic"
							name="NIC" required onblur="validateNIC()"
							onclick="clearErrorMessages('nic-error')">
						<p id="nic-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="dateOfBirth">Date of Birth</label> <input type="date"
							id="dateOfBirth" name="dateOfBirth" required
							onblur="validateDOB()"
							onclick="clearErrorMessages('dateOfBirth-error')">
						<p id="dateOfBirth-error" class="validationerror"></p>
					</div>
					<div class="form-group-element select-group">
						<label for="gender">Gender</label> <select id="gender"
							name="gender" required
							onclick="clearErrorMessages('gender-error')"
							onblur="validateGender()">
							<option value="M">Male</option>
							<option value="F">Female</option>
						</select>
						<p id="gender-error" class="validationerror"></p>
					</div>
				</div>

				<!-- Date of Birth -->
				<div class="form-group">

					<div class="form-group-element">
						<label for="phone">Phone</label> <input type="text" id="phone"
							name="phone" required onclick="clearErrorMessages('phone-error')">
						<p id="phone-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="email">Email</label> <input type="email" id="email"
							name="email" required onclick="clearErrorMessages('email-error')">
						<p id="email-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="occupation">Occupation</label> <input type="text"
							id="occupation" name="occupation" required
							onclick="clearErrorMessages('occupation-error')">
						<p id="occupation-error" class="validationerror"></p>
					</div>
				</div>

				<!-- Occupation -->
				<div class="form-group">
					<div class="form-group-element">
						<label for="addressLine1">Address Line 1</label> <input
							type="text" id="addressLine1" name="addressLine1" required
							onclick="clearErrorMessages('addressLine1-error')">
						<p id="addressLine1-error" class="validationerror"></p>
					</div>

					<!-- Address Line 2 -->
					<div class="form-group-element">
						<label for="addressLine2">Address Line 2</label> <input
							type="text" id="addressLine2" name="addressLine2"
							onclick="clearErrorMessages('addressLine2-error')">
						<p id="addressLine2-error" class="validationerror"></p>

					</div>
				</div>

				<!-- Address Line 1 -->

				<div class="form-group ">
					<div class="form-group-element select-group">
						<label for="postalCodeId">Postal Code</label> <select
							id="postalCodeId" name="postalCode" required
							onchange="getCity(event); clearErrorMessages('city-error');"
							onclick="clearErrorMessages('postalCodeId-error')">
							<option value="">Select Postal Code</option>
						</select>
						<p id="postalCodeId-error" class="validationerror"></p>
					</div>
					<div class="form-group-element">
						<label for="city">City</label> <input type="text" id="city"
							name="city" required onclick="clearErrorMessages('city-error')"
							readonly="readonly">
						<p id="city-error" class="validationerror"></p>
					</div>
					<div class="form-group-element select-group">
						<label for="province">Province</label><select id="province"
							name="province" required
							onclick="clearErrorMessages('province-error')">
							<option value="">Select Province</option>
							<option value="Western">Western</option>
							<option value="Central">Central</option>
							<option value="Southern">Southern</option>
							<option value="Northern">Northern</option>
							<option value="Eastern">Eastern</option>
							<option value="North Western">North Western</option>
							<option value="North Central">North Central</option>
							<option value="Uva">Uva</option>
							<option value="Sabaragamuwa">Sabaragamuwa</option>
						</select>
						<p id="province-error" class="validationerror"></p>
					</div>
				</div>
				<!-- Form Actions -->
				<div class="form-actions">
					<button type="button" id="btn-submit"
						onclick="stakeholderSubmit(event)">Save</button>
					<button type="reset" id="clearBtn">Clear</button>
				</div>
			</form>
		</div>

	</div>
</body>
</html>