
select rc.ranking_system_id as 'system_id', rs.system_name, count(rc.criteria_name) as 'numberOfCriteria'
from ranking_criteria rc
join ranking_system rs on rs.id = rc.ranking_system_id
group by rc.ranking_system_id, rs.system_name
order by count(rc.criteria_name) desc

