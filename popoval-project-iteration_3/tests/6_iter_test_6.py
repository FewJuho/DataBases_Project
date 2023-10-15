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
    assert select_df.query("Sponsor == 'Fila'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Peak'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'New Balance'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Mizuno'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Under Armour'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Molten'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Legea'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Uhlsport'")['Sponsor rank'].iloc[0] == 2
    assert select_df.query("Sponsor == 'Wilson'")['Sponsor rank'].iloc[0] == 2
