USE FUH_COMPANY
/* Ho ten: Vo Minh Toan, MSSV: SE194279 */
/* 1 */
Select e.empSSN, e.empName, d.depNum, d.depName 
from tblDepartment d, tblEmployee e
where d.mgrSSN = e.empSSN
and depName = N'Phòng Nghiên cứu và phát triển'
/* 2 */
Select p.proNum, p.proName, d.depName 
from tblDepartment d, tblProject p
where d.depNum = p.depNum 										
and depName = N'Phòng Nghiên cứu và phát triển'
/* 3 */
Select p.proNum, p.proName, d.depName
from tblDepartment d, tblProject p
where p.depNum = d.depNum
and proName = 'ProjectB'
/* 4 */
Select empSSN, empName
from tblEmployee 
where supervisorSSN = 30121050004
/* 5 */
Select e.empSSN, k.empName
from tblEmployee e, tblEmployee k
where e.empName = N'Mai Duy An' 
and e.supervisorSSN = k.empSSN
/* 6 */
Select l.locNum, l.locName
from tblProject p, tblLocation l
where p.proName = 'ProjectA'

/* 7 */
Select p.proNum, p.proName
from tblProject p, tblLocation l
where l.locName = N'TP Hồ Chí Minh'
and p.locNum = l.locNum
/* 8 */
Select d.depName, d.depBirthdate, e.empName
from tblEmployee e, tblDependent d
where YEAR(getDate()) - YEAR (d.depBirthdate) >= 18
and e.empSSN = d.empSSN
/* 9 */
Select d.depName, d.depBirthdate, e.empName
from tblEmployee e, tblDependent d
where d.depSex = 'M'
and e.empSSN = d.empSSN

/* 10 */
Select d.depNum, d.depName, l.locName
from tblDepartment d, tblLocation l, tblDeplocation dl
where d.depName = N'Phòng Nghiên Cứu và phát triển'
and d.depNum = dl.depNum and l.locNum = dl.locNum 
/* 11 */
Select p.proNum, p.proName, d.depName
from tblProject p, tblDepartment d, tblLocation l
where l.locName = N'TP Hồ Chí Minh'
and d.depNum = p.depNum and l.locNum = p.locNum 
/* 12 */
Select e.empName, de.depName, de.depRelationship
from tblEmployee e, tblDependent de, tblDepartment d
where d.depName = N'Phòng Nghiên cứu và phát triển'
and de.depSex = 'F' 
and e.depNum = d.depNum
and e.empSSN = de.empSSN
/* 13 */
Select e.empName, de.depName, de.depRelationship
from tblEmployee e, tblDependent de, tblDepartment d
where d.depName = N'Phòng Nghiên cứu và phát triển'
and YEAR(getDate()) - YEAR(de.depBirthdate) > 18
and e.depNum = d.depNum
and e.empSSN = de.empSSN
/* 14 */
Select d.depSex 'Giới tính', Count(*) as 'Số lượng người phụ thuộc'
from tblDependent d
group by d.depSex

/* 15 */
Select d.depRelationship as 'Mối liên hệ', Count(*) as 'Số lượng người phụ thuộc'
from tblDependent d
group by d.depRelationship
/* 16 */
SELECT d.depNum, d.depName, COUNT(dep.depName) as 'Số lượng người phụ thuộc'
FROM tblDepartment d
JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName;


/* 17 */
SELECT d.depNum, d.depName, COUNT(dep.depName) AS 'Số lượng người phụ thuộc'
FROM tblDepartment d
JOIN tblEmployee e ON d.depNum = e.depNum
LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName
HAVING COUNT(dep.depName) = (
    SELECT MIN(dependentCount)
    FROM (
        SELECT COUNT(dep.depName) AS dependentCount
        FROM tblDepartment d
        JOIN tblEmployee e ON d.depNum = e.depNum
        LEFT JOIN tblDependent dep ON e.empSSN = dep.empSSN
        GROUP BY d.depNum
    ) AS temp
);

/* 18 */
SELECT d.depNum, d.depName, COUNT(dep.depName) AS 'Số lượng người phụ thuộc'
FROM tblDepartment d
JOIN tblEmployee e ON d.depNum = e.depNum
JOIN tblDependent dep ON e.empSSN = dep.empSSN
GROUP BY d.depNum, d.depName
HAVING COUNT(dep.depName) = (
    SELECT MAX(dependentCount)
    FROM (
        SELECT COUNT(dep.depName) AS dependentCount
        FROM tblDepartment d
        JOIN tblEmployee e ON d.depNum = e.depNum
        JOIN tblDependent dep ON e.empSSN = dep.empSSN
        GROUP BY d.depNum
    ) AS temp
);
/* 19 */
SELECT e.empSSN, e.empName, d.depName, SUM(w.workhours) AS totalWorkHours
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
JOIN tblDepartment d ON e.depNum = d.depNum
GROUP BY e.empSSN, e.empName, d.depName;

/* 20 */
select d.depNum, d.depName, SUM(w.workHours) as 'Tổng số giờ'
from tblDepartment d
join tblProject p on p.depNum = d.depNum
join tblWorksOn w on w.proNum = p.proNum
group by d.depNum, d.depName;
/* 21 */
SELECT e.empSSN, e.empName, sum(w.workHours) as 'WorkHours'
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
JOIN tblProject p ON p.proNum = w.proNum
GROUP BY e.empSSN, e.empName
Having sum(w.workHours) = 
(
	SELECT min(minWorkHour) 
	FROM 
	(	select sum(w.workHours) as minWorkHour
		from tblEmployee e
		JOIN tblWorksOn w ON e.empSSN = w.empSSN
		JOIN tblProject p ON p.proNum = w.proNum

		GROUP BY e.empSSN, e.empName
	) as temp
);

/* 22 */
SELECT e.empSSN, e.empName, sum(w.workHours) as 'WorkHours'
FROM tblEmployee e
JOIN tblWorksOn w ON e.empSSN = w.empSSN
JOIN tblProject p ON p.proNum = w.proNum
GROUP BY e.empSSN, e.empName
Having sum(w.workHours) = 
(
	SELECT max(minWorkHour) 
	FROM 
	(	select sum(w.workHours) as minWorkHour
		from tblEmployee e
		JOIN tblWorksOn w ON e.empSSN = w.empSSN
		JOIN tblProject p ON p.proNum = w.proNum

		GROUP BY e.empSSN, e.empName
	) as temp
);
/* 23 */
SELECT e.empSSN, e.empName, COUNT(w.proNum)
FROM tblEmployee e
JOIN tblDepartment d on d.depNum = e.depNum
Join tblWorksOn w on w.empSSN = e.empSSN
JOIN tblProject p ON p.proNum = w.proNum

GROUP BY e.empSSN, e.empName
Having count(p.proNum) = 1

/* 24 */
SELECT e.empSSN, e.empName, COUNT(w.proNum)
FROM tblEmployee e
JOIN tblDepartment d on d.depNum = e.depNum
Join tblWorksOn w on w.empSSN = e.empSSN
JOIN tblProject p ON p.proNum = w.proNum

GROUP BY e.empSSN, e.empName
Having count(p.proNum) = 2
/* 25 */
SELECT e.empSSN, e.empName, COUNT(w.proNum)
FROM tblEmployee e
JOIN tblDepartment d on d.depNum = e.depNum
Join tblWorksOn w on w.empSSN = e.empSSN
JOIN tblProject p ON p.proNum = w.proNum
GROUP BY e.empSSN, e.empName
Having count(p.proNum) >= 2
/* 26 */
use FUH_COMPANY
select p.proNum, p.proName, count(*)
from tblProject p, tblEmployee e, tblWorksOn w
where w.empSSN = e.empSSN
and p.proNum = w.proNum
group by p.proNum, p.proName
/* 27 */
use FUH_COMPANY
select p.proNum, p.proName, sum(w.workHours) as 'So gio'
from tblProject p, tblEmployee e, tblWorksOn w
where w.empSSN = e.empSSN
and p.proNum = w.proNum
group by p.proNum, p.proName
/* 28 */
SELECT p.proNum, p.proName, count(e.empSSN) as 'SO luong thanh vien'
FROM tblProject p
JOIN tblWorksOn w ON p.proNum = w.proNum
JOIN tblEmployee e ON e.empSSN = w.empSSN
GROUP BY p.proNum, p.proName
Having count(e.empSSN) = 
(
	SELECT min(minWorkHour) 
	FROM 
	(	select count(e.empSSN) as minWorkHour
		FROM tblProject p
		JOIN tblWorksOn w ON p.proNum = w.proNum
		JOIN tblEmployee e ON e.empSSN = w.empSSN
		GROUP BY p.proNum, p.proName
	) as temp
);
/* 29 */
SELECT p.proNum, p.proName, count(e.empSSN) as 'SO luong thanh vien'
FROM tblProject p
JOIN tblWorksOn w ON p.proNum = w.proNum
JOIN tblEmployee e ON e.empSSN = w.empSSN
GROUP BY p.proNum, p.proName
Having count(e.empSSN) = 
(
	SELECT max(minWorkHour) 
	FROM 
	(	select count(e.empSSN) as minWorkHour
		FROM tblProject p
		JOIN tblWorksOn w ON p.proNum = w.proNum
		JOIN tblEmployee e ON e.empSSN = w.empSSN
		GROUP BY p.proNum, p.proName
	) as temp
);
/* 30 */
SELECT p.proNum, p.proName, sum(w.workHours) as 'WorkHours'
FROM tblProject p
JOIN tblWorksOn w ON p.proNum = w.proNum
JOIN tblEmployee e ON e.empSSN = w.empSSN
GROUP BY p.proNum, p.proName
Having sum(w.workHours) = 
(
	SELECT min(minWorkHour) 
	FROM 
	(	select sum(w.workHours) as minWorkHour
		FROM tblProject p
		JOIN tblWorksOn w ON p.proNum = w.proNum
		JOIN tblEmployee e ON e.empSSN = w.empSSN
		GROUP BY p.proNum, p.proName
	) as temp
);


/* 31 */
SELECT p.proNum, p.proName, sum(w.workHours) as 'WorkHours'
FROM tblProject p
JOIN tblWorksOn w ON p.proNum = w.proNum
JOIN tblEmployee e ON e.empSSN = w.empSSN
GROUP BY p.proNum, p.proName
Having sum(w.workHours) = 
(
	SELECT max(minWorkHour) 
	FROM 
	(	select sum(w.workHours) as minWorkHour
		FROM tblProject p
		JOIN tblWorksOn w ON p.proNum = w.proNum
		JOIN tblEmployee e ON e.empSSN = w.empSSN
		GROUP BY p.proNum, p.proName
	) as temp
);
/* 32 */
SELECT l.locName, count(d.depName) as 'So phong ban'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by l.locName
/* 33 */
SELECT d.depName, count(l.locName) as 'So cho lam viec'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by d.depName

/* 34 */
select d.depName, count(l.locName) as 'So cho lam viec'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by d.depName
having count(l.locName) =
(
	SELECT max(Socholamviec)
	from(
		select count(l.locName) as Socholamviec
		from tblLocation l, tblDepartment d, tblDepLocation dl
		where l.locNum = dl.locNum
		and d.depNum = dl.depNum
		group by d.depName
		)as temp
);

/* 35 */
select d.depName, count(l.locName) as 'So cho lam viec'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by d.depName
having count(l.locName) =
(
	SELECT min(Socholamviec)
	from(
		select count(l.locName) as Socholamviec
		from tblLocation l, tblDepartment d, tblDepLocation dl
		where l.locNum = dl.locNum
		and d.depNum = dl.depNum
		group by d.depName
		)as temp
);
/* 36 */

select l.locName, count(d.depName) as 'So phong ban'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by l.locName
having count(d.depName) =
(
	SELECT max(Sophongban)
	from(
		select count(d.depName) as Sophongban
		from tblLocation l, tblDepartment d, tblDepLocation dl
		where l.locNum = dl.locNum
		and d.depNum = dl.depNum
		group by l.locName
		)as temp
);
/* 37 */
select l.locName, count(d.depName) as 'So phong ban'
from tblLocation l, tblDepartment d, tblDepLocation dl
where l.locNum = dl.locNum
and d.depNum = dl.depNum
group by l.locName
having count(d.depName) =
(
	SELECT min(Sophongban)
	from(
		select count(d.depName) as Sophongban
		from tblLocation l, tblDepartment d, tblDepLocation dl
		where l.locNum = dl.locNum
		and d.depNum = dl.depNum
		group by l.locName
		)as temp
);
/* 38 */
select e.empName, count(d.empSSN) as 'So nguoi phu thuoc'
from tblEmployee e
left join tblDependent d on d.empSSN = e.empSSN
group by e.empName
having count(d.empSSN) =
(
	SELECT max(Sophongban)
	from(
		select  e.empName, count(d.empSSN) as Sophongban
		from tblEmployee e
		left join tblDependent d on d.empSSN = e.empSSN
		group by e.empName
		)as temp
);
/* 39 */
select e.empName, count(d.empSSN) as 'So nguoi phu thuoc'
from tblEmployee e
left join tblDependent d on d.empSSN = e.empSSN
group by e.empName
having count(d.empSSN) =
(
	SELECT min(Sophongban)
	from(
		select  e.empName, count(d.empSSN) as Sophongban
		from tblEmployee e
		left join tblDependent d on d.empSSN = e.empSSN
		group by e.empName
		)as temp
);
/* 40 */
select e.empName, count(d.empSSN) as 'So nguoi phu thuoc'
from tblEmployee e
left join tblDependent d on d.empSSN = e.empSSN
group by e.empName
having count(d.empSSN) = 0;

/* 41 */
select d.depName, count(dp.empSSN) as 'So nguoi phu thuoc'
from tblDepartment d
left join tblEmployee e on e.depNum = d.depNum
left join tblDependent dp on dp.empSSN = e.empSSN
group by d.depName
having count(dp.empSSN) = 0;
/* 42 */
SELECT e.empSSN, e.empName, d.depName
FROM tblEmployee e
left JOIN tblDepartment d on d.depNum = e.depNum
left Join tblWorksOn w on w.empSSN = e.empSSN
left JOIN tblProject p ON p.proNum = w.proNum
GROUP BY e.empSSN, e.empName, d.depName
Having count(p.proNum) = 0
/* 43 */
SELECT d.depNum, d.depName
FROM tblDepartment d
left JOIN tblEmployee e on d.depNum = e.depNum
left Join tblWorksOn w on w.empSSN = e.empSSN
left JOIN tblProject p ON p.proNum = w.proNum
GROUP BY d.depNum, d.depName
Having count(p.proNum) = 0
/* 44 */ 
SELECT d.depNum, d.depName
FROM tblDepartment d
WHERE d.depNum NOT IN (
    SELECT e.depNum
    FROM tblEmployee e
    JOIN tblWorksOn w ON e.empSSN = w.empSSN
    JOIN tblProject p ON w.proNum = p.proNum
    WHERE p.depNum = e.depNum AND p.proName = 'ProjectA'
    
);

/* 45 */
SELECT d.depNum, d.depName, count(p.proNum) as 'So luong du an'
FROM tblDepartment d
left JOIN tblProject p ON p.depNum = d.depNum
GROUP BY d.depNum, d.depName


/* 46 */
SELECT d.depNum, d.depName, count(p.proNum) as 'So luong du an'
FROM tblDepartment d
left JOIN tblProject p ON p.depNum = d.depNum
GROUP BY d.depNum, d.depName
having count(p.proNum) =
(
	select MIN(counta)
	from (
		SELECT count(p.proNum) as counta
		FROM tblDepartment d
		left JOIN tblProject p ON p.depNum = d.depNum
		GROUP BY d.depNum, d.depName
		)
		as temp
);
/* 47 */
SELECT d.depNum, d.depName, count(p.proNum) as 'So luong du an'
FROM tblDepartment d
left JOIN tblProject p ON p.depNum = d.depNum
GROUP BY d.depNum, d.depName
having count(p.proNum) =
(
	select max(counta)
	from (
		SELECT count(p.proNum) as counta
		FROM tblDepartment d
		left JOIN tblProject p ON p.depNum = d.depNum
		GROUP BY d.depNum, d.depName
		)
		as temp
);


/* 48 */
select d.depNum, d.depName, count(distinct e.empSSN) as 'So nhan vien', p.proName
from tblDepartment d
left join tblProject p on p.depNum = d.depNum
left join tblEmployee e on e.depNum = d.depNum
group by d.depNum, d.depName, p.proName
having count(distinct e.empSSN) >= 5

/* 49 */
select e.empSSN, e.empName
from tblEmployee e
left join tblDepartment d on d.depNum = e.depNum
left join tblDependent dp on dp.empSSN = e.empSSN
where d.depName like N'Phòng nghiên cứu%'
group by e.empSSN, e.empName
having  count(dp.depName) = 0
/* 50 */
select e.empSSN, e.empName, sum(w.workHours)
from tblEmployee e
join tblWorksOn w on w.empSSN = e.empSSN
left join tblDependent dp on dp.empSSN = e.empSSN

group by e.empSSN, e.empName
having  count(dp.depName) = 0
/* 51 */
select e.empSSN, e.empName, sum(w.workHours)
from tblEmployee e
join tblWorksOn w on w.empSSN = e.empSSN
left join tblDependent dp on dp.empSSN = e.empSSN

group by e.empSSN, e.empName
having count(distinct dp.depName) >= 3
/* 52 */
Select e.empSSN, e.empName, count(w.workHours) as'Tong so gio lam'
from tblEmployee e
left join tblWorksOn w
on e.empSSN = w.empSSN
where e.supervisorSSN = 30121050004
group by e.empSSN, e.empName




















