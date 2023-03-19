DELETE FROM tasks
WHERE
	(record_id = :ID)
	OR
    (record_id in (SELECT simulation_id
				   FROM simulations
				   WHERE (simulation_setup_id = :ID))); 

DELETE FROM simulation_setups
WHERE (simulation_setup_id = :ID);
