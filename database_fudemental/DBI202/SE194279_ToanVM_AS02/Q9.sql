

CREATE TRIGGER tr_insert_university_ranking
ON university_ranking_year
AFTER INSERT
AS
BEGIN
  SELECT 
    i.university_id AS id,
    u.university_name AS university_name,
    i.ranking_criteria_id AS ranking_criteria_id,
    rc.criteria_name AS criteria_name,
    i.year AS year,
    i.score AS score
  FROM 
    INSERTED i
  INNER JOIN 
    university u ON u.id = i.university_id
  INNER JOIN 
    ranking_criteria rc ON rc.id = i.ranking_criteria_id;
END;

select * from dbo.university_ranking_year
insert into dbo.university_ranking_year (university_id, ranking_criteria_id, year,score)
values (1,1,2020, 99), (12,2 ,2020, 67)