select e.eventID, e.name, e.StartTime, e.EndTime, l.locationID
from Events e
join Locations l on l.locationID = e.locationID
join workFor w on w.eventID = e.eventID
join Staffs s on s.staffID = w.staffID
group by e.eventID, e.name, e.StartTime, e.EndTime, l.locationID
having count(s.name) > 1
