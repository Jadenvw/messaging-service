import os
import sqlite3
from pathlib import Path


BASE_URL = Path(__file__).resolve().parent


def get_connection():
    """Create a database connection with foreign key enforcement.

    Returns:
        sqlite3.Connection: A connection object to the SQLite database.
    """
    db_path = os.environ.get(
        "DATABASE_PATH", BASE_URL / "app.db"
    )  # Check if tests set a different path at runtime
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row  # Enable dict-like access to rows
    conn.execute("PRAGMA foreign_keys = ON")  # Enable foreign key support
    return conn


def initialize_database():
    schema_path = BASE_URL / "schema.sql"
    conn = get_connection()
    try:
        conn.executescript(schema_path.read_text())
        conn.commit()
    finally:
        conn.close()


if __name__ == "__main__":
    initialize_database()
    print("Database schema initialized.")
