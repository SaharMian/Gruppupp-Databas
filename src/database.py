# database.py
import os
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError


def create_connection():
    """
    Skapa en databasanslutning (SQLAlchemy Engine)
    för att användas i applikationen.
    Endast lokal anslutning.
    """

    try:
        # Lokal utveckling (alltid)
        dbname = "librarydb_dpu7"  # ändra vid behov
        user = "postgres"
        password = os.getenv("LOCAL_DB_PASSWORD", "")
        host = "localhost"
        port = 5432

        database_url = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}"

        engine = create_engine(database_url)
        print("Ansluten till lokal databas (SQLAlchemy Engine)")

        return engine

    except SQLAlchemyError as oe:
        print("Kunde inte ansluta till databasen:")
        print(oe)
        return None

    except Exception as e:
        print("Ett oväntat fel inträffade:")
        print(e)
        return None

