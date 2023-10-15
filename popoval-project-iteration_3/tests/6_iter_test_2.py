import os
import pytest
from . import execute_sql_to_df
from . import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )

def test(select_df):
    assert select_df.query("player == 'John Wall'")['salary'].iloc[0] == 44211146
    assert select_df.query("player == 'Russell Westbrook'")['salary'].iloc[0] == 44000000
    assert select_df.query("player == 'Damian Lillard'")['salary'].iloc[0] == 43545455
    assert select_df.query("player == 'Stephen Curry'")['salary'].iloc[0] == 43006362
    assert select_df.query("player == 'Kevin Durant'")['salary'].iloc[0] == 42000000
    assert select_df.query("player == 'James Harden'")['salary'].iloc[0] == 41000000
    assert select_df.query("player == 'Luka Doncic'")['salary'].iloc[0] == 40250000
    assert select_df.query("player == 'Giannis Antetokounmpo'")['salary'].iloc[0] == 39328000
    assert select_df.query("player == 'LeBron James'")['salary'].iloc[0] == 39219565
    assert select_df.query("player == 'Jimmy Butler'")['salary'].iloc[0] == 36666667
