# Quick setup: Run SQL files (SQLite default)

This workspace includes a simple runner to execute SQL files using SQLite.

Files added
- `run_sql.py`: Python script that executes a SQL file against a SQLite database.

Run (SQLite):

1. From the repository root run:

```bash
python3 run_sql.py --sqlfile slq-learning/weak1.sql
```

This will create `data.db` in the current folder and execute the SQL in `slq-learning/weak1.sql`.

Custom DB file:

```bash
python3 run_sql.py --sqlfile slq-learning/weak1.sql --dbfile mydata.db
```

If `sqlite3` is missing on macOS, install via Homebrew:

```bash
brew install sqlite
```

MySQL / Postgres

- The provided runner currently supports SQLite only. To run against MySQL or Postgres you can either:
  - Use the DB's CLI (e.g., `mysql`, `psql`) and run the SQL file directly.
  - Install a Python DB driver and modify `run_sql.py` to connect (e.g., `pymysql`, `psycopg2-binary`).

Homebrew examples:

```bash
brew install mysql
brew install postgresql
```

Then use the CLI to run the file, for example with `psql`:

```bash
# for Postgres
psql -h localhost -U youruser -d yourdb -f slq-learning/weak1.sql

# for MySQL
mysql -u youruser -p yourdb < slq-learning/weak1.sql
```

If you want, I can extend `run_sql.py` to support MySQL/Postgres connection via environment variables and drivers—shall I add that?
