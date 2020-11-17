/*
Each hospital has nurses which cares about inpatients and assitst doctors
*/
CREATE TABLE Nurses --Creating table for Nurses
(
	nurse_id INT, --Each nurse will have specific ID number 
	fn_name VARCHAR(32), --Of course first name
	ln_name VARCHAR(32), --Then last name
	IIN INT, -- Individual Identification Number of nurse
	hire_date DATE, --When each nurse were hired
	phone_number VARCHAR(64), --Contact number of nurse
	PRIMARY KEY (nurse_id) --And primary key will be ID number of Nurse
);

/*
What hospital would be a hospital without doctors? So, there is a table for doctors
Also foreign key is nurse_id, and it shows which nurse assits doctor
*/ 
CREATE TABLE Doctor --Creating table for Doctors
(
	doctor_id INT, --Each doctor will have specific ID number
	fd_name VARCHAR(30), --First name of doctor
	ld_name VARCHAR(30), --Last name of doctor
	b_day DATE, --Birthday of doctor
	hire_date DATE, --Date when each doctor were hired 
	phone_number VARCHAR(64), --Contact number of doctor
	IIN INT, --Individual Identification Number of doctor
	nurse_id INT, --Which nurse assists doctor
	PRIMARY KEY (doctor_id), --Primary key will be ID num of doctor
	FOREIGN KEY (nurse_id) REFERENCES Nurses(nurse_id) --And foreign key will be ID number of Nurse
);

/*
Since the hospital is multidisciplinary, 
it will have several blocks (2 according to the plan): 
one of them will serve ordinary patients, 
and the second block for wards where inpatients are kept
*/
CREATE TABLE Blocks --Creating table for blocks of multidisciplinary hospital
(
	block_id INT, --Each Block will have specific ID number
	block_name VARCHAR(32), --Name of each block
	floor INT, -- And how many floors in block
	PRIMARY KEY (block_id) -- Primary key will be ID number of Block
);

/*
There are some patients and inpatients who have health insurance. 
And since health insurance can cover different amounts, 
we decided to make a separate table for the types of insurance
*/
CREATE TABLE Type_of_insurance -- Creating table for insurance types of patients or inpatients
(
	ins_id INT, --Each type will have specific ID number
	ins_name VARCHAR(32), --Name of insurance
	ins_cost_tg INT, --And how much the insurance can cover
	PRIMARY KEY (ins_id) --Primary key will be ID number of insurance
);

/*
This table about patients, who will visit this hospital.
If patient will have insurance, for this we have foregn key - "ins_id"
which shows which type of insurance patient has
*/
CREATE TABLE Patient --Creating tabble for patients 
(
	patient_id INT, --Each patient will have specific ID number
	fp_name VARCHAR(32), --First name of patient
	lp_name VARCHAR(32), --Last name of patient
	b_day DATE, --Birth date of patient
	gender VARCHAR(10), --Gender of patient
	mobile_number VARCHAR(64), --Contact number of patient
	ins_id INT, --Which type of insurance each patient have
	PRIMARY KEY (patient_id), --Primary key will be ID number of patient
	FOREIGN KEY (ins_id) REFERENCES Type_of_insurance(ins_id) --And foreign key will be ID number of insurance type
);

/*
Cabinets are one of important parts of hospital.
Because patients are treated here.
Each doctor has own cabinet, which situated in specific block 
and where he can cure patients.
*/
CREATE TABLE Cabinet --Creating table for Cabinets
(
	cabinet_id INT, --Each cabinet will have specific ID number
	attend_time VARCHAR(10), --In which time patient will visit cabinet
	doctor_id INT, --Which doctor sits in the cabinet
	patient_id INT, --Which patient cames in this cabinet
	block_id INT, --In which block cabinet situated
	PRIMARY KEY (cabinet_id), -- Primary key will be ID number of cabinet
	FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id), -- First foreign key will be ID number of Doctor
	FOREIGN KEY (patient_id) REFERENCES Patient(patient_id), -- Second foreign key will be ID number of Patinet
	FOREIGN KEY (block_id) REFERENCES Blocks(block_id) -- Third foreign key will be ID number of block
);

/*
Every hospital can not heal patients without medical equipment.
And each medical equipment placed in cabinets.
*/
CREATE TABLE Medical_equipment --Creating table for medical equipments
(
	medical_equipment_id INT, --Each medical equipment will have specific ID number 
	med_equip_name VARCHAR(64), -- Name of medical equipment
	cabinet_id INT, --In which cabinet this equipment placed
	PRIMARY KEY(medical_equipment_id), --Primary key will be ID number of med.equipment
	FOREIGN KEY(cabinet_id) REFERENCES Cabinet(cabinet_id) -- Foreign key will be ID number of Cabinet
);

/*
Wards are one of important parts of hospital too.
Because inpatients are treated and lies here.
Each ward situated in specific block and
one nurse observes one ward
*/
CREATE TABLE Ward --Creating table for Wards
(
	ward_id INT, --Each Ward will have specific ID number
	ward_name VARCHAR(32), --Name of Ward
	block_id INT, --In which block ward located
	nurse_id INT, --Which Nurse observes ward
	PRIMARY KEY (ward_id), --Primary key will be ID number of Ward
	FOREIGN KEY(block_id) REFERENCES Blocks(block_id), --First foreign key will be ID number of Block
	FOREIGN KEY(nurse_id) REFERENCES Nurses(nurse_id) --Second foreign key will be ID number of Nurse
);

/*
This table about inpatients, who will lay in this hospital.
If inpatient will have insurance, for this we have foregn key - "ins_id"
which shows which type of insurance patient has.
Also we have foreign key - "ward_id", which shows in which ward
inpatient lies.
*/
CREATE TABLE Inpatient --Creating table for Inpatients
(
	inpatient_id INT, --Each inpatient will have specific ID number
	fi_name VARCHAR(32), --First name of inpatient
	li_name VARCHAR(32), --Last name of inpatient 
	b_day DATE, --Birth date of inpatient
	gender VARCHAR (10), --Gender of inpatient
	mobile_number VARCHAR(64), --Contact number of inpatient 
	ins_id INT, --Which type of insurance inpatient has 
	ward_id INT, --In which ward Inpatient lies
	PRIMARY KEY (inpatient_id), --Primary key will ne ID number of Inpatient
	FOREIGN KEY(ins_id) REFERENCES Type_of_insurance(ins_id), --First foreign key will be ID number of Insurance type
	FOREIGN KEY(ward_id) REFERENCES Ward(ward_id) --Second foreign key will be ID number of Ward
);

/*
Each patient and inpatient can not be patient or inpatient
without diagnosis.
*/
CREATE TABLE Diagnosis --Creating table for Diagnosis
(
	diag_id INT, --Each diagnosis will have sprcific ID number 
	diag_name VARCHAR(32), --Name of diagnosis
	PRIMARY KEY (diag_id) --Primary key will be ID number of Diagnosis
);

/*
Why we need hospitals? Of course to treat some illness.
So this table shows treatment for ordinary patients of this 
multidisciplinary hospital, with specific diagnosis. 
*/
CREATE TABLE Treatment_p --Creating table for Treatment of Patients
(
	patient_id INT, --Which patient will have treatment...
	diag_id INT, --...for each diagnosis 
	treat_name VARCHAR(32), --Name of treatment
	treat_cost INT, --How much each treatment costs
	PRIMARY KEY (patient_id, diag_id), --Composite primary key will be ID numbers of Patient and Diagnosis
	FOREIGN KEY (patient_id) REFERENCES Patient(patient_id), --First foreign key will be ID number of Patient
	FOREIGN KEY (diag_id) REFERENCES Diagnosis(diag_id) --Second foreign key will be ID number of Diagnosis
);

/*
And this table is similar to previous,
but only for inpatients.
*/
CREATE TABLE Treatment_in --Creating table for Treatment of Inpatients
(
	inpatient_id INT, --Which inpatient will have tratment...
	diag_id INT, --...for each diagnosis
	treat_name VARCHAR(32), --Name of treatment
	treat_cost INT, --How much each treatment costs
	PRIMARY KEY (inpatient_id, diag_id), --Composite primary key will be ID numbers of Inpatient and Diagnosis
	FOREIGN KEY (inpatient_id) REFERENCES Inpatient(inpatient_id), --First foreign key will be ID number of Inpatient
	FOREIGN KEY (diag_id) REFERENCES Diagnosis(diag_id) --Second foreign key will be ID number of Diagnosis
);