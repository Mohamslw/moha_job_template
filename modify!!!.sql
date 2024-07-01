INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_testjob', 'Testjob', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_testjob', 'Testjob', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('testjob', 'Testjob')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('testjob',0,'recruit','Recruit',20,'{}','{}'),
	('testjob',1,'officer','Officer',40,'{}','{}'),
	('testjob',2,'sergeant','Sergeant',60,'{}','{}'),
	('testjob',3,'boss','Boss',85,'{}','{}')
;

-- do not touch the boss name for the boss menu