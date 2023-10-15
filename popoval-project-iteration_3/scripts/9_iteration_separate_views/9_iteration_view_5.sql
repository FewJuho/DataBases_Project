CREATE VIEW Nba_Schedule.Team_City_Match_Stats AS
SELECT
  t.team_full_name AS team_name,
  c.city_full_name_nm AS city_name,
  COUNT(*) AS match_count
FROM Nba_Schedule.Match m
JOIN Nba_Schedule.Team t ON m.match_home_team_id = t.team_id OR m.match_guest_team_id = t.team_id
JOIN Nba_Schedule.City c ON t.team_city_id = c.city_id
GROUP BY t.team_full_name, c.city_full_name_nm;
