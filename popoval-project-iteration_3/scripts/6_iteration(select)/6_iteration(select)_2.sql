/*top 10 highest paid players*/
select DISTINCT player_full_name_nm as player, player_contract_price_no as salary
from Nba_Schedule.Player order by player_contract_price_no DESC limit 10;
