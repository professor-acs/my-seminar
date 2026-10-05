

select ury.university_id, u.university_name, ury.ranking_criteria_id, rc.criteria_name, ury.year, ury.score
from ranking_criteria rc 
join university_ranking_year ury on ury.ranking_criteria_id = rc.id
join university u on u.id = ury.university_id
where ury.year = 2016 and rc.criteria_name = 'Teaching'
AND ury.score IN (
        SELECT score 
        FROM university_ranking_year 
        WHERE year = 2016 
          AND ranking_criteria_id = rc.id 
        GROUP BY score 
        HAVING COUNT(*) > 1
    )
group by ury.university_id, u.university_name, ury.ranking_criteria_id, rc.criteria_name, ury.year, ury.score
order by ury.score desc