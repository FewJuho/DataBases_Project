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
    assert select_df.query("city == 'New York City'")['citizens_rank'].iloc[0] == 1
    assert select_df.query("city == 'Toronto'")['citizens_rank'].iloc[0] == 2
    assert select_df.query("city == 'Los Angeles'")['citizens_rank'].iloc[0] == 3
    assert select_df.query("city == 'Chicago'")['citizens_rank'].iloc[0] == 4
    assert select_df.query("city == 'Houston'")['citizens_rank'].iloc[0] == 5
