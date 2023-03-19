DELETE FROM tasks
WHERE
	(record_id in (SELECT simulation_setup_id
				   FROM simulation_setups
                   WHERE (project_id = :ID)))
	OR
    (record_id in (SELECT simulation_id
				   FROM simulations s
				   JOIN simulation_setups ss ON (s.simulation_setup_id = ss.simulation_setup_id)
				   WHERE (ss.project_id = :ID))); 

DELETE FROM projects
WHERE (project_id = :ID);
