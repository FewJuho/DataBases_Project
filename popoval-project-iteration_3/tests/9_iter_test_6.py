import sqlalchemy
import pandas as pd


def test_team_view():
    # Создаем подключение к базе данных
    engine = sqlalchemy.create_engine('postgresql://postgres:password@postgres:5432/postgres')

    # Запрос для создания представления
    create_view_query = """
CREATE VIEW Nba_Schedule.Player_Match_Minutes_Stats AS
SELECT
  p.player_full_name_nm AS player_name,
  m.match_id,
  EXTRACT(EPOCH FROM (h.history_played_to_tm - h.history_played_from_tm)) / 60 AS minutes_played
FROM Nba_Schedule.History_Players_Lineup h
JOIN Nba_Schedule.Player p ON h.history_player_id = p.player_id
JOIN Nba_Schedule.Match m ON h.history_match_id = m.match_id;
    """
    # Выполняем запрос для создания представления
    engine.execute(create_view_query)

    # Запрос для получения данных из представления
    select_query = "SELECT * FROM Nba_Schedule.Player_Match_Minutes_Stats"

    # Выполняем запрос и получаем результат в DataFrame
    df = pd.read_sql_query(select_query, engine)

    assert df.shape[1] == 3

    # Проверяем, что колонки имеют ожидаемые имена
    assert list(df.columns) == ['player_name', 'match_id', 'minutes_played']

    # Проверяем, что DataFrame содержит данные
    assert not df.empty

    check_df = pd.DataFrame({
    'player_name': [
        'Mitchell Robinson', 'Ivica Zubac', 'Omer Yurtseven', 'Mitchell Robinson', 'Boban Marjanovic',
        'Harrison Barnes', 'Talen Horton-Tucker', 'Tyus Jones', 'Freddie Gillespie', 'Trevor Ariza'
    ],
    'match_id': [19, 34, 1, 0, 131, 11, 98, 76, 59, 10],
    'minutes_played': [8.0000000000000000, 18.0000000000000000, 37.0000000000000000, 24.0000000000000000, 38.0000000000000000,
                       3.0000000000000000, 8.0000000000000000, 48.0000000000000000, 11.0000000000000000, 48.0000000000000000]
})

    # Проверка на соответствие по столбцам
    for col in check_df.columns:
        assert list(df[col]) == list(check_df[col])
