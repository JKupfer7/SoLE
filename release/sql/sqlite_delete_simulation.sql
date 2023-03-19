DELETE FROM tasks
WHERE (record_id = :ID);

DELETE FROM simulations
WHERE (simulation_id = :ID);