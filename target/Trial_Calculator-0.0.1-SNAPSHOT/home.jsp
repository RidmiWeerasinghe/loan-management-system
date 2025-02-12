<%@page import="com.openarc.trialcal.dto.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trial Calculator</title>
<link rel="stylesheet" href="css/sidebar.css" />
<!-- Boxiocns CDN Link -->
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css'
	rel='stylesheet'>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
/* Google Fonts Import Link */
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap')
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	height: 100%;
	width: 260px;
	background: #11101d;
	z-index: 100;
	transition: all 0.5s ease;
}

.sidebar.close {
	width: 78px;
}

.sidebar .logo-details {
	height: 60px;
	width: 100%;
	display: flex;
	align-items: center;
}

.sidebar .logo-details i {
	font-size: 30px;
	color: #fff;
	height: 50px;
	min-width: 78px;
	text-align: center;
	line-height: 50px;
}

.sidebar .logo-details .logo_name {
	font-size: 22px;
	color: #fff;
	font-weight: 600;
	transition: 0.3s ease;
	transition-delay: 0.1s;
}

.sidebar.close .logo-details .logo_name {
	transition-delay: 0s;
	opacity: 0;
	pointer-events: none;
}

.sidebar .nav-links {
	height: 100%;
	padding: 30px 0 150px 0;
	overflow: auto;
}

.sidebar.close .nav-links {
	overflow: visible;
}

.sidebar .nav-links::-webkit-scrollbar {
	display: none;
}

.sidebar .nav-links li {
	position: relative;
	list-style: none;
	transition: all 0.4s ease;
}

.sidebar .nav-links li:hover {
	background: #1d1b31;
}

.sidebar .nav-links li .iocn-link {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.sidebar.close .nav-links li .iocn-link {
	display: block
}

.sidebar .nav-links li i {
	height: 50px;
	min-width: 60px;
	text-align: center;
	line-height: 50px;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.sidebar .nav-links li.showMenu i.arrow {
	transform: rotate(-180deg);
}

.li-div i.arrow {
	transform: rotate(-180deg);
}

.sidebar.close .nav-links i.arrow {
	display: none;
}

.sidebar .nav-links li a {
	display: flex;
	align-items: center;
	text-decoration: none;
}

.sidebar .nav-links li a .link_name {
	font-size: 16px;
	font-weight: 400;
	color: #fff;
	transition: all 0.4s ease;
}

.sidebar.close .nav-links li a .link_name {
	opacity: 0;
	pointer-events: none;
}

.sidebar .nav-links li .sub-menu {
	padding: 6px 6px 14px 60px;
	margin-top: -10px;
	background: #1d1b31;
	display: none;
}

.sidebar .nav-links li.showMenu .sub-menu {
	display: block;
}

.sub-menu  li.li-div .showMenu .sub-menu {
	display: block;
}

.sidebar .nav-links li .sub-menu a {
	color: #fff;
	font-size: 15px;
	padding: 5px 0;
	white-space: nowrap;
	opacity: 0.6;
	transition: all 0.3s ease;
}

.sidebar .nav-links li .sub-menu a:hover {
	opacity: 1;
}

.sidebar.close .nav-links li .sub-menu {
	position: absolute;
	left: 100%;
	top: -10px;
	margin-top: 0;
	padding: 10px 20px;
	border-radius: 0 6px 6px 0;
	opacity: 0;
	display: block;
	pointer-events: none;
	transition: 0s;
}

.sidebar.close .nav-links li:hover .sub-menu {
	top: 0;
	opacity: 1;
	pointer-events: auto;
	transition: all 0.4s ease;
}

.sidebar .nav-links li .sub-menu .link_name {
	display: none;
}

.sidebar.close .nav-links li .sub-menu .link_name {
	font-size: 18px;
	opacity: 1;
	display: block;
}

.sidebar .nav-links li .sub-menu.blank {
	opacity: 1;
	pointer-events: auto;
	padding: 3px 20px 6px 16px;
	opacity: 0;
	pointer-events: none;
}

.sidebar .nav-links li:hover .sub-menu.blank {
	top: 50%;
	transform: translateY(-50%);
}

.sidebar .profile-details {
	position: fixed;
	bottom: 0;
	width: 260px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	background: #1d1b31;
	padding: 12px 0;
	transition: all 0.5s ease;
}

.sidebar.close .profile-details {
	background: none;
}

.sidebar.close .profile-details {
	width: 78px;
}

.sidebar .profile-details .profile-content {
	display: flex;
	align-items: center;
}

.sidebar .profile-details img {
	height: 52px;
	width: 52px;
	object-fit: cover;
	border-radius: 16px;
	margin: 0 14px 0 12px;
	background: #1d1b31;
	transition: all 0.5s ease;
}

.sidebar.close .profile-details img {
	padding: 10px;
}

.sidebar .profile-details .profile_name, .sidebar .profile-details .job
	{
	color: #fff;
	font-size: 18px;
	font-weight: 500;
	white-space: nowrap;
}

.sidebar.close .profile-details i, .sidebar.close .profile-details .profile_name,
	.sidebar.close .profile-details .job {
	display: none;
}

.sidebar .profile-details .job {
	font-size: 12px;
}

.home-section {
	position: relative;
	background: #E4E9F7;
	height: 100vh;
	left: 260px;
	width: calc(100% - 260px);
	transition: all 0.5s ease;
}

.sidebar.close ~ .home-section {
	left: 78px;
	width: calc(100% - 78px);
}

.home-section .home-content {
	height: 60px;
	display: flex;
	align-items: center;
}

.home-section .home-content .bx-menu, .home-section .home-content .text
	{
	color: #11101d;
	font-size: 35px;
}

.home-section .home-content .bx-menu {
	margin: 0 15px;
	cursor: pointer;
}

.home-section .home-content .text {
	font-size: 26px;
	font-weight: 600;
}

@media ( max-width : 400px) {
	.sidebar.close .nav-links li .sub-menu {
		display: none;
	}
	.sidebar {
		width: 78px;
	}
	.sidebar.close {
		width: 0;
	}
	.home-section {
		left: 78px;
		width: calc(100% - 78px);
		z-index: 100;
	}
	.sidebar.close ~ .home-section {
		width: 100%;
		left: 0;
	}
}

.sidebar .nav-links li .sub-menu ul {
	padding-left: 10px;
}

.sidebar .nav-links li .sub-menu ul a {
	font-size: 14px;
}

.home-content {
	display: flex;
	justify-content: space-between;
	padding-right: 15px;
}

.li-div {
	display: flex;
	justify-content: space-between;
}
a:link {
  text-decoration: none;
}
</style>
</head>
<body onload="setAccessModulesForLoggedInUser()">
	<div class="sidebar close">
		<div class="logo-details">
			<i class='bx bx-calculator'></i> <span class="logo_name"><a  class="logo_name" href="default.jsp" target="contentFrame">Loan
				Cal</a></span>
		</div>
		<ul class="nav-links">
			<li id="admin">
				<div class="iocn-link">
					<a href="#"> <i class='bx bxs-bank'></i> <span
						class="link_name">Admin</span>
					</a> <i class='bx bxs-chevron-down arrow'></i>
				</div>
				<ul class="sub-menu">
					<li><div class="li-div">
							<a href="#">User Creation</a><i class='bx bxs-chevron-down arrow'></i>
						</div>
						<ul class="sub-menu">
							<li id="createuser"><a href="createuser.jsp"
								target="contentFrame">Create User</a></li>
							<li id="createusergroups"><a href="createusergroups.jsp"
								target="contentFrame">Create User Group</a></li>
						</ul></li>
				</ul>
			</li>

			<li id="loan">
				<div class="iocn-link">
					<a href="#"> <i class='bx bx-money'></i> <span
						class="link_name">Loan</span>
					</a> <i class='bx bxs-chevron-down arrow'></i>
				</div>
				<ul class="sub-menu">
					<li><div class="li-div">
							<a href="#">Stakeholders</a><i class='bx bxs-chevron-down arrow'></i>
						</div></li>
					<ul class="sub-menu">
						<li id="stakeholders"><a href="stakeholders.jsp"
							target="contentFrame">Create Stakeholder</a></li>
							<li id="viewupdatestakeholders"><a href="viewupdatestakeholders.jsp"
							target="contentFrame">View/Update</a></li>
					</ul>
					<li><div class="li-div">
							<a href="#">Trial Calculation</a><i
								class='bx bxs-chevron-down arrow'></i>
						</div></li>
					<ul class="sub-menu">
					<li id="goalseek"><a href="goalseek.jsp"
							target="contentFrame">Goal Seek</a></li>
						<li id="emicalculator"><a href="emicalculator.jsp"
							target="contentFrame">EMI Calculator </a></li>
						<li id="viewupdateemicalculator"><a
							href="viewupdateemicalculator.jsp" target="contentFrame">View/Renew</a></li>
					</ul>
					<li><div class="li-div">
							<a href="#">Application Process</a><i
								class='bx bxs-chevron-down arrow'></i>
						</div></li>
					<ul class="sub-menu">
						<li id="createapplication"><a
							href="createapplication.jsp" target="contentFrame">Create
								Application</a></li>
						<li id="viewapplications"><a href="viewapplications.jsp"
							target="contentFrame">View Application</a></li>
						<li id="applicationapprove"><a
							href="applicationapprove.jsp" target="contentFrame">Approval</a></li>
					</ul>
				</ul>
			</li>
			<li id="report">
				<div class="iocn-link">
					<a href="#"> <i class='bx bxs-report'></i> <span
						class="link_name">Reports</span>
					</a> <i class='bx bxs-chevron-down arrow'></i>
				</div>
				<ul class="sub-menu">
					<li><a href="#">Reports</a></li>
					<ul class="sub-menu">
						<li id="printReport"><a href="printReport.jsp"
							target="contentFrame">Print Report</a></li>
					</ul>
				</ul>
			</li>
			<!-- <li id="account">
				<div class="iocn-link">
					<a href="#"> <i class='bx bxs-user-account'></i><span
						class="link_name">My Account</span>
					</a> <i class='bx bxs-chevron-down arrow'></i>
				</div>
				<ul class="sub-menu">
					<li><a href="#">*****</a></li>
					<ul class="sub-menu">
						<li id="myprofile"><a href="myprofile.jsp"
							target="contentFrame">Change Password</a></li>
					</ul>
				</ul>
			</li> -->
			<li>
				<div class="profile-details">
					<div class="profile-content">
						<i class='bx bx-user'></i>
					</div>
					<div class="name-job">
						<div class="profile_name">Log out</div>
					</div>
					<i class='bx bx-log-out' onclick="logout()"></i>
				</div>
			</li>
		</ul>
	</div>
	<section class="home-section">
	<div class="home-content">
		<i class='bx bx-menu'></i>
		<div class="nav-bar-topic" id="nav-bar-topic"></div>
	</div>
	<iframe id="contentFrame"
		src="${pageContext.request.contextPath}/default.jsp"
		style="width: 100%; height: calc(100vh - 60px); border: none;"
		name="contentFrame"> </iframe> </section>
	<script>
	  let arrow = document.querySelectorAll(".arrow");
	  for (var i = 0; i < arrow.length; i++) {
	    arrow[i].addEventListener("click", (e)=>{
	   let arrowParent = e.target.parentElement.parentElement;//selecting main parent of arrow
	   arrowParent.classList.toggle("showMenu");
	    });
	  }
	  let sidebar = document.querySelector(".sidebar");
	  let sidebarBtn = document.querySelector(".bx-menu");
	  console.log(sidebarBtn);
	  sidebarBtn.addEventListener("click", ()=>{
	    sidebar.classList.toggle("close");
	  });
	  
	  function logout() {
		  const xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (this.readyState === 4) {
					if (this.status === 200) {
						try {
							const response = JSON.parse(this.responseText);
							console.log("logout()");
							console.log(response.result);
	
							if (response.result.error) {
								alert(response.result.error);
							}
	
							if (response.result.success === true) {
								alert(response.result.successmsg);
								window.location.href = "/Trial_Calculator/login.jsp";
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
			xhttp.open("POST", "/Trial_Calculator/userAction-logout?t="
					+ new Date().getTime(), true);
			xhttp.setRequestHeader("Content-Type",
					"application/x-www-form-urlencoded");
			xhttp.send();
	}
	  
	  function setAccessModulesForLoggedInUser() {
		    <%User currentUser = (User) session.getAttribute("currentUser");
			String username = currentUser.getUsername();%>
		    document.getElementById('nav-bar-topic').innerHTML = "Welcome, <%=username%>";
		    
		    <%String currentUserAccessModules = (String) session.getAttribute("currentUserAccessModules");%>
		    var currentUserAccessModules = '<%=currentUserAccessModules != null ? currentUserAccessModules : ""%>';
		    let modulesArray = currentUserAccessModules.split(',');

		    const modules = [
		        { admin: ['createuser', 'createusergroups'] },
		        { loan: ['stakeholders','viewupdatestakeholders', 'goalseek' , 'emicalculator', 'viewupdateemicalculator', 'createapplication', 'viewapplications', 'applicationapprove'] },
		        { report: ['printReport'] },
		        { account: ['myprofile'] }
		    ];

		    // Loop through each module category
		    for (var i = 0; i < modules.length; i++) {
		        const module = Object.keys(modules[i])[0]; // Get the module name (admin, loan, report)
		        const pages = modules[i][module]; // Get the array of pages for this module
		        
		        let count = 0; // Initialize count to track visible pages
		        for (var j = 0; j < pages.length; j++) {
		            if (modulesArray.includes(pages[j])) {
		                document.getElementById(pages[j]).style.display = 'block';
		                count++;
		            } else {
		                document.getElementById(pages[j]).style.display = 'none';
		            }
		        }

		        // If no pages in this module are visible, hide the module itself (e.g., hide the admin section)
		        if (count === 0) {
		            document.getElementById(module).style.display = 'none';
		        }
		    }
		}

</script>
</body>
</html>