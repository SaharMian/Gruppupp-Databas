import os
from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy.exc import SQLAlchemyError


Base = declarative_base()



def create_connection():
    """
    Skapa en databasanslutning (SQLAlchemy Engine)
    för lokal utveckling.
    """
    try:
        dbname = "librarydb_dpu7"   # ändra vid behov
        user = "postgres"
        password = os.getenv("LOCAL_DB_PASSWORD", "")
        host = "localhost"
        port = 5432

        database_url = f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}"

        engine = create_engine(database_url)
        print(" Ansluten till lokal databas (SQLAlchemy Engine)")
        return engine

    except SQLAlchemyError as e:
        print(" Kunde inte ansluta till databasen:")
        print(e)
        return None




engine = create_connection()

SessionLocal = sessionmaker(bind=engine)



def get_session():
    """
    Används i applikationen för att hämta en databas-session.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
