import pandas as pd
import sqlalchemy

def test_team_view():
    # Создаем подключение к базе данных
    engine = sqlalchemy.create_engine('postgresql://postgres:password@postgres:5432/postgres')
    
    # Запрос для создания представления
    create_view_query = """
    CREATE VIEW Nba_Schedule.Player_View AS
    SELECT player_id, player_full_name_nm, player_contract_price_no
    FROM Nba_Schedule.Player;
    """
    # Выполняем запрос для создания представления
    engine.execute(create_view_query)
    
    # Запрос для получения данных из представления
    select_query = "SELECT * FROM Nba_Schedule.Player_View"
    
    # Выполняем запрос и получаем результат в DataFrame
    df = pd.read_sql_query(select_query, engine)
    
    # Проверяем, что DataFrame содержит три колонки
    assert df.shape[1] == 3
    
    # Проверяем, что колонки имеют ожидаемые имена
    assert list(df.columns) == ['player_id', 'player_full_name_nm', 'player_contract_price_no']
    
    # Проверяем, что DataFrame содержит данные
    assert not df.empty
