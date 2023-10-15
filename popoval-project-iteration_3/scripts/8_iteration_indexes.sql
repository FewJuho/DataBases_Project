/*Nba_Schedule.Player field player_sponsor_id is a foreign key, so creating an index on this field can speed up queries*/
CREATE INDEX idx_player_sponsor_id ON Nba_Schedule.Player (player_sponsor_id);

/*Nba_Schedule.Player field player_sponsor_id is a foreign key, so creating an index on this field can speed up queries*/
CREATE INDEX idx_coach_sponsor_id ON Nba_Schedule.Coach (coach_sponsor_id);

/*The Nba_Schedule.Match table uses the match_date_dt field to filter data by match date, so creating an index on this field can speed up queries that search for matches by date*/
CREATE INDEX idx_history_player_id ON Nba_Schedule.History_Players_Lineup (history_player_id);

/*NNba_Schedule.Coach field coach_sponsor_id is a foregn key, so creating an index on this field can speed up queries*/
CREATE INDEX idx_team_lineup_id ON Nba_Schedule.Team (team_lineup_id);

/*Nba_Schedule.Team field team_lineup_id is a foreign key to the Nba_Schedule.Players_Lineup table, so creating an index on this field can speed up the execution of queries that are related to the Players_Lineup table*/
CREATE INDEX idx_match_date_dt ON Nba_Schedule.Match (match_date_dt);

/*In the Nba_Schedule.History_Players_Lineup table, the history_player_id and hisrory_match_id are foreign keys, so creating indexes on these fields can speed up queries that are related to the Player and Match tables*/
CREATE INDEX idx_history_match_id ON Nba_Schedule.History_Players_Lineup (history_match_id);
