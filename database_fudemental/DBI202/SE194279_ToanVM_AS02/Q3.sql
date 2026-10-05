select ranking_system_id, criteria_name
from ranking_criteria
where ranking_system_id = 1 or ranking_system_id = 2
order by ranking_system_id asc, criteria_name asc