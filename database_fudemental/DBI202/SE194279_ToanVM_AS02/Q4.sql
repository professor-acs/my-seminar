select uy.university_id, u.university_name, uy.year, uy.num_students, uy.pct_international_students, u.country_id from university u
join university_year uy on uy.university_id = u.id
where uy.pct_international_students > 30 and uy.year = 2016
order by  u.university_name asc