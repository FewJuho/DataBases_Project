CREATE VIEW Nba_Schedule.Player_Match_Minutes_Stats AS
SELECT
  p.player_full_name_nm AS player_name,
  m.match_id,
  EXTRACT(EPOCH FROM (h.history_played_to_tm - h.history_played_from_tm)) / 60 AS minutes_played
FROM Nba_Schedule.History_Players_Lineup h
JOIN Nba_Schedule.Player p ON h.history_player_id = p.player_id
JOIN Nba_Schedule.Match m ON h.history_match_id = m.match_id;
