select l.locationID, count(e.name) as 'TotalEvents'
from Locations l
join Events e on e.locationID = l.locationID
group by l.locationID