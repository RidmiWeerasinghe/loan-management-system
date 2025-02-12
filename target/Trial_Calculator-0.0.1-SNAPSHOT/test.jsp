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
	padding-right: 10px;
}

.li-div {
	display: flex;
	justify-content: space-between;
}

#nav-toggle:checked ~ #nav-header {
  width: calc(var(--navbar-width-min) - 16px);
}
#nav-toggle:checked ~ #nav-content, #nav-toggle:checked ~ #nav-footer {
  width: var(--navbar-width-min);
}
#nav-toggle:checked ~ #nav-header #nav-title {
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.1s;
}
#nav-toggle:checked ~ #nav-header label[for=nav-toggle] {
  left: calc(50% - 8px);
  transform: translate(-50%);
}
#nav-toggle:checked ~ #nav-header #nav-toggle-burger {
  background: var(--navbar-light-primary);
}
#nav-toggle:checked ~ #nav-header #nav-toggle-burger:before, #nav-toggle:checked ~ #nav-header #nav-toggle-burger::after {
  width: 16px;
  background: var(--navbar-light-secondary);
  transform: translate(0, 0) rotate(0deg);
}
#nav-toggle:checked ~ #nav-content .nav-button span {
  opacity: 0;
  transition: opacity 0.1s;
}
#nav-toggle:checked ~ #nav-content .nav-button .fas {
  min-width: calc(100% - 16px);
}
#nav-toggle:checked ~ #nav-footer #nav-footer-avatar {
  margin-left: 0;
  left: 50%;
  transform: translate(-50%);
}
#nav-toggle:checked ~ #nav-footer #nav-footer-titlebox, #nav-toggle:checked ~ #nav-footer label[for=nav-footer-toggle] {
  opacity: 0;
  transition: opacity 0.1s;
  pointer-events: none;
}

#nav-bar {
  position: absolute;
  left: 1vw;
  top: 1vw;
  height: calc(100% - 2vw);
  background: var(--navbar-dark-primary);
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  color: var(--navbar-light-primary);
  font-family: Verdana, Geneva, Tahoma, sans-serif;
  overflow: hidden;
  user-select: none;
}
#nav-bar hr {
  margin: 0;
  position: relative;
  left: 16px;
  width: calc(100% - 32px);
  border: none;
  border-top: solid 1px var(--navbar-dark-secondary);
}
#nav-bar a {
  color: inherit;
  text-decoration: inherit;
}
#nav-bar input[type=checkbox] {
  display: none;
}

#nav-header {
  position: relative;
  width: var(--navbar-width);
  left: 16px;
  width: calc(var(--navbar-width) - 16px);
  min-height: 80px;
  background: var(--navbar-dark-primary);
  border-radius: 16px;
  z-index: 2;
  display: flex;
  align-items: center;
  transition: width 0.2s;
}
#nav-header hr {
  position: absolute;
  bottom: 0;
}

#nav-title {
  font-size: 1.5rem;
  transition: opacity 1s;
}

label[for=nav-toggle] {
  position: absolute;
  right: 0;
  width: 3rem;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

#nav-toggle-burger {
  position: relative;
  width: 16px;
  height: 2px;
  background: var(--navbar-dark-primary);
  border-radius: 99px;
  transition: background 0.2s;
}
#nav-toggle-burger:before, #nav-toggle-burger:after {
  content: "";
  position: absolute;
  top: -6px;
  width: 10px;
  height: 2px;
  background: var(--navbar-light-primary);
  border-radius: 99px;
  transform: translate(2px, 8px) rotate(30deg);
  transition: 0.2s;
}
#nav-toggle-burger:after {
  top: 6px;
  transform: translate(2px, -8px) rotate(-30deg);
}

#nav-content {
  margin: -16px 0;
  padding: 16px 0;
  position: relative;
  flex: 1;
  width: var(--navbar-width);
  background: var(--navbar-dark-primary);
  box-shadow: 0 0 0 16px var(--navbar-dark-primary);
  direction: rtl;
  overflow-x: hidden;
  transition: width 0.2s;
}
#nav-content::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
#nav-content::-webkit-scrollbar-thumb {
  border-radius: 99px;
  background-color: #D62929;
}
#nav-content::-webkit-scrollbar-button {
  height: 16px;
}

#nav-content-highlight {
  position: absolute;
  left: 16px;
  top: -70px;
  width: calc(100% - 16px);
  height: 54px;
  background: var(--background);
  background-attachment: fixed;
  border-radius: 16px 0 0 16px;
  transition: top 0.2s;
}
#nav-content-highlight:before, #nav-content-highlight:after {
  content: "";
  position: absolute;
  right: 0;
  bottom: 100%;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  box-shadow: 16px 16px var(--background);
}
#nav-content-highlight:after {
  top: 100%;
  box-shadow: 16px -16px var(--background);
}

.nav-button {
  position: relative;
  margin-left: 16px;
  height: 54px;
  display: flex;
  align-items: center;
  color: var(--navbar-light-secondary);
  direction: ltr;
  cursor: pointer;
  z-index: 1;
  transition: color 0.2s;
}
.nav-button span {
  transition: opacity 1s;
}
.nav-button .fas {
  transition: min-width 0.2s;
}
.nav-button:nth-of-type(1):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(1):hover ~ #nav-content-highlight {
  top: 16px;
}
.nav-button:nth-of-type(2):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(2):hover ~ #nav-content-highlight {
  top: 70px;
}
.nav-button:nth-of-type(3):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(3):hover ~ #nav-content-highlight {
  top: 124px;
}
.nav-button:nth-of-type(4):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(4):hover ~ #nav-content-highlight {
  top: 178px;
}
.nav-button:nth-of-type(5):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(5):hover ~ #nav-content-highlight {
  top: 232px;
}
.nav-button:nth-of-type(6):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(6):hover ~ #nav-content-highlight {
  top: 286px;
}
.nav-button:nth-of-type(7):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(7):hover ~ #nav-content-highlight {
  top: 340px;
}
.nav-button:nth-of-type(8):hover {
  color: var(--navbar-dark-primary);
}
.nav-button:nth-of-type(8):hover ~ #nav-content-highlight {
  top: 394px;
}

#nav-bar .fas {
  min-width: 3rem;
  text-align: center;
}

#nav-footer {
  position: relative;
  width: var(--navbar-width);
  height: 54px;
  background: var(--navbar-dark-secondary);
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  z-index: 2;
  transition: width 0.2s, height 0.2s;
}

#nav-footer-heading {
  position: relative;
  width: 100%;
  height: 54px;
  display: flex;
  align-items: center;
}

#nav-footer-avatar {
  position: relative;
  margin: 11px 0 11px 16px;
  left: 0;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  overflow: hidden;
  transform: translate(0);
  transition: 0.2s;
}
#nav-footer-avatar img {
  height: 100%;
}

#nav-footer-titlebox {
  position: relative;
  margin-left: 16px;
  width: 10px;
  display: flex;
  flex-direction: column;
  transition: opacity 1s;
}

#nav-footer-subtitle {
  color: var(--navbar-light-secondary);
  font-size: 0.6rem;
}

#nav-toggle:not(:checked) ~ #nav-footer-toggle:checked + #nav-footer {
  height: 30%;
  min-height: 54px;
}
#nav-toggle:not(:checked) ~ #nav-footer-toggle:checked + #nav-footer label[for=nav-footer-toggle] {
  transform: rotate(180deg);
}

label[for=nav-footer-toggle] {
  position: absolute;
  right: 0;
  width: 3rem;
  height: 100%;
  display: flex;
  align-items: center;
  cursor: pointer;
  transition: transform 0.2s, opacity 0.2s;
}

#nav-footer-content {
  margin: 0 16px 16px 16px;
  border-top: solid 1px var(--navbar-light-secondary);
  padding: 16px 0;
  color: var(--navbar-light-secondary);
  font-size: 0.8rem;
  overflow: auto;
}
#nav-footer-content::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
#nav-footer-content::-webkit-scrollbar-thumb {
  border-radius: 99px;
  background-color: #D62929;
}
:root {
  --background: #9c88ff;
  --navbar-width: 256px;
  --navbar-width-min: 80px;
  --navbar-dark-primary: #18283b;
  --navbar-dark-secondary: #2c3e50;
  --navbar-light-primary: #f5f6fa;
  --navbar-light-secondary: #8392a5;
}
</style>
</head>
<body onload="setAccessModulesForLoggedInUser()">
<div id="nav-bar">
  <input id="nav-toggle" type="checkbox"/>
  <div id="nav-header"><a id="nav-title" href="https://codepen.io" target="_blank">C<i class="fab fa-codepen"></i>DEPEN</a>
    <label for="nav-toggle"><span id="nav-toggle-burger"></span></label>
    <hr/>
  </div>
  <div id="nav-content">
    <div class="nav-button"><i class="fas fa-palette"></i><span>Your Work</span></div>
    <div class="nav-button"><i class="fas fa-images"></i><span>Assets</span></div>
    <div class="nav-button"><i class="fas fa-thumbtack"></i><span>Pinned Items</span></div>
    <hr/>
    <div class="nav-button"><i class="fas fa-heart"></i><span>Following</span></div>
    <div class="nav-button"><i class="fas fa-chart-line"></i><span>Trending</span></div>
    <div class="nav-button"><i class="fas fa-fire"></i><span>Challenges</span></div>
    <div class="nav-button"><i class="fas fa-magic"></i><span>Spark</span></div>
    <hr/>
    <div class="nav-button"><i class="fas fa-gem"></i><span>Codepen Pro</span></div>
    <div id="nav-content-highlight"></div>
  </div>
  <input id="nav-footer-toggle" type="checkbox"/>
  <div id="nav-footer">
    <div id="nav-footer-heading">
      <div id="nav-footer-avatar"><img src="https://gravatar.com/avatar/4474ca42d303761c2901fa819c4f2547"/></div>
      <div id="nav-footer-titlebox"><a id="nav-footer-title" href="https://codepen.io/uahnbu/pens/public" target="_blank">uahnbu</a><span id="nav-footer-subtitle">Admin</span></div>
      <label for="nav-footer-toggle"><i class="fas fa-caret-up"></i></label>
    </div>
    <div id="nav-footer-content">
      <Lorem>ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</Lorem>
    </div>
  </div>
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
		        { admin: ['createuser.jsp', 'createusergroups.jsp'] },
		        { loan: ['stakeholders.jsp', 'emicalculator.jsp', 'viewupdateemicalculator.jsp', 'createapplication.jsp', 'viewapplications.jsp', 'applicationapprove.jsp'] },
		        { report: ['printReport.jsp'] }
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