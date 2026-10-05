
select uy.university_id, u.university_name, uy.year, uy.student_staff_ratio
from university_year uy
join university u on u.id = uy.university_id
where uy.year = 2015
group by uy.university_id, u.university_name, uy.year, uy.student_staff_ratio


having uy.student_staff_ratio = 
(
	select min(minSr)
	from
	( 
		select uy.student_staff_ratio as minSr
		from university_year uy
		) as temp

);