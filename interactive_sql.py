#!/usr/bin/env python3
"""Interactive SQL shell for local development (SQLite).

Features:
- Loads a SQL file into a SQLite database (creates if missing).
- Interactive REPL to run queries and meta-commands.
- Meta-commands: .tables, .schema [table], .run <file>, .exit/.quit, .help
- Non-interactive helpers: --list-tables to print tables and exit.
"""
import argparse
import os
import sqlite3
import sys
from typing import Optional


def load_sql_into_db(sqlfile: str, conn: sqlite3.Connection):
    if not os.path.exists(sqlfile):
        raise FileNotFoundError(sqlfile)
    with open(sqlfile, "r", encoding="utf-8") as f:
        sql = f.read()
    conn.executescript(sql)
    conn.commit()


def list_tables(conn: sqlite3.Connection):
    cur = conn.execute("SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;")
    return [r[0] for r in cur.fetchall()]


def show_schema(conn: sqlite3.Connection, table: Optional[str] = None):
    if table:
        cur = conn.execute("SELECT sql FROM sqlite_master WHERE type='table' AND name=?", (table,))
        r = cur.fetchone()
        return r[0] if r else None
    else:
        cur = conn.execute("SELECT name, sql FROM sqlite_master WHERE type='table' ORDER BY name;")
        return [(r[0], r[1]) for r in cur.fetchall()]


def pretty_print_query(cur: sqlite3.Cursor):
    cols = [d[0] for d in cur.description] if cur.description else []
    rows = cur.fetchall()
    if cols:
        print("\t".join(cols))
    for row in rows:
        print("\t".join(str(x) for x in row))


def repl(conn: sqlite3.Connection):
    print("Interactive SQLite shell. Type .help for commands.")
    buffer = []
    while True:
        try:
            line = input("sql> ")
        except EOFError:
            print()
            break
        if not line:
            continue
        if line.startswith("."):
            parts = line.strip().split(maxsplit=1)
            cmd = parts[0]
            arg = parts[1] if len(parts) > 1 else None
            if cmd in (".exit", ".quit"):
                break
            if cmd == ".help":
                print(".tables  - list tables")
                print(".schema [table] - show CREATE TABLE")
                print(".run FILE - execute SQL file")
                print(".exit/.quit - exit")
                continue
            if cmd == ".tables":
                t = list_tables(conn)
                print("\n".join(t) if t else "(no tables)")
                continue
            if cmd == ".schema":
                if arg:
                    s = show_schema(conn, arg)
                    print(s or f"No such table: {arg}")
                else:
                    all_s = show_schema(conn)
                    for name, sql in all_s:
                        print(f"-- {name}\n{sql}\n")
                continue
            if cmd == ".run" and arg:
                try:
                    load_sql_into_db(arg, conn)
                    print(f"Loaded {arg}")
                except Exception as e:
                    print("Error loading file:", e)
                continue
            print("Unknown command. Type .help")

        # SQL handling: collect until semicolon
        buffer.append(line)
        if ";" not in line:
            continue
        stmt = "\n".join(buffer)
        buffer = []
        try:
            cur = conn.execute(stmt)
            if cur.description:
                pretty_print_query(cur)
            else:
                conn.commit()
                print(f"OK ({cur.rowcount} rows affected)")
        except Exception as e:
            print("Error:", e)


def main():
    p = argparse.ArgumentParser(description="Interactive SQL runner (SQLite)")
    p.add_argument("--sqlfile", default="slq-learning/weak1.sql", help="SQL file to load on start")
    p.add_argument("--dbfile", default="interactive.db", help="SQLite DB file to use/create")
    p.add_argument("--list-tables", action="store_true", help="Load SQL and print tables, then exit")
    args = p.parse_args()

    dbdir = os.path.dirname(args.dbfile)
    if dbdir and not os.path.exists(dbdir):
        os.makedirs(dbdir, exist_ok=True)

    conn = sqlite3.connect(args.dbfile)
    conn.row_factory = sqlite3.Row
    try:
        # load SQL if present
        if os.path.exists(args.sqlfile):
            try:
                load_sql_into_db(args.sqlfile, conn)
                print(f"Loaded SQL file: {args.sqlfile} -> {args.dbfile}")
            except Exception as e:
                print("Warning: failed to load SQL file:", e)

        if args.list_tables:
            t = list_tables(conn)
            if t:
                print("\n".join(t))
            else:
                print("(no tables)")
            return

        repl(conn)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
