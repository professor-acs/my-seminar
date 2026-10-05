create table tblStudents
(
	stid nchar(7) primary key,
	name nvarchar(25) not null,
	birthday date,
	phone nvarchar(15)
	)
create table tblSubjects
(
	subid nchar(6) primary key,
	subname nvarchar(50) not null,
	unit int
)
create table Result
(
		
		stid nchar(7) foreign key(stid) references tblStudents,
		subid nchar(6) foreign key (subid) references tblSubjects,
		score01 float,
		score02 float
)