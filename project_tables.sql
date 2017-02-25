/*
Lewis Cannalongo
Fraser Torning
CS500 Fundamentals of Databases Winter 2017
*/


CREATE TABLE states
(
	state_abbr char(2) PRIMARY KEY,
	state_name varchar(30)
);

CREATE TABLE ethnicity
(
	ethnicity varchar(25) PRIMARY KEY,
	continental_origin varchar(25) NOT NULL,
	is_minority boolean NOT NULL
);

CREATE TABLE majors
(
	major_id serial PRIMARY KEY,
	type varchar(120) NOT NULL,
	title varchar(120) NOT NULL,
	is_stem boolean NOT NULL
);

CREATE TABLE company
(
	company_id serial PRIMARY KEY,
	name varchar(50) NOT NULL,
	company_state varchar(2) REFERENCES states (state_abbr),
	industry varchar(120),
	is_publicly_held boolean
);

CREATE TABLE scholarship
(
	sco_id serial PRIMARY KEY,
	title varchar(120) NOT NULL,
	dollar_value decimal(10,2) NOT NULL,
	company_id integer REFERENCES company (company_id) not null,
	is_awarded boolean
);

CREATE TABLE high_school
(
	school_id varchar(20) PRIMARY KEY,
	hs_state varchar(2) REFERENCES states (state_abbr) NOT NULL,
	name varchar(120) NOT NULL,
	is_impoverished boolean NOT NULL,
	is_public boolean NOT NULL
);

CREATE TABLE college
(
	college_id varchar(20) PRIMARY KEY,
	is_public boolean NOT NULL,
	college_name varchar(120),
	college_state varchar(2) REFERENCES states (state_abbr) NOT NULL
);

CREATE TABLE collegemajors
(
	college_id varchar(20) REFERENCES college (college_id),
	major_id integer REFERENCES majors (major_id),
	national_rank integer,
	PRIMARY KEY (college_id, major_id)
);

CREATE TABLE student
(
	ssn numeric(9,0) PRIMARY KEY,
	name varchar(120) NOT NULL,
	street varchar(120) NOT NULL,
	city varchar(120) NOT NULL,
	res_state varchar(2) REFERENCES states (state_abbr) NOT NULL,
	sex varchar(10),
	us_citizen boolean,
	dob date NOT NULL,
	ethnicity varchar(25) REFERENCES ethnicity (ethnicity),
	college_major integer references majors (major_id),
	college varchar(20) references college (college_id) not null,
	college_gpa double precision,
	academic_probation boolean,
	high_school varchar(20) references high_school (school_id) not null,
	hs_grad_year integer,
	hs_gpa double precision,
	hs_class_rank integer
);

create table scholarship_applications (
	short_essay text NOT NULL,
	reference_name varchar(120),
	reference_email varchar(120),
	reference_type varchar(30), --should limit to academic, personal, and professional
	reference_verified boolean,
	application_date date not null,
	applicant numeric(9,0) references student (ssn) not null,
	scholarship integer references scholarship (sco_id) not null,
	primary key (applicant, scholarship)
);


create table scholarship_criteria
(
	sco_id integer references scholarship (sco_id) not null,
	criteria_type varchar(20) not null,
	criteria_attribute varchar(20) not null,
	criteria_value varchar(20) not null,
	primary key (sco_id, criteria_type, criteria_attribute, criteria_value)
);

/*
create_table approved_applications
(
 	applicant numeric(9,0) references scholarship_applications (applicant),
	scholarship integer references scholarship_applications (scholarship),
	approved boolean,
	primary key (applicant, scholarship, approved)
*/