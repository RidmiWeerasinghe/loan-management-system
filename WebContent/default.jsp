<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Loan Management System</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

body {
	margin: 0;
	font-family: 'Poppins', sans-serif;
	background-color: #f4f4f4;
	color: #333;
}

.header {
	background: #242424;
	color: #fff;
	padding: 20px;
	text-align: center;
}

.header h1 {
	margin: 0;
	font-weight: 600;
}

.header p {
	font-size: 14px;
	margin-top: 5px;
}

.content {
	padding: 20px;
}

.section {
	margin-bottom: 20px;
}

.section h2 {
	margin-bottom: 10px;
	color: #439c47;
}

.section p {
	font-size: 14px;
	line-height: 1.6;
}

.actions {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-around;
}

.card {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	text-align: center;
	width: 250px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s;
}

.card:hover {
	transform: translateY(-5px);
}

.card h3 {
	font-size: 18px;
	margin-bottom: 10px;
	color: #242424;
}

.card p {
	font-size: 14px;
	margin-bottom: 15px;
}

.card a {
	text-decoration: none;
	background:  #fff;
	color: #439c47;
	padding: 10px 20px;
	border-radius: 4px;
	border-style: solid;
	border-width:0.5px;
	border-color: #439c47;
	display: inline-block;
	font-size: 12px;
}

.card a:hover {
	background: #439c47;
	border-style: solid;
	border-width:0.5px;
	border-color: #fff;
	color: #fff;
}

.settings {
	background: #439c47;
	color: #fff;
}

.settings h3 {
	background: #439c47;
	color: #fff;
}

.settings a {
	background: #fff;
	color: #439c47;
	font-size: 12px;
}
.settings a:hover {
	background: #439c47;
	border-style: solid;
	border-width:0.5px;
	border-color: #fff;
	color: #fff;
}
</style>
</head>
<body>
	<div class="header">
		<h1>Loan Management System</h1>
		<p>Your one-stop solution for managing loans efficiently</p>
	</div>
	<div class="content">
		<div class="section">
			<h2>Overview</h2>
			<p>Our Loan Management System allows you to easily handle
				customer loans, generate EMI schedules, and track loan statuses. Use
				the navigation below to quickly access the features you need.</p>
		</div>
		<div class="actions">
			<div class="card">
				<h3>User Management</h3>
				<p>Add, edit, or view system user details seamlessly.</p>
				<a onclick="getIframe('createuser')" href="#">System Users</a>
			</div>
			<div class="card">
				<h3>Stakeholder Management</h3>
				<p>Add, edit, or view stakeholder details seamlessly.</p>
				<a onclick="getIframe('viewupdatestakeholders')" href="#">Stakeholders</a>
			</div>
			<div class="card">
				<h3>Loan Processing</h3>
				<p>Create and manage loans with ease.</p>
				<a onclick="getIframe('createapplication')" href="#">Manage
					Loans</a>
			</div>
			<div class="card">
				<h3>EMI Calculator</h3>
				<p>Calculate and view EMI schedules for loans.</p>
				<a onclick="getIframe('emicalculator')" href="#">Calculate
					EMI</a>
			</div>
			<div class="card">
				<h3>Reports</h3>
				<p>Generate detailed loan and payment reports.</p>
				<a onclick="getIframe('printReport')" href="#">View Reports</a>
			</div>
			<div class="card settings">
				<h3>Settings</h3>
				<p>Update your profile and securely reset your password to
					ensure account safety.</p>
				<a onclick="getIframe('myprofile')" href="#">Get started</a>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function getIframe(page) {
	<%String currentUserAccessModules = (String) session.getAttribute("currentUserAccessModules");%>
    var currentUserAccessModules = '<%=currentUserAccessModules != null ? currentUserAccessModules : ""%>';
		let modulesArray = currentUserAccessModules.split(',');

		if (modulesArray.includes(page)) {
			page = page+".jsp"
			let iframe = window.parent.document.getElementById('contentFrame');
			if (iframe) {
				iframe.src = page; // Load the new page inside the iframe
			} else {
				alert('Iframe not found in the parent document.');
			}
		} else {
			alert('Access Denied !');
		}
	}
</script>
</html>
