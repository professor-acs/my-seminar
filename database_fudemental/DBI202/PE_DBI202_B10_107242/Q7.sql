select l.Name 
from Locations l
join Events e on e.locationID = l.locationID
group by l.Name
having count(e.name) = (
	select max(N) from
	(
	select count(e.name) as N
	from Locations l
	join Events e on e.locationID = l.locationID
	group by l.Name
	) as temp
);