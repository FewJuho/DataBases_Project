/*divide sponsors into three groups and write sponsors' names only from the second group*/
with count_appearences 
as (
  select distinct match_sponsor_id, count(match_sponsor_id) over(partition by match_sponsor_id) as count 
  from Nba_Schedule.Match
)

select s.sponsor_full_name_nm as "Sponsor", ntile(3) over(order by count desc) as "Sponsor rank" 
from count_appearences as c INNER JOIN Nba_Schedule.Sponsor as s ON s.sponsor_id = c.match_sponsor_id
offset 10 fetch next 10 rows only;
