/*All Teams*/
select * from Nba_Schedule.Team;

/*most popular Team*/
SELECT MAX(team_fans_no) FROM Nba_Schedule.Team;

/*Find amount of gamedays*/
SELECT count(DISTINCT match_date_dt) from Nba_Schedule.Match;

/*Lets suppose, that 14th sponsor goes bankrupt*/
UPDATE Nba_Schedule.Player SET player_sponsor_id = NULL WHERE player_sponsor_id = 14;
UPDATE Nba_Schedule.Coach SET coach_sponsor_id = NULL WHERE coach_sponsor_id = 14;
UPDATE Nba_Schedule.Team SET team_sponsor_id = NULL WHERE team_sponsor_id = 14;
UPDATE Nba_Schedule.Match SET match_sponsor_id = NULL WHERE match_sponsor_id = 14;
select * from Nba_Schedule.Sponsor;
DELETE FROM Nba_Schedule.Sponsor WHERE sponsor_id = 14;
select * from Nba_Schedule.Sponsor;

/*CRUD in SQL - CREATE, SELECT, UPDATE, DELETE*/
