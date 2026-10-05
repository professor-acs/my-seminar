select e.name as 'EventName', l.Name as 'LocationName', s.name as 'StaffName' from Events e
join workFor w on w.eventID = e.eventID
join Locations l on l.locationID = e.locationID
join Staffs s on s.staffID = w.staffID
