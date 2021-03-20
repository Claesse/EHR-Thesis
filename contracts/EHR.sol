pragma solidity ^0.5.2;
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
		address[] doctorAccess;

	}
	// Register patient
	function registerPatient(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city) public {
		owner = msg.sender;
		require(!profileExists[owner]);
		//patientCount++;
		patients[owner] = Patient(owner, _name, _birthyear, _month, _day, _city, new string[](0), new address[](0));
		profileExists[owner] = true;

	}
	// Give doctor access to records.
	// Need to solve require.
	function giveAccess(address _doctor) public {
		patients[msg.sender].doctorAccess.push(_doctor);
	}
	// Revoke doctor access to records.
	// Need to solve require.
	function revokeAccess(address _doctor) public {
		for (uint i = 0; i<patients[msg.sender].doctorAccess.length; i++) {
			if (patients[msg.sender].doctorAccess[i] == _doctor) {
				delete patients[msg.sender].doctorAccess[i];
			}
		}
    }

    function viewRecord(address _patient) public view returns (string[] memory){
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
	string[] patientAccess;
	

	}
	// Register doctor
	function registerDoctor(string memory _name, uint _birthyear, uint _month, uint _day, string memory _city, string memory _speciality) public {
		owner = msg.sender;
		require(!profileExists[owner]);
		//doctorCount++;
		doctors[owner] = Doctor(owner, _name, _birthyear, _month, _day, _city, _speciality, new string[](0));
		profileExists[owner] = true;
	}
	
}

