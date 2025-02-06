import psycopg2
from psycopg2.extras import RealDictCursor
from fastapi import Depends

DATABASE_CONFIG = {
    "dbname": "Casino_App_Database",
    "user": "postgres",
    "password": "1234",
    "host": "localhost",
    "port": "5432"
}

# Funkcja do nawiązywania połączenia z bazą danych
def get_db_connection():
    try:
        connection = psycopg2.connect(
            dbname=DATABASE_CONFIG["dbname"],
            user=DATABASE_CONFIG["user"],
            password=DATABASE_CONFIG["password"],
            host=DATABASE_CONFIG["host"],
            port=DATABASE_CONFIG["port"],
            cursor_factory=RealDictCursor  # Opcjonalnie dla łatwego zwracania wyników w formacie dict
        )
        return connection
    except Exception as e:
        print("Błąd podczas łączenia z bazą danych:", e)
        raise

# Funkcja do pobrania sesji
def get_db():
    connection = get_db_connection()
    try:
        yield connection
    finally:
        connection.close()
