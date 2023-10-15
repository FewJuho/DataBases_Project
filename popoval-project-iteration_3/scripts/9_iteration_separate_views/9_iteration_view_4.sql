CREATE VIEW Nba_Schedule.Player_Salary_Stats AS
SELECT
  p.player_id,
  p.player_full_name_nm,
  p.player_contract_price_no,
  s.sponsor_full_name_nm AS player_sponsor_name,
  t.team_full_name AS player_team_name,
  c.city_full_name_nm AS player_city_name
FROM Nba_Schedule.Player p
JOIN Nba_Schedule.Sponsor s ON s.sponsor_id = p.player_sponsor_id
JOIN Nba_Schedule.Team t ON t.team_id = (floor(player_id / 10))
JOIN Nba_Schedule.City c ON c.city_id = t.team_city_id
where player_contract_price_no > 40000000;
