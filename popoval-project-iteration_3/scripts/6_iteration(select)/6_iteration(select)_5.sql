/*name + rank in the team for all players with salary >= 40000000*/
SELECT distinct player_full_name_nm as player, rank() OVER (PARTITION BY floor(player_id / 10) ORDER BY player_contract_price_no DESC) AS "salary rank"
FROM Nba_Schedule.Player
WHERE player_contract_price_no >= 40000000;
