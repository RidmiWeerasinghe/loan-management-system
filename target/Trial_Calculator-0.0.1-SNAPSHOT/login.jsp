<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.1.4/css/boxicons.min.css">
<link rel="stylesheet" href="css/login.css" />
<script src="js/common.js"></script>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	font-family: 'Poppins', sans-serif;
	background-color: #f3f4f6;
}

.login-container {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 40px;
	width: 350px;
	text-align: center;
}

.login-container h2 {
	margin-bottom: 20px;
	color: #333333;
}

.login-container .input-box {
	margin-bottom: 20px;
	position: relative;
}

.login-container .input-box input {
	width: 82%;
	padding: 10px 28px;
	border: 1px solid #ddd;
	border-radius: 4px;
	outline: none;
	font-size: 16px;
}

.login-container .input-box i {
	position: absolute;
	top: 50%;
	left: 10px;
	transform: translateY(-50%);
	color: #aaa;
}

.login-container .btn {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	width: 100%;
}

.login-container .btn:hover {
	background-color: #45a049;
}

.login-container .forgot {
	margin-top: 10px;
	font-size: 14px;
}

.login-container .forgot a {
	color: #4CAF50;
	text-decoration: none;
}

.login-container .forgot a:hover {
	text-decoration: underline;
}

.validationerror {
	margin-top: 0;
	color: #dd0000;
	font-size: 12px;
	display: 'none';
}
</style>
</head>
<body>
	<div class="login-container">
		<h2>Login</h2>
		<form action="" method="post">
			<div class="input-box">
				<i class='bx bx-user'></i> <input type="text" name="username"
					id="username" placeholder="Username" required
					onclick="clearErrorMessages('username-error')">
				<p id="username-error" class="validationerror"></p>
			</div>
			<div class="input-box">
				<i class='bx bx-lock-alt'></i> <input type="password"
					name="password" id="password" placeholder="Password" required
					onclick="clearErrorMessages('password-error')">
				<p id="password-error" class="validationerror"></p>
			</div>
			<button type="button" onclick="login(event)" class="btn">Login</button>
			<!-- <div class="forgot">
				<a href="myprofile.jsp">Reset your password?</a>
			</div> -->
		</form>
	</div>
</body>
<script type="text/javascript">
function validateUserLogin() {
	const username = document.getElementById('username').value.trim();
	const password = document.getElementById('password').value.trim();
    const validationErrors = {};

   	if (username !== undefined) {
            if (!username) {
                validationErrors["username-error"] = "Username is required";
            }
       	}
	if (password !== undefined) {
            if (!password) {
                validationErrors["password-error"] = "Password is required";
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

/* function login() {
    const isValid = validateUserLogin();
    if (isValid) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        // Generate a unique identifier for the request
        const requestToken = new Date().getTime(); // or use a UUID generator

        const xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState === 4) {
                if (this.status === 200) {
                    try {
                        const response = JSON.parse(this.responseText);

                        console.log("login()");
                        console.log(response.result);

                        // Validate if the response corresponds to the current request
                        if (response.result.requestToken !== requestToken) {
                            console.error('Response token does not match the request token.');
                            alert('An error occurred while processing the server response.');
                            return;
                        }

                        if (response.result.error) {
                            alert(response.result.error);
                        } else {
                            if (response.result.success === true && response.result.currentUser !== null) {
                                alert(response.result.successmsg);
                                window.location.href = "/Trial_Calculator/home.jsp";
                            }
                        }

                    } catch (e) {
                        console.error('Invalid response:', e);
                        alert('An error occurred while processing the server response.');
                    }
                } else {
                    console.error('Request failed with status:', this.status);
                    alert('Failed to Login. Please try again.');
                }
            }
        };

        // Open and send the POST request
        xhttp.open("POST", "/Trial_Calculator/userAction-login?t=" + requestToken, true);
        xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        const data = "user.username=" + username + "&user.password=" + password + "&requestToken=" + requestToken;
        xhttp.send(data);
    }
}
 */
	function login() {
		var isValid = validateUserLogin();
		if (isValid) {
			const username = document.getElementById('username').value.trim();
			const password = document.getElementById('password').value.trim();

			const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("login()");
							console.log(response.result);

							if (response.result.error) {
								alert(response.result.error);
							}

							else {
								if (response.result.success === true) {
									alert(response.result.successmsg)
									window.location.href = "/Trial_Calculator/home.jsp";
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
			xhttp.open("POST", "/Trial_Calculator/userAction-login?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			const data = "user.username=" + username + "&user.password="
					+ password;
			xhttp.send(data);
		}
	}
</script>
</html>