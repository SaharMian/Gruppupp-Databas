from dotenv import load_dotenv
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Ladda miljövariabler från .env
load_dotenv()
DATABASE_URL = os.getenv("DATABASE_URL")

# Bas-klass för ORM-modeller
Base = declarative_base()

# Skapa engine och session factory
engine = create_engine(DATABASE_URL, echo=False, future=True)
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, future=True)

def get_session():
    """Returnerar en ny databas-session."""
    return SessionLocal()

# Om du kör denna fil direkt: testa anslutningen
if __name__ == "__main__":
    from sqlalchemy import text
    try:
        with get_session() as session:
            result = session.execute(text("SELECT 1"))
            print("✓ Database connection successful!", result.scalar())
    except Exception as e:
        print("✗ Database connection failed:", e)