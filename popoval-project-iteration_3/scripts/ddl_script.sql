create schema if not exists Nba_Schedule;

create table if not exists Nba_Schedule.City (
    city_id serial primary key,
city_full_name_nm varchar(30) not null,
    city_citizens_no integer not null
);

create table if not exists Nba_Schedule.Sponsor (
    sponsor_id serial primary key,
sponsor_full_name_nm varchar(30) not null
);

create table if not exists Nba_Schedule.Player (
    player_id serial primary key,
player_full_name_nm varchar(30) not null,
    player_contract_price_no integer not null,
player_sponsor_id integer,
    foreign key(player_sponsor_id) references Nba_Schedule.Sponsor(sponsor_id)
);

create table if not exists Nba_Schedule.Coach (
    coach_id serial primary key,
coach_full_name_nm varchar(30) not null,
    coach_contract_price_no integer not null,
coach_sponsor_id integer,
    foreign key(coach_sponsor_id) references Nba_Schedule.Sponsor(sponsor_id)
);


create table if not exists Nba_Schedule.Players_Lineup (
    players_lineup_id serial primary key,
players_lineup_PG_id integer,
    players_lineup_SG_id integer,
players_lineup_SF_id integer,
    players_lineup_PF_id integer,
players_lineup_C_id integer,

    foreign key(players_lineup_PG_id) references Nba_Schedule.Player(player_id),
    foreign key(players_lineup_SG_id) references Nba_Schedule.Player(player_id),
    foreign key(players_lineup_SF_id) references Nba_Schedule.Player(player_id),
    foreign key(players_lineup_PF_id) references Nba_Schedule.Player(player_id),
    foreign key(players_lineup_C_id) references Nba_Schedule.Player(player_id)
);

create table if not exists Nba_Schedule.Team (
    team_id serial primary key,
team_full_name varchar(30) not null,
    team_fans_no integer not null,
team_coach_id integer,
    team_lineup_id integer not null,
team_sponsor_id integer,
team_city_id integer,
    foreign key(team_coach_id) references Nba_Schedule.Coach(coach_id),
    foreign key(team_lineup_id) references Nba_Schedule.Players_Lineup(players_lineup_id),
    foreign key(team_sponsor_id) references Nba_Schedule.Sponsor(sponsor_id),
    foreign key(team_city_id) references Nba_Schedule.City(city_id)
);

create table if not exists Nba_Schedule.Match (
    match_id serial primary key,
match_home_team_id integer not null,
    match_guest_team_id integer not null,
match_date_dt date not null,
    match_sponsor_id integer,
foreign key(match_home_team_id) references Nba_Schedule.Team(team_id),
    foreign key(match_guest_team_id) references Nba_Schedule.Team(team_id),
    foreign key(match_sponsor_id) references Nba_Schedule.Sponsor(sponsor_id)
);

create table if not exists Nba_Schedule.History_Players_Lineup (
    history_player_id integer,
    history_match_id integer,
foreign key (history_match_id) references Nba_Schedule.Match(match_id),    
foreign key (history_player_id) references Nba_Schedule.Player(player_id),
    history_played_from_tm time not null,
history_played_to_tm time not null
);
