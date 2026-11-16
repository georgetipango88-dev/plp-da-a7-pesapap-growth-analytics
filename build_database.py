
import sqlite3
import pandas as pd

# Read the generated datasets
users = pd.read_csv("users.csv")
transactions = pd.read_csv("transactions.csv")
experiment = pd.read_csv("experiment.csv")

# Connect to SQLite
conn = sqlite3.connect("pesapap.db")
conn.execute("PRAGMA foreign_keys = ON")

# Create tables with primary and foreign keys
conn.executescript("""
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    signup_date TEXT NOT NULL,
    county TEXT,
    acquisition_channel TEXT
);

CREATE TABLE IF NOT EXISTS transactions (
    txn_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    txn_date TEXT NOT NULL,
    product TEXT,
    amount REAL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS experiment (
    user_id INTEGER PRIMARY KEY,
    "group" TEXT NOT NULL,
    converted INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
""")

# Clear existing records so rerunning is safe
conn.execute("DELETE FROM transactions")
conn.execute("DELETE FROM experiment")
conn.execute("DELETE FROM users")

# Load data in foreign-key-safe order
users.to_sql("users", conn, if_exists="append", index=False)
transactions.to_sql("transactions", conn, if_exists="append", index=False)
experiment.to_sql("experiment", conn, if_exists="append", index=False)

conn.commit()

# Verify record counts
for table in ["users", "transactions", "experiment"]:
    count = conn.execute(
        f"SELECT COUNT(*) FROM {table}"
    ).fetchone()[0]
    print(f"{table}: {count}")

# Check referential integrity
violations = conn.execute(
    "PRAGMA foreign_key_check"
).fetchall()

print("Foreign key violations:", len(violations))
print("Database created successfully!")

conn.close()
