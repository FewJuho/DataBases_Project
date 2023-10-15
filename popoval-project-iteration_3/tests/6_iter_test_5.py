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
    assert select_df.query("player == 'Russell Westbrook'")['salary rank'].iloc[0] == 1
    assert select_df.query("player == 'James Harden'")['salary rank'].iloc[0] == 2
    assert select_df.query("player == 'Damian Lillard'")['salary rank'].iloc[0] == 1
    assert select_df.query("player == 'Kevin Durant'")['salary rank'].iloc[0] == 1
    assert select_df.query("player == 'Luka Doncic'")['salary rank'].iloc[0] == 1
    assert select_df.query("player == 'Stephen Curry'")['salary rank'].iloc[0] == 1
    assert select_df.query("player == 'John Wall'")['salary rank'].iloc[0] == 1
