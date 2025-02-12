function clearErrorMessages(id){
	const element = document.getElementById(id);
	if (element) {
        element.style.display = "none";
    }
}
function convertToUpperCase(id){
	const element = document.getElementById(id);
	if (element) {
		element.value = element.value.toUpperCase();
    }
}
function displayValidationErrors(id){
	var errorId = id+"-error";
	const element = document.getElementById(errorId);
	if (element) {
        element.style.display = "block";
    }
}
function filterTable(tableId, searchFieldId) {
    const searchInput = document.getElementById(searchFieldId).value.toLowerCase();
    const table = document.getElementById(tableId);
    const rows = table.getElementsByTagName('tr');

    for (let i = 1; i < rows.length; i++) { // Start from 1 to skip the header row
        const cells = rows[i].getElementsByTagName('td');
        let isMatch = false;

        // Loop through all cells in the row
        for (let j = 0; j < cells.length; j++) {
            const cell = cells[j];
            if (cell && cell.textContent.toLowerCase().includes(searchInput)) {
                isMatch = true;
                break;
            }
        }

        // Show or hide the row based on match
        rows[i].style.display = isMatch ? '' : 'none';
    }
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

    // gender
    if (dayOfYear > 500) {
        gender = "Female";
        dayOfYear -= 500; //females
    } else {
        gender = "Male";
    }

    //if leap year
    const isLeapYear = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);

    // Days in month
    const daysInMonths = [31, isLeapYear ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Find the month and day by subtracting days
    let month = 0;
    while (dayOfYear > daysInMonths[month]) {
        dayOfYear -= daysInMonths[month];
        month++;
    }

    // Format the final date in YYYY-MM-DD
    dob = `${year}-${(month + 1).toString().padStart(2, '0')}-${dayOfYear.toString().padStart(2, '0')}`;

    return { dateOfBirth: dob, gender: gender };
}
