#!/usr/bin/env python3
"""Simple SQL runner: supports SQLite by default.

Usage examples:
  python3 run_sql.py --sqlfile slq-learning/weak1.sql
  python3 run_sql.py --sqlfile slq-learning/weak1.sql --dbfile mydata.db

For MySQL/Postgres: see README for instructions.
"""
import argparse
import os
import sqlite3
import sys


def run_sqlite(sqlfile: str, dbfile: str):
    if not os.path.exists(sqlfile):
        print(f"SQL file not found: {sqlfile}")
        sys.exit(1)

    conn = sqlite3.connect(dbfile)
    try:
        with open(sqlfile, "r", encoding="utf-8") as f:
            sql = f.read()
        conn.executescript(sql)
        conn.commit()
        print(f"Executed {sqlfile} -> {dbfile}")

        # Show list of tables
        cur = conn.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;")
        tables = [r[0] for r in cur.fetchall()]
        if tables:
            print("Tables created:", ", ".join(tables))
            # show first 5 rows of each table
            for t in tables:
                cur = conn.execute(f"SELECT * FROM \"{t}\" LIMIT 5;")
                rows = cur.fetchall()
                print(f"\n-- {t} (up to 5 rows):")
                for row in rows:
                    print(row)
        else:
            print("No tables found in database.")
    finally:
        conn.close()


def main():
    p = argparse.ArgumentParser(description="Run SQL file against a database (SQLite default)")
    p.add_argument("--sqlfile", default="slq-learning/weak1.sql", help="Path to SQL file to execute")
    p.add_argument("--dbfile", default="data.db", help="SQLite database file to create/use")
    p.add_argument("--dbtype", choices=["sqlite", "mysql", "postgres"], default="sqlite", help="DB type (sqlite default)")
    args = p.parse_args()

    if args.dbtype != "sqlite":
        print("This runner currently supports SQLite only. For MySQL/Postgres, see README.md for setup steps.")
        sys.exit(1)

    run_sqlite(args.sqlfile, args.dbfile)


if __name__ == "__main__":
    main()
