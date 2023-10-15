/*Sponsor who sponsored more than 10 matches and the year in which this happened*/
SELECT extract(year from match_date_dt) as year, match_sponsor_id as sponsor
FROM Nba_Schedule.Match
GROUP BY year, sponsor
HAVING count(match_sponsor_id) > 10;
