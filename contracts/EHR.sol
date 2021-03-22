pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract EHR {

	address owner;
	//uint public patientCount;
	mapping(address => Patient) public patients;
	//uint public doctorCount;
	mapping(address=> Doctor) public doctors;
	mapping(address => bool) profileExists;

	// Model a patient
	struct Patient {

		// Identifiers
		address id;
		string name;
		uint birthyear;
		uint month;
		uint day;
		string city;

		// Health record
		string[] records;
		// Doctor list
		mapping(address => bool) doctors;

	}
	// Register patient
	function registerPatient(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city) public {
		Patient memory pat;
		pat.name = _name;
		pat.birthyear = _birthyear;
		pat.month = _month;
		pat.day = _day;
		pat.city = _city;
		owner = msg.sender;
		require(!profileExists[owner]);
		patients[owner] = pat;
		profileExists[owner] = true;

	}
	// Give doctor access to records.
	function giveAccess(address _doctor) public {
		owner = msg.sender;
		require(msg.sender == owner);
		patients[msg.sender].doctors[_doctor] = true;
		doctors[_doctor].patientAccess[msg.sender] = true;
	}
	// Revoke doctor access to records.
	function revokeAccess(address _doctor) public {
		owner = msg.sender;
		require(msg.sender == owner);
		patients[owner].doctors[_doctor] = false;
		doctors[_doctor].patientAccess[msg.sender] = false;
    }

    function drViewRecord(address _patient) public view returns (string[] memory){
    	require(patients[_patient].doctors[msg.sender] == true);
    	return patients[_patient].records;
    }

    function patViewRecord(address _patient) public view returns (string[] memory){
    	require(_patient == msg.sender);
    	return patients[_patient].records;
    }


	struct Doctor {

	// Identifiers
	address id;
	string name;
	uint birthyear;
	uint month;
	uint day;
	string city;
	string speciality;

	// Patient List
	mapping(address => bool) patientAccess;
	

	}
	// Register doctor
	function registerDoctor(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city, string memory _speciality) public {
		owner = msg.sender;
		Doctor memory doc;
		doc.name = _name;
		doc.birthyear = _birthyear;
		doc.month = _month;
		doc.day = _day;
		doc.city = _city;
		doc.speciality = _speciality;
		require(!profileExists[owner]);
		//doctorCount++;
		doctors[owner] = doc;
		profileExists[owner] = true;
	}

	function updateHR(address _patient, string memory newEntry) public {
		owner = msg.sender;
		require(doctors[owner].patientAccess[_patient] == true);
		patients[_patient].records.push(newEntry);
	}
	
}

