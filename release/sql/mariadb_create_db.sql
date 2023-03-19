/* Script for creating the data structures in a SoLE database
 * SolE database version: 1
 * Created by Janis Kupfer 2020, 2021
 * Target Server: MariaDB
*/
 
/* 
 * Creating the database given in %s 
*/ 
CREATE SCHEMA %s;

/* 
 * Select the created database for use 
*/ 
USE %s;

/*
 * Table structure for table dbsettings
*/
CREATE TABLE dbsettings (
  setting_name varchar(100) NOT NULL,
  setting_value varchar(100) DEFAULT NULL,
  PRIMARY KEY (setting_name)
);

/*
 * Dumping data for table dbsettings
*/
INSERT INTO dbsettings VALUES ('database_version','1');

/*
 * Table structure for table projects
*/
CREATE TABLE projects (
  project_id char(36) NOT NULL,
  name varchar(100) NOT NULL,
  description text,
  population_number int NOT NULL,
  default_infectious_on_start int NOT NULL,
  default_simulation_duration int NOT NULL,
  mean_contacts double NOT NULL,
  deviation_contacts double NOT NULL,
  mean_contact_probability double NOT NULL,
  deviation_contact_probability double NOT NULL,
  mean_susceptibility double NOT NULL,
  deviation_susceptibility double NOT NULL,
  mean_infectiousness double NOT NULL,
  deviation_infectiousness double NOT NULL,
  mean_initial_immunity double NOT NULL,
  deviation_initial_immunity double NOT NULL,
  mean_mortality double NOT NULL,
  deviation_mortality double NOT NULL,
  mean_infectious_delay_period double NOT NULL,
  deviation_infectious_delay_period double NOT NULL,
  mean_infectious_period double NOT NULL,
  deviation_infectious_period double NOT NULL,
  mean_incubation_period double NOT NULL,
  deviation_incubation_period double NOT NULL,
  mean_disease_period double NOT NULL,
  deviation_disease_period double NOT NULL,
  mean_halving_immunity_period double NOT NULL,
  deviation_halving_immunity_period double NOT NULL,
  mean_immunity_period double NOT NULL,
  deviation_immunity_period double NOT NULL,
  PRIMARY KEY (project_id)
);

/*
 * Table structure for table simulation_setups
*/
CREATE TABLE simulation_setups (
  simulation_setup_id char(36) NOT NULL,
  project_id char(36) NOT NULL,
  name varchar(100) NOT NULL,
  default_simulation_duration int NOT NULL,
  infectious_on_start int NOT NULL,
  setup_state varchar(100) NOT NULL,
  PRIMARY KEY (simulation_setup_id),
  KEY fk_simulation_setups_projects1_idx (project_id),
  CONSTRAINT fk_simulation_setups_projects1
    FOREIGN KEY (project_id) REFERENCES projects (project_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table simulation_people
*/
CREATE TABLE simulation_people (
  person_id char(36) NOT NULL,
  simulation_setup_id char(36) NOT NULL,
  person_number int NOT NULL,
  contacts int NOT NULL,
  initial_day_of_infectious int NOT NULL,
  susceptibility double NOT NULL,
  infectiousness double NOT NULL,
  infectious_delay_period int NOT NULL,
  infectious_period int NOT NULL,
  incubation_period int NOT NULL,
  disease_period int NOT NULL,
  halving_immunity_period int NOT NULL,
  immunity_period int NOT NULL,
  initial_immunity double NOT NULL,
  mortality double NOT NULL,
  PRIMARY KEY (person_id),
  KEY fk_simulation_people_simulation_setups1_idx (simulation_setup_id),
  CONSTRAINT fk_simulation_people_simulation_setups1
    FOREIGN KEY (simulation_setup_id) REFERENCES simulation_setups (simulation_setup_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table person_knows_person
*/
CREATE TABLE person_knows_person (
  person_knows_person_id char(36) NOT NULL,
  person1_id char(36) NOT NULL,
  person2_id char(36) NOT NULL,
  contact_probability double NOT NULL,
  PRIMARY KEY (person_knows_person_id),
  KEY fk_simulation_people_has_simulation_people_simulation_peopl_idx (person2_id),
  KEY fk_simulation_people_has_simulation_people_simulation_peopl_idx1 (person1_id),
  CONSTRAINT fk_simulation_people_has_simulation_people_simulation_people1
    FOREIGN KEY (person1_id) REFERENCES simulation_people (person_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_simulation_people_has_simulation_people_simulation_people2
    FOREIGN KEY (person2_id) REFERENCES simulation_people (person_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table simulations
*/
CREATE TABLE simulations (
  simulation_id char(36) NOT NULL,
  simulation_setup_id char(36) NOT NULL,
  name varchar(100) NOT NULL,
  description text,
  simulation_duration int NOT NULL,
  number_of_runs int NOT NULL,
  PRIMARY KEY (simulation_id),
  KEY fk_simulations_simulation_setups1_idx (simulation_setup_id),
  CONSTRAINT fk_simulations_simulation_setups1
    FOREIGN KEY (simulation_setup_id) REFERENCES simulation_setups (simulation_setup_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table simulation_days
*/
CREATE TABLE simulation_days (
  simulation_day_id char(36) NOT NULL,
  simulation_id char(36) NOT NULL,
  day_number int NOT NULL,
  mean_susceptible double DEFAULT NULL,
  deviation_susceptible double DEFAULT NULL,
  delta_susceptible double DEFAULT NULL,
  mean_incubated double DEFAULT NULL,
  deviation_incubated double DEFAULT NULL,
  delta_incubated double DEFAULT NULL,
  mean_diseased double DEFAULT NULL,
  deviation_diseased double DEFAULT NULL,
  delta_diseased double DEFAULT NULL,
  mean_infected double DEFAULT NULL,
  deviation_infected double DEFAULT NULL,
  delta_infected double DEFAULT NULL,
  mean_immune double DEFAULT NULL,
  deviation_immune double DEFAULT NULL,
  delta_immune double DEFAULT NULL,
  mean_deceased double DEFAULT NULL,
  deviation_deceased double DEFAULT NULL,
  delta_deceased double DEFAULT NULL,
  mean_removed double DEFAULT NULL,
  deviation_removed double DEFAULT NULL,
  delta_removed double DEFAULT NULL,
  mean_infectious double DEFAULT NULL,
  deviation_infectious double DEFAULT NULL,
  delta_infectious double DEFAULT NULL,
  mean_reproduction double DEFAULT NULL,
  deviation_reproduction double DEFAULT NULL,
  delta_reproduction double DEFAULT NULL,
  mean_infection_risk double DEFAULT NULL,
  deviation_infection_risk double DEFAULT NULL,
  delta_infection_risk double DEFAULT NULL,
  mean_infected_last_7_days double DEFAULT NULL,
  deviation_infected_last_7_days double DEFAULT NULL,
  delta_infected_last_7_days double DEFAULT NULL,
  mean_new_infected double DEFAULT NULL,
  deviation_new_infected double DEFAULT NULL,
  delta_new_infected double DEFAULT NULL,
  PRIMARY KEY (simulation_day_id),
  KEY fk_simulation_days_simulations1_idx (simulation_id),
  CONSTRAINT fk_simulation_days_simulations1
    FOREIGN KEY (simulation_id) REFERENCES simulations (simulation_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table countermeasures
*/
CREATE TABLE countermeasures (
  countermeasure_id char(36) NOT NULL,
  simulation_id char(36) NOT NULL,
  name varchar(100) NOT NULL,
  measure_type varchar(100) NOT NULL,
  description text NOT NULL,
  startday int NOT NULL,
  endday int DEFAULT NULL,
  PRIMARY KEY (countermeasure_id),
  KEY fk_countermeasures_simulations1_idx (simulation_id),
  CONSTRAINT fk_countermeasures_simulations1
    FOREIGN KEY (simulation_id) REFERENCES simulations (simulation_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table simulation_run_days
*/
CREATE TABLE simulation_run_days (
  simulation_run_day_id char(36) NOT NULL,
  simulation_day_id char(36) NOT NULL,
  day_number int NOT NULL,
  run_number int NOT NULL,
  count_susceptible int DEFAULT NULL,
  count_incubated int DEFAULT NULL,
  count_diseased int DEFAULT NULL,
  count_infected int GENERATED ALWAYS AS ((count_incubated + count_diseased)) VIRTUAL,
  count_immune int DEFAULT NULL,
  count_deceased int DEFAULT NULL,
  count_removed int GENERATED ALWAYS AS ((count_immune + count_deceased)) VIRTUAL,
  count_infectious int DEFAULT NULL,
  delta_susceptible int DEFAULT NULL,
  delta_incubated int DEFAULT NULL,
  delta_diseased int DEFAULT NULL,
  delta_infected int GENERATED ALWAYS AS ((delta_incubated + delta_diseased)) VIRTUAL,
  delta_immune int DEFAULT NULL,
  delta_deceased int DEFAULT NULL,
  delta_removed int GENERATED ALWAYS AS ((delta_immune + delta_deceased)) VIRTUAL,
  delta_infectious int DEFAULT NULL,
  reproduction_count_infected int DEFAULT NULL,
  reproduction_count_infectious int DEFAULT NULL,
  count_new_infected int DEFAULT '0',
  infected_history_1 int DEFAULT '0',
  infected_history_2 int DEFAULT '0',
  infected_history_3 int DEFAULT '0',
  infected_history_4 int DEFAULT '0',
  infected_history_5 int DEFAULT '0',
  infected_history_6 int DEFAULT '0',
  infected_history_7 int DEFAULT '0',
  sum_infected_7_days int GENERATED ALWAYS AS (((((((infected_history_1 + infected_history_2) + infected_history_3) + infected_history_4) + infected_history_5) + infected_history_6) + infected_history_7)) VIRTUAL,
  count_risky_contacts int DEFAULT '0',
  PRIMARY KEY (simulation_run_day_id),
  KEY fk_simulation_run_days_simulation_days1_idx (simulation_day_id),
  CONSTRAINT fk_simulation_run_days_simulation_days1
    FOREIGN KEY (simulation_day_id) REFERENCES simulation_days (simulation_day_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table simulation_people_status
*/
CREATE TABLE simulation_people_status (
  status_id char(36) NOT NULL,
  run_day_id char(36) NOT NULL,
  person_id char(36) NOT NULL,
  current_immunity double NOT NULL DEFAULT '0',
  days_left_incubated int NOT NULL DEFAULT '0',
  days_left_diseased int NOT NULL DEFAULT '0',
  days_left_infectious_delay int NOT NULL DEFAULT '0',
  days_left_infectious int NOT NULL DEFAULT '0',
  days_left_immune int NOT NULL DEFAULT '0',
  count_risky_contacts int NOT NULL DEFAULT '0',
  count_infected int NOT NULL DEFAULT '0',
  sum_infected int NOT NULL DEFAULT '0',
  incubated tinyint GENERATED ALWAYS AS ((days_left_incubated > 0)) VIRTUAL,
  diseased tinyint GENERATED ALWAYS AS ((days_left_diseased > 0)) VIRTUAL,
  infected tinyint GENERATED ALWAYS AS (((0 <> incubated) or (0 <> diseased))) VIRTUAL,
  immune tinyint GENERATED ALWAYS AS (((days_left_immune > 0) and (0 = infected) and (0 = deceased))) VIRTUAL,
  deceased tinyint NOT NULL DEFAULT '0',
  removed tinyint GENERATED ALWAYS AS (((0 <> immune) or (0 <> deceased))) VIRTUAL,
  susceptible tinyint GENERATED ALWAYS AS (((0 = infected) and (0 = removed))) VIRTUAL,
  infectious tinyint GENERATED ALWAYS AS ((days_left_infectious > 0)) VIRTUAL,
  PRIMARY KEY (status_id),
  KEY fk_simulation_peoble_status_simulation_run_days1_idx (run_day_id),
  KEY fk_simulation_peoble_status_simulation_people1_idx (person_id),
  CONSTRAINT fk_simulation_peoble_status_simulation_people1
    FOREIGN KEY (person_id) REFERENCES simulation_people (person_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_simulation_peoble_status_simulation_run_days1
    FOREIGN KEY (run_day_id) REFERENCES simulation_run_days (simulation_run_day_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*
 * Table structure for table risky_contacts
*/
CREATE TABLE risky_contacts (
  contacts_id char(36) NOT NULL,
  simulation_run_day_id char(36) NOT NULL,
  infectious_person_id char(36) NOT NULL,
  contact_person_id char(36) NOT NULL,
  contact_took_place tinyint NOT NULL,
  immunity_works tinyint NOT NULL,
  infection_took_place tinyint NOT NULL,
  PRIMARY KEY (contacts_id),
  KEY fk_risky_contacts_simulation_run_days_idx (simulation_run_day_id),
  KEY fk_risky_contacts_simulation_people1_idx (infectious_person_id),
  KEY fk_risky_contacts_simulation_people2_idx (contact_person_id),
  CONSTRAINT fk_risky_contacts_simulation_people1
	FOREIGN KEY (infectious_person_id) REFERENCES simulation_people (person_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_risky_contacts_simulation_people2
	FOREIGN KEY (contact_person_id) REFERENCES simulation_people (person_id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_risky_contacts_simulation_run_days
	FOREIGN KEY (simulation_run_day_id) REFERENCES simulation_run_days (simulation_run_day_id)
	ON DELETE CASCADE ON UPDATE CASCADE
);


/*
 * Table structure for table tasks
*/
CREATE TABLE tasks (
  task_id char(36) NOT NULL,
  record_id char(36) NOT NULL,
  task_type varchar(100) NOT NULL,
  task_priority int NOT NULL,
  task_status varchar(100) NOT NULL,
  task_owner varchar(100) DEFAULT NULL,
  day_number int DEFAULT NULL,
  run_number int DEFAULT NULL,
  created_on date DEFAULT NULL,
  first_start_on datetime DEFAULT NULL,
  last_start_on datetime DEFAULT NULL,
  completed_on datetime DEFAULT NULL,
  calculation_time time DEFAULT NULL,
  PRIMARY KEY (task_id)
);

/*
 * Definition of view view_tasks
*/
CREATE VIEW view_tasks AS
	SELECT
		t1.task_id AS task_id,
		t1.record_id AS record_id,
		t1.task_type AS task_type,
		t1.task_priority AS task_priority,
		t1.task_status AS task_status,
		t1.task_owner AS task_owner,
		t1.day_number AS day_number,
		t1.run_number AS run_number,
		t1.created_on AS created_on,
        t1.first_start_on AS first_start_on,
        t1.last_start_on AS last_start_on,
        t1.completed_on AS completed_on,
        t1.calculation_time AS calculation_time,
        p1.name AS project_name,
        ss1.name AS task_description
	FROM tasks t1
	JOIN simulation_setups ss1 ON (t1.record_id = ss1.simulation_setup_id)
	JOIN projects p1 ON (ss1.project_id = p1.project_id)
	WHERE (t1.task_type = 'Setup Initialization')
    UNION
    SELECT
		t2.task_id AS task_id,
        t2.record_id AS record_id,
        t2.task_type AS task_type,
        t2.task_priority AS task_priority,
        t2.task_status AS task_status,
        t2.task_owner AS task_owner,
        t2.day_number AS day_number,
        t2.run_number AS run_number,
        t2.created_on AS created_on,
        t2.first_start_on AS first_start_on,
        t2.last_start_on AS last_start_on,
        t2.completed_on AS completed_on,
        t2.calculation_time AS calculation_time,
        p2.name AS project_name,
        s2.name AS task_description
	FROM tasks t2
    JOIN simulations s2 ON (t2.record_id = s2.simulation_id)
    JOIN simulation_setups ss2 ON (s2.simulation_setup_id = ss2.simulation_setup_id)
    JOIN projects p2 ON (ss2.project_id = p2.project_id)
    WHERE (t2.task_type <> 'Setup Initialization');
	
/*
 * Definition of view view_day_zero_run_people
*/
CREATE VIEW view_day_zero_run_people AS
	SELECT
		s.simulation_id,
		sp.person_id,
		sp.person_number,
		sp.initial_day_of_infectious,
		sp.susceptibility,
		sp.infectiousness,
		sp.mortality,
		sp.initial_immunity,
		sp.incubation_period,
		sp.disease_period,
		sp.infectious_delay_period,
		sp.infectious_period,
		sp.halving_immunity_period,
		sp.immunity_period
	FROM simulations s
	JOIN simulation_setups ss ON (s.simulation_setup_id = ss.simulation_setup_id)
	JOIN simulation_people sp ON (ss.simulation_setup_id = sp.simulation_setup_id);

/*
 * Definition of view view_people_previous_status
*/
CREATE VIEW view_people_previous_status AS
	SELECT 
		sps.*,
		sd.simulation_id,
		srd.day_number,
		srd.run_number,
		sp.person_number,
		sp.initial_day_of_infectious,
		sp.susceptibility,
		sp.infectiousness,
		sp.mortality,
		sp.initial_immunity,
		sp.incubation_period,
		sp.disease_period,
		sp.infectious_delay_period,
		sp.infectious_period,
		sp.halving_immunity_period,
		sp.immunity_period
		FROM simulation_people_status sps
		JOIN simulation_run_days srd ON (sps.run_day_id = srd.simulation_run_day_id)
		JOIN simulation_people sp ON (sps.person_id = sp.person_id)
		JOIN simulation_days sd ON (srd.simulation_day_id = sd.simulation_day_id);	
