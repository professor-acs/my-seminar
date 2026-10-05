create procedure proc_university_year  @year int, @pct_international_students int, @nbUniversity int output
as
	set @nbUniversity =
	(	
		select count(university_id) 
		from university_year
		where pct_international_students > @pct_international_students
		
		and year = @year
	)
go


