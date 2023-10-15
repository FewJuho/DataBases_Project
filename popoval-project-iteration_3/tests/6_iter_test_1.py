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
    assert select_df.query("year == 2024")['sponsor'].iloc[0] == 0
    assert select_df.query("year == 2024")['sponsor'].iloc[1] == 11
    assert select_df.query("year == 2024")['sponsor'].iloc[2] == 1
