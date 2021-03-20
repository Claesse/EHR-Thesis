pragma solidity ^0.5.2;

contract EHR {

	address owner;
	uint public patientCount;
	mapping(uint => Patient) public patients;
	uint public doctorCount;
	mapping(uint => Doctor) public doctors;
	mapping (address => bool) profileExists;

	// Model a patient
	struct Patient {

		// Identifiers
		uint id;
		string name;
		uint birthyear;
		uint month;
		uint day;
		string city;

		// Health record
		string[] records;
		// Doctor list
		string[] doctorAccess;

	}
	// Register
	function registerPatient(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city) public {
		owner = msg.sender;
		require(!profileExists[owner]);
		patientCount++;
		patients[patientCount] = Patient(patientCount, _name, _birthyear, _month, _day, _city);
		profileExists[owner] = true;

	}

	struct Doctor{

	// Identifiers
	uint id;
	string name;
	uint birthyear;
	uint month;
	uint day;
	string city;
	string speciality;

	// Patient List
	string[] patientAccess;
	

	}

	function registerDoctor(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city, string memory _speciality) public {
		owner = msg.sender;
		require(!profileExists[owner]);
		doctorCount++;
		doctors[doctorCount] = Doctor(doctorCount, _name, _birthyear, _month, _day, _city, _speciality);
		profileExists[owner] = true;
	}
	
}

