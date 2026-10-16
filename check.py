import sqlite3
import pandas as pd

conn = sqlite3.connect('data/olist.db')
print(pd.read_sql('SELECT COUNT(*) AS n_orders FROM orders', conn))