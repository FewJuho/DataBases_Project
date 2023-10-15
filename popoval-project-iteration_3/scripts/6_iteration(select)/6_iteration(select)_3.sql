/*date with the most games*/
with dates as (
  select match_date_dt, count(match_id) over (partition by match_date_dt) from Nba_Schedule.Match
)
select distinct match_date_dt as "date", count as "count" from dates where count = (select max(count) from dates);
