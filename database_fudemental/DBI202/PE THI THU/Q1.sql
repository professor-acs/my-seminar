
create table Department
(
	DeptID varchar(20) primary key,
	name nvarchar(200),
	Office nvarchar(100)
)

create table Employees
(
	EmpCode varchar(20) primary key,
	Name nvarchar(50),
	BirthDate Date,
	DeptID varchar(20) foreign key(DeptID) references Department
)
create table Dependants
(
	Number int primary key,
	Name nvarchar(50),
	BirthDate date,
	Role nvarchar(30),
	EmpCode varchar(20) foreign key(EmpCode) references Employees
)

