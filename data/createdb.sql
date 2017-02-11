-- localvm script to run file || sudo -u postgres psql < create_db.sql

drop database if exists scholarbase;
drop user if exists scholarbase;

-- create scholarbase user

create user admin createdb createuser password 'scholarbase';

-- create a scholarbase database

create database scholarbase owner admin;

\c scholarbase

CREATE TABLE 

CREATE TABLE student
(
	ssn numeric(9,0) PRIMARY KEY,
	name varchar(120) NOT NULL,
	street varchar(120) NOT NULL,
	city varchar(120) NOT NULL,
	FOREIGN KEY state REFERENCES state.state_abbr NOT NULL, --might be easier to have a states table as a constraint
	sex varchar(10), -- can either add constraint or control with dropdown in ui
	citizen_status boolean, --assuming citizem or not, but if >2 options, switch to varchar
	dob date NOT NULL,
	FOREIGN KEY ethnicity REFERENCES ethnicities.ethnicity  
)

CREATE TABLE high_school
(
	school_id serial PRIMARY KEY,
	FOREIGN KEY state REFERENCES state.state_abbr NOT NULL,
	name varchar(120) NOT NULL,
	is_impoverished boolean NOT NULL,
	is_public boolean NOT NULL
)

CREATE TABLE college
(
	college_id serial PRIMARY KEY,
	is_public boolean NOT NULL,
	college_name varchar(120),
	FOREIGN KEY state REFERENCES state.state_abbr NOT NULL,
)

CREATE TABLE majors
(
	major_id serial PRIMARY KEY,
	type varchar(120) NOT NULL, --need a bit of clarification, is this a set list?
	title varchar(120) NOT NULL
)

CREATE TABLE collegemajors
(
	FOREIGN KEY college_id REFERENCES college.college_id,
	FOREIGN KEY major_id REFERENCES major.major_id,
	PRIMARY KEY (college_id, major_id)
)

CREATE TABLE state
(
	state_abbr char(2) PRIMARY KEY,
	state_name varchar(30)
)

CREATE TABLE ethnicities
(
	ethnicity varchar(25) PRIMARY KEY,
	continental_origin varchar(25) NOT NULL,
	is_minority boolean NOT NULL
)

CREATE TABLE application
(
	app_id serial PRIMARY KEY,
	short_essay text NOT NULL,
	reference_name varchar(120),
	reference_email varchar(120),
	reference_type varchar(30), --should limit to academic, personal, and professional
	reference_verified boolean,
	FOREIGN KEY ssn REFERENCES student.ssn,
	FOREIGN KEY sco_id REFERENCES scholarship.sco_id
)

CREATE TABLE scholarship
(
	sco_id numeric PRIMARY KEY,
	title varchar(120) NOT NULL,
	dollar_value decimal(10,2) NOT NULL,
	FOREIGN KEY company_id REFERENCES company.company_id
	is_awarded boolean -- adding so we can approve scholarships
)

-- coming back to this
-- CREATE TABLE criteria
-- (
-- )

CREATE TABLE company
(
	company_id serial PRIMARY KEY,
	name varchar(50) NOT NULL,
	FOREIGN KEY state REFERENCES state.state_abbr,
	industry varchar(120),
	is_publicly_held boolean
)

