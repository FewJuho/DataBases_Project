import sqlalchemy
import pandas as pd


def test_team_view():
    # Создаем подключение к базе данных
    engine = sqlalchemy.create_engine('postgresql://postgres:password@postgres:5432/postgres')

    # Запрос для создания представления
    create_view_query = """
CREATE VIEW Nba_Schedule.Team_City_Match_Stats AS
SELECT
  t.team_full_name AS team_name,
  c.city_full_name_nm AS city_name,
  COUNT(*) AS match_count
FROM Nba_Schedule.Match m
JOIN Nba_Schedule.Team t ON m.match_home_team_id = t.team_id OR m.match_guest_team_id = t.team_id
JOIN Nba_Schedule.City c ON t.team_city_id = c.city_id
GROUP BY t.team_full_name, c.city_full_name_nm;
    """
    # Выполняем запрос для создания представления
    engine.execute(create_view_query)

    # Запрос для получения данных из представления
    select_query = "SELECT * FROM Nba_Schedule.Team_City_Match_Stats"

    # Выполняем запрос и получаем результат в DataFrame
    df = pd.read_sql_query(select_query, engine)

    # Проверяем, что DataFrame содержит шесть колонок
    assert df.shape[1] == 3

    # Проверяем, что колонки имеют ожидаемые имена
    assert list(df.columns) == ['team_name', 'city_name', 'match_count']

    # Проверяем, что DataFrame содержит данные
    assert not df.empty

    check_df = pd.DataFrame({
    'team_name': [
        'Memphis Grizzlies', 'Charlotte Hornets', 'Detroit Pistons', 'Indiana Pacers',
        'Oklahoma City Thunder', 'Portland Trail Blazers', 'LA Clippers', 'Toronto Raptors',
        'Atlanta Hawks', 'Chicago Bulls', 'Philadelphia 76ers', 'New Orleans Pelicans',
        'Houston Rockets', 'Boston Celtics', 'San Antonio Spurs', 'Golden State Warriors',
        'LA Lakers', 'Utah Jazz', 'Brooklyn Nets', 'Cleveland Cavaliers', 'Washington Wizards',
        'New York Knicks', 'Phoenix Suns', 'Orlando Magic', 'Minnesota Timberwolves',
        'Dallas Mavericks', 'Milwaukee Bucks', 'Denver Nuggets', 'Miami Heat', 'Sacramento Kings'
    ],
    'city_name': [
        'Memphis', 'Charlotte', 'Detroit', 'Indianapolis', 'Oklahoma City', 'Portland',
        'Los Angeles', 'Toronto', 'Atlanta', 'Chicago', 'Philadelphia', 'New Orleans',
        'Houston', 'Boston', 'San Antonio', 'San Francisco', 'Los Angeles', 'Salt Lake City',
        'New York City', 'Cleveland', 'Washington, D.C.', 'New York City', 'Phoenix', 'Orlando',
        'Minneapolis', 'Dallas', 'Milwaukee', 'Denver', 'Miami', 'Sacramento'
    ],
    'match_count': [
        28, 29, 28, 28, 28, 28, 28, 28, 29, 29, 28, 28, 28, 29, 28, 28, 28, 28, 29, 29, 28,
        28, 28, 28, 28, 29, 28, 7, 28, 28
    ]
})

    # Проверка на соответствие по столбцам
    for col in check_df.columns:
        assert list(df[col]) == list(check_df[col])
