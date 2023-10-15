import sqlalchemy
import pandas as pd


def test_team_view():
    # Создаем подключение к базе данных
    engine = sqlalchemy.create_engine('postgresql://postgres:password@postgres:5432/postgres')

    # Запрос для создания представления
    create_view_query = """
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

    """
    # Выполняем запрос для создания представления
    engine.execute(create_view_query)

    # Запрос для получения данных из представления
    select_query = "SELECT * FROM Nba_Schedule.Player_Salary_Stats"

    # Выполняем запрос и получаем результат в DataFrame
    df = pd.read_sql_query(select_query, engine)

    # Проверяем, что DataFrame содержит шесть колонок
    assert df.shape[1] == 6

    # Проверяем, что колонки имеют ожидаемые имена
    assert list(df.columns) == ['player_id', 'player_full_name_nm', 'player_contract_price_no', 'player_sponsor_name',
                                'player_team_name', 'player_city_name']

    # Проверяем, что DataFrame содержит данные
    assert not df.empty

    check_df = pd.DataFrame({
        'player_id': [10, 11, 32, 61, 90, 120, 151, 170],
        'player_full_name_nm': ['Kevin Durant', 'James Harden', 'Russell Westbrook', 'John Wall', 'Luka Doncic',
                                'Stephen Curry', 'Russell Westbrook', 'Damian Lillard'],
        'player_contract_price_no': [42000000, 41000000, 44000000, 44211146, 40250000, 43006362, 44000000, 43545455],
        'player_sponsor_name': ['Reebok', 'K1X', 'Under Armour', 'Anta', 'Nike', 'New Balance', 'Anta', 'New Balance'],
        'player_team_name': ['Boston Celtics', 'Boston Celtics', 'Charlotte Hornets', 'Dallas Mavericks',
                             'Golden State Warriors', 'LA Clippers', 'Miami Heat', 'Minnesota Timberwolves'],
        'player_city_name': ['Boston', 'Boston', 'Charlotte', 'Dallas', 'San Francisco', 'Los Angeles', 'Miami',
                             'Minneapolis']
    })

    # Проверка на соответствие по столбцам
    for col in check_df.columns:
        assert list(df[col]) == list(check_df[col])
