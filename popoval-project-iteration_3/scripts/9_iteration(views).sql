CREATE VIEW Nba_Schedule.Team_View AS
SELECT team_id, team_full_name, team_fans_no
FROM Nba_Schedule.Team;

CREATE VIEW Nba_Schedule.Player_View AS
SELECT player_id, player_full_name_nm, player_contract_price_no
FROM Nba_Schedule.Player;

CREATE VIEW Nba_Schedule.Match_View AS
SELECT match_id, match_home_team_id, match_guest_team_id, match_date_dt
FROM Nba_Schedule.Match;

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


CREATE VIEW Nba_Schedule.Team_City_Match_Stats AS
SELECT
  t.team_full_name AS team_name,
  c.city_full_name_nm AS city_name,
  COUNT(*) AS match_count
FROM Nba_Schedule.Match m
JOIN Nba_Schedule.Team t ON m.match_home_team_id = t.team_id OR m.match_guest_team_id = t.team_id
JOIN Nba_Schedule.City c ON t.team_city_id = c.city_id
GROUP BY t.team_full_name, c.city_full_name_nm;

CREATE VIEW Nba_Schedule.Player_Match_Minutes_Stats AS
SELECT
  p.player_full_name_nm AS player_name,
  m.match_id,
  EXTRACT(EPOCH FROM (h.history_played_to_tm - h.history_played_from_tm)) / 60 AS minutes_played
FROM Nba_Schedule.History_Players_Lineup h
JOIN Nba_Schedule.Player p ON h.history_player_id = p.player_id
JOIN Nba_Schedule.Match m ON h.history_match_id = m.match_id;
