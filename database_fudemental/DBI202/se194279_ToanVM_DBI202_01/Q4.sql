select e.eventID, count(w.staffID) as 'NumberStaff'
from  Events e
join workFor w on w.eventID = e.eventID
join Staffs s on s.staffID = w.staffID
group by e.eventID
having count(w.staffID) >= 2
