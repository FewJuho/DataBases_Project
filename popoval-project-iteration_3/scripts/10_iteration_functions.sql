/*finds the average value of contract price for the players who are in the team with the given id*/
CREATE OR REPLACE FUNCTION get_average_contract_price(team_id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    avg_price NUMERIC;
BEGIN
    SELECT AVG(player_contract_price_no) INTO avg_price
    FROM Nba_Schedule.Player p
    JOIN Nba_Schedule.Team t ON p.player_id = t.team_lineup_id
    WHERE t.team_id = team_id;
    
    RETURN avg_price;
END;
$$ LANGUAGE plpgsql;

/*updates the contract price for all players in the team with the given id*/
CREATE OR REPLACE PROCEDURE update_contract_price(team_id INTEGER, new_price INTEGER)
AS $$
BEGIN
    UPDATE Nba_Schedule.Player p
    SET player_contract_price_no = new_price
    WHERE p.player_sponsor_id = team_id;
END;
$$ LANGUAGE plpgsql;

/*function to get a list of matches that took place in a given city*/
CREATE FUNCTION Nba_Schedule.get_matches_by_city(city_name varchar(30))
RETURNS TABLE (
    match_id integer,
    match_home_team_id integer,
    match_guest_team_id integer,
    match_date_dt date,
    match_sponsor_id integer
) AS $$
BEGIN
    RETURN QUERY SELECT match_id, match_home_team_id, match_guest_team_id, match_date_dt, match_sponsor_id 
                 FROM Nba_Schedule.Match m 
                 JOIN Nba_Schedule.Team ht ON m.match_home_team_id = ht.team_id 
                 JOIN Nba_Schedule.Team gt ON m.match_guest_team_id = gt.team_id
                 JOIN Nba_Schedule.City c ON ht.team_city_id = c.city_id
                 WHERE c.city_full_name_nm = city_name;
END;
$$ LANGUAGE plpgsql;
