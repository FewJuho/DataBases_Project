/*top 5 most inhabited cities*/
select city_full_name_nm as city, rank() over(order by(city_citizens_no) desc) as citizens_rank from Nba_Schedule.City limit 5;
